//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Voting {
    struct Voter {
        bool alreadyVoted;
        uint256 vote;
    }

    struct Proposal {
        bytes32 name;
        uint256 voteCount;
    }

    bool votingState;

    mapping(address => Voter) voterz;
    Proposal[] public proposals;

    event voteAddes(address indexed voter, uint256 index);

    constructor(bytes32[] memory proposalNames) {
        for(uint256 i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }

    }

    function vote(uint256 index) public {
        require(voterz[msg.sender].alreadyVoted == false, "You've already voted!");
        proposals[index].voteCount += 1;
        require(votingState != true, "Voting is closed");
    } 

    function countHighestVotes() public returns(uint256) {
        uint256 highest;
        for(uint256 i = 0; i < proposals.length; i++) {
            if(proposals[i].voteCount > highest) {
                highest = proposals[i].voteCount;
            }
        }
        return highest;
    }

    function announceWinner() public returns(bytes32) {
        for(uint256 i = 0; i < proposals.length; i++) {
            if(proposals[i].voteCount == countHighestVotes()) {
                return proposals[i].name;
            }
        }
    }
}