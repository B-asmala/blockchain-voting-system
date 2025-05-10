// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "hardhat/console.sol";

contract TimedVoting {
    struct Voter {
        bool hasVoted;
        uint voteIndex;
    }

    struct Proposal {
        string name;
        uint voteCount;
    }

    uint256 public votingDeadline;
    address public owner;
    Proposal[] public proposals;
    mapping(address => Voter) public voters; //keep track of previously voted users, using there addresses

    modifier canVote(uint proposalIndex) { 
        Voter storage sender = voters[msg.sender]; // if this is the first time voting, no entry for this sender, solidity returns a defalut Voter struct, false & 0
        require(!sender.hasVoted, "You have voted once!!!");
        require(proposalIndex < proposals.length, "No such candidate!!!");
        require(block.timestamp <= votingDeadline, "Voting has ended : <");
        _;
    }

    constructor(uint256 minutesAllowed, string[] memory candidates) {
        owner = msg.sender; // address that deployed the contract
        votingDeadline = block.timestamp + minutesAllowed * 1 minutes; //set deadline

        for (uint i = 0; i < candidates.length; i++) {
            proposals.push(Proposal({
                name: candidates[i],
                voteCount: 0
            }));
        }

        console.log("let's start voting for the cutest animal :D");
    }

    function vote(uint candidateIndex) public canVote(candidateIndex) {
        Voter storage sender = voters[msg.sender]; // references this voter

        sender.hasVoted = true;
        sender.voteIndex = candidateIndex;

        proposals[candidateIndex].voteCount += 1;
        
    }

    function getCurrentWinner() public view returns (string memory) {
        uint highestVotes = 0;
        uint winner;
        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > highestVotes) {
                highestVotes = proposals[i].voteCount;
                winner = i;
            }
        }

        return proposals[winner].name;
    }

    function getSecondsLeft() public view returns (uint256 secondsLeft) {
        return votingDeadline >= block.timestamp ? votingDeadline - block.timestamp : 0; //check to avoid underflow
    }

}

