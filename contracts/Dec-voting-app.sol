//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Election {

    address public owner;

    struct Candidate{
        string name;
        uint age;
    }

    struct Voter{
        string name;
        uint age;
        bool voted;
    }

    mapping(address => Candidate) public candidates;
    mapping(address => Voter) public voters;

    mapping(address => uint) public counter;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier votesOnce(address _voter) {
        require(voters[_voter].voted == true, "Has already voted");
        _;
    }

    constructor () {
        owner = msg.sender;

    }

    function vote(address _candidate) public votesOnce(msg.sender) {
        address voter = msg.sender;

        voters[voter].voted = true;
        // Get the current vote of the candidate
        uint count = counter[_candidate];
        count += 1;
        
        counter[_candidate] = count;
    }

    function addCandidate(address _candidate, string memory _name, uint _age) external onlyOwner {
        require(_candidate != address(0), "Zero address");

        Candidate memory candidate;
        candidate.name = _name;
        candidate.age = _age;

        candidates[_candidate] = candidate;
    } 

    function addVoter(address _voter, string memory _name, uint _age) external {
        require(_voter != address(0), "Zero address");

        Voter memory voter;
        voter.name = _name;
        voter.age = _age;

        voters[_voter] = voter;
    } 
}