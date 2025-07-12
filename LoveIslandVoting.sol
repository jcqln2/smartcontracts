pragma solidity ^0.8.0;

contract LoveIslandVoting {
    // Struct to store couple information
    struct Couple {
        string name;
        uint256 voteCount;
        bool exists;
    }

    // Mapping of couple ID to Couple struct
    mapping(uint256 => Couple) public couples;
    uint256 public coupleCount;

    // Last update timestamp
    uint256 public lastUpdateTime;

    // Event for vote updates
    event VoteCast(uint256 indexed coupleId, string coupleName, uint256 voteCount);
    event CoupleAdded(uint256 indexed coupleId, string coupleName);

    // Constructor
    constructor() {
        lastUpdateTime = block.timestamp;
    }

    // Add a new couple
    function addCouple(string memory _name) public {
        require(bytes(_name).length > 0, "Couple name cannot be empty");
        
        couples[coupleCount] = Couple({
            name: _name,
            voteCount: 0,
            exists: true
        });
        
        emit CoupleAdded(coupleCount, _name);
        coupleCount++;
    }

    // Cast a vote for a couple
    function vote(uint256 _coupleId) public {
        require(_coupleId < coupleCount, "Invalid couple ID");
        require(couples[_coupleId].exists, "Couple does not exist");
        
        couples[_coupleId].voteCount++;
        emit VoteCast(_coupleId, couples[_coupleId].name, couples[_coupleId].voteCount);
        
        // Update timestamp if an hour has passed
        if (block.timestamp >= lastUpdateTime + 1 hours) {
            lastUpdateTime = block.timestamp;
        }
    }

    // Get all couples and their vote counts
    function getCouples() public view returns (Couple[] memory) {
        Couple[] memory allCouples = new Couple[](coupleCount);
        for (uint256 i = 0; i < coupleCount; i++) {
            if (couples[i].exists) {
                allCouples[i] = couples[i];
            }
        }
        return allCouples;
    }

    // Get the current update timestamp
    function getLastUpdateTime() public view returns (uint256) {
        return lastUpdateTime;
    }
}
