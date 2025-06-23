// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "./PointsToken.sol";

contract Campaign is Ownable {
    enum Status { Inactive, Active }
    uint8 immutable totalPerBlock = 50;
    uint16 immutable maxSubmissionsPerCampaign = 1500;
    uint256 immutable maxRewardPerCampaign = 100000 * 10 ** 18;


    struct Submission {
        string submissionString; //CID
        string model; // AI Model
        uint256 llmTokensUsed; // number of tokens used
        address submitter; //Address of the contributer
    }

    struct Block {
        uint256 campaignId; 
        Submission submission; 
    }

    struct CampaignStruct {
        Status status;
        uint256[] submissionIds;
        address winner;
    }

    // Mapping from campaignId to CampaignStruct
    mapping(uint256 => CampaignStruct) public campaigns;
    // Mapping from submissionId to Submission
    mapping(uint256 => Submission) public submissions;
    // Mapping from campaignId to total submissions (max 1500)
    mapping(uint256 => uint256) public totalSubmissions;

    mapping(address => uint256) public pendingRewards;

    // PointsToken for points
    PointsToken public pointsToken;
    // Submission counter
    uint256 public submissionCounter;
    // Campaign counter
    uint256 public campaignCounter;
    uint256 public blockID;
    // Events
    event CampaignCreated(uint256 indexed campaignId);
    event SubmissionAdded(uint256 indexed blockID);
    event WinnersSelected(uint256 indexed campaignId, uint256 winnerSubmissionId, address winner);
    event PointsDispersed(uint256 indexed campaignId, address winner, uint256 points);
    event PointsMinted(address indexed to, uint256 amount);

    constructor(address _pointsToken, address initialOwner) Ownable(initialOwner) {
        pointsToken = PointsToken(_pointsToken);
    }

    // Only owner can create a campaign
    function createCampaign() external onlyOwner returns (uint256) {
        campaignCounter++;
        campaigns[campaignCounter].status = Status.Active;
        emit CampaignCreated(campaignCounter);
        return campaignCounter;
    }

    function addSubmission(Block[] calldata _block) external onlyOwner {
        for (uint256 i = 0; i < 50; i++) {
            uint256 campaignId = _block[i].campaignId;
            string calldata submissionString = _block[i].submission.submissionString;
            string calldata model = _block[i].submission.model;
            uint256 llmTokensUsed = _block[i].submission.llmTokensUsed;
            address submitter = _block[i].submission.submitter;
            require(campaigns[campaignId].status == Status.Active, "Campaign not active");
            require(totalSubmissions[campaignId] < maxSubmissionsPerCampaign, "Max submissions reached");
            submissionCounter++;
            submissions[submissionCounter] = Submission(submissionString, model, llmTokensUsed, submitter);
            campaigns[campaignId].submissionIds.push(submissionCounter);
            totalSubmissions[campaignId]++;
        }
        emit SubmissionAdded(blockID);
        blockID++;
    }

    // Only owner can select winners
    function selectWinners(uint256 campaignId, uint256 winnerSubmissionId, address _winner) external onlyOwner {
        require(campaigns[campaignId].status == Status.Active, "Campaign not active");
        // You can add logic to mark winners if needed
        campaigns[campaignId].winner = _winner;
        pendingRewards[_winner] += maxRewardPerCampaign;
        emit WinnersSelected(campaignId, winnerSubmissionId, _winner);
        campaigns[campaignId].status = Status.Inactive; 
    }

    // Only owner can assign and disperse points
    function dispersePoints(uint256 campaignId) external onlyOwner {
        require(campaigns[campaignId].status == Status.Inactive, "Campaign Winners Not Selected");
        address winner = campaigns[campaignId].winner;
        uint256 reward = pendingRewards[winner];
        require(pointsToken.transfer(winner, reward), "Transfer failed");
        emit PointsDispersed(campaignId, winner, reward);
        pendingRewards[winner] = 0;
    }

    // Only owner can mint points using PointsToken
    function mintPoints(address to, uint256 amount) external onlyOwner {
        pointsToken.mint(to, amount);
        emit PointsMinted(to, amount);
    }
}

