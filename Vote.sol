pragma solidity >= 0.6.0;


contract Voting {
    
    enum voterStatus{notRegistered, registered, voted}
    
    //Takes registered candidates information
    struct Elect {
        
        string _name;
        string _party;
        uint numVotes;
        uint candidateIndex;
        bool candidate;
      
    }
    //Takes registered voters information
    struct Vote {
        string name;
        string party;
        bool voted;
        uint voterIndex;
        voterStatus  _state;
        
        
    }
    
    mapping(address => Elect) public election;
    mapping(address => Vote) public voter;
    
   
   
    
  
    //Register to be a candidate in the election
    //Candidate must register to vote first and can't register twice
    function registerCandidate(string memory _name, string memory _party) public {
    require(voter[msg.sender].voted == true, "Please register to vote");
    require(election[msg.sender].candidate == false, "You're a candidate");
    election[msg.sender]._name = _name;
    election[msg.sender]._party = _party;
    election[msg.sender].candidateIndex++;
    election[msg.sender].candidate = true;
    
    }
    
    //Register user as a voter. Takes name and party
    function registerVoter(string memory _name, string memory _party) public {
    require(voter[msg.sender]._state == voterStatus.notRegistered, "Already registered");
    require(voter[msg.sender].voted == false);
    voter[msg.sender].name = _name;
    voter[msg.sender].party = _party;
    voter[msg.sender]._state = voterStatus.registered;
    voter[msg.sender].voted = true;
    voter[msg.sender].voterIndex++;
    
    }
    
    //Vote for the candidate by their address
    //Gives +1 to candidates number of votes
    //changes enum state to voted
    function setVote(address vote) public {
        require(voter[msg.sender]._state == voterStatus.registered, "Not registered or already voted");
        require(election[vote].candidate == true, "Not a candidate");
       election[vote].numVotes++;
       voter[msg.sender]._state = voterStatus.voted;
       
    }


}
