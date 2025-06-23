// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Campaign is Ownable {
    enum Status { Inactive, Active }

    struct Submission {
        string submissionString; //CID
        string model; // AI Model
        uint256 llmTokensUsed; // number of tokens used
        address submitter; //Address of the contributer
    }

    struct CampaignStruct {
        Status status;
        uint256[] ;
    }

    // Mapping from campaignId to CampaignStruct
    mapping(uint256 => CampaignStruct) public campaigns;
    // Mapping from submissionId to Submission
    mapping(uint256 => Submission) public submissions;
    // Mapping from campaignId to total submissions (max 1500)
    mapping(uint256 => uint256) public totalSubmissions;

    // ERC20 token for points
    IERC20 public pointsToken;

    // Submission counter
    uint256 public submissionCounter;
    // Campaign counter
    uint256 public campaignCounter;

    // Events
    event CampaignCreated(uint256 indexed campaignId);
    event SubmissionAdded(uint256 indexed campaignId, uint256 indexed submissionId, address indexed submitter);
    event WinnersSelected(uint256 indexed campaignId, uint256[] winnerSubmissionIds);
    event PointsDispersed(uint256 indexed campaignId, address[] winners, uint256[] points);
    event PointsMinted(address indexed to, uint256 amount);

    constructor(address _pointsToken) {
        pointsToken = IERC20(_pointsToken);
    }

    // Only owner can create a campaign
    function createCampaign() external onlyOwner returns (uint256) {
        campaignCounter++;
        campaigns[campaignCounter].status = Status.Active;
        emit CampaignCreated(campaignCounter);
        return campaignCounter;
    }

    // Add a submission to a campaign
    function addSubmission(
        uint256 campaignId,
        string calldata submissionString,
        string calldata model,
        uint256 llmTokensUsed
    ) external returns (uint256) {
        require(campaigns[campaignId].status == Status.Active, "Campaign not active");
        require(totalSubmissions[campaignId] < 1500, "Max submissions reached");
        submissionCounter++;
        submissions[submissionCounter] = Submission(submissionString, model, llmTokensUsed, msg.sender);
        campaigns[campaignId].submissionIds.push(submissionCounter);
        totalSubmissions[campaignId]++;
        emit SubmissionAdded(campaignId, submissionCounter, msg.sender);
        return submissionCounter;
    }

    // Only owner can select winners
    function selectWinners(uint256 campaignId, uint256[] calldata winnerSubmissionIds) external onlyOwner {
        require(campaigns[campaignId].status == Status.Active, "Campaign not active");
        require(winnerSubmissionIds.length == 50, "Must select 50 winners");
        // You can add logic to mark winners if needed
        emit WinnersSelected(campaignId, winnerSubmissionIds);
    }

    // Only owner can assign and disperse points
    function dispersePoints(uint256 campaignId, address[] calldata winners, uint256[] calldata points) external onlyOwner {
        require(winners.length == points.length, "Mismatched input lengths");
        for (uint256 i = 0; i < winners.length; i++) {
            require(pointsToken.transfer(winners[i], points[i]), "Transfer failed");
        }
        emit PointsDispersed(campaignId, winners, points);
    }

    // Only owner can mint points (if the ERC20 supports minting)
    function mintPoints(address to, uint256 amount) external onlyOwner {
        // This assumes the ERC20 token has a mint function and the contract is the minter
        // You may need to use a custom interface if using OpenZeppelin's ERC20Mintable
        // Example: ICustomMintable(address(pointsToken)).mint(to, amount);
        emit PointsMinted(to, amount);
    }
}

