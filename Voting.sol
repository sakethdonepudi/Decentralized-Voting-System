// contracts/Voting.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    address public owner;
    mapping(address => bool) public voters;
    mapping(string => uint256) public votes;
    bool public votingOpen;

    event Voted(address indexed voter, string candidate);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier onlyVoters() {
        require(voters[msg.sender], "Not a registered voter");
        _;
    }

    modifier canVote() {
        require(votingOpen, "Voting is closed");
        _;
    }

    constructor() {
        owner = msg.sender;
        votingOpen = true;
    }

    function registerVoter(address _voter) external onlyOwner {
        voters[_voter] = true;
    }

    function startVoting() external onlyOwner {
        votingOpen = true;
    }

    function closeVoting() external onlyOwner {
        votingOpen = false;
    }

    function vote(string memory _candidate) external onlyVoters canVote {
        require(bytes(_candidate).length > 0, "Invalid candidate name");
        votes[_candidate]++;
        emit Voted(msg.sender, _candidate);
    }
}
