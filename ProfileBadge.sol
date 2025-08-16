solidity
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Minimal ProfileBadge contract for Universal Profiles
contract ProfileBadge is ERC721, Ownable {
    uint256 private _tokenIdCounter;
    
    // Mapping to store badge metadata (e.g., IPFS hash)
    mapping(uint256 => string) private _badgeMetadata;
    
    constructor() ERC721("ProfileBadge", "PBDG") Ownable(msg.sender) {
        _tokenIdCounter = 0;
    }
    
    // Mint a badge to a Universal Profile
    function mintBadge(address to, string memory metadataURI) public onlyOwner returns (uint256) {
        _tokenIdCounter++;
        uint256 newBadgeId = _tokenIdCounter;
        
        _mint(to, newBadgeId);
        _badgeMetadata[newBadgeId] = metadataURI;
        
        return newBadgeId;
    }
    
    // Get badge metadata
    function getBadgeMetadata(uint256 badgeId) public view returns (string memory) {
        require(_exists(badgeId), "Badge does not exist");
        return _badgeMetadata[badgeId];
    }
    
    // Override tokenURI to return metadata URI
    function tokenURI(uint256 badgeId) public view override returns (string memory) {
        return getBadgeMetadata(badgeId);
    }
}
