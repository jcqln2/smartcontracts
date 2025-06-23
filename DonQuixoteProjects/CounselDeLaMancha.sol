// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CounselDeLaMancha {

   /** 
     * array holding 20 different responses, inspired by Don Quixote.
     */
    string[20] private responses = [
        "By the valor of my lance, thy quest shall find glorious triumph!",
        "Fear not, for the stars proclaim thy venture most auspicious!",
        "As I am a knight, thy path is blessed by fortune's radiant hand!",
        "Verily, the winds of destiny propel thee to victory!",
        "O noble soul, thy desire shall bloom like roses in La Mancha!",
        "By my honor, the heavens decree thy success infallible!",
        "Rejoice, for thy aim is as true as my sword's edge!",
        "In truth, thy pursuit shall be crowned with laurels eternal!",
        "Alas, the fates weave a tapestry of woe for this endeavor.",
        "Nay, the stars align against thee, brave though thou art.",
        "O weary traveler, this path leads but to folly's abyss.",
        "By my shield, this quest is doomed as a windmill's defiance.",
        "Sorrow betide, for destiny bars thy way with iron gates.",
        "The heavens frown upon this venture, noble heart.",
        "Woe, thy aim falters like a squire sans courage.",
        "In truth, this pursuit is as vain as chasing enchanted enchanters.",
        "Perchance, the mists of fate obscure the outcome of thy query.",
        "Who can say? The winds of La Mancha whisper riddles e'en to knights.",
        "The oracle ponders, for thy quest dances betwixt light and shadow.",
        "Mayhap, the answer lies in deeds yet unwrought by thy hand."
    ];

    /**
     * this event is triggered when a user asks a question and receives a response from the counsel
     * @param user is the address of the user who asked a question
     * @param response is the message provided by "the counsel"
     */
    event QuestionAsked(address indexed user, string response);

    /**
     * function to ask a question + receive a response
     * Response is chosen randomly from predefined set of 20 responses
     * Randomness is created by the block timestamp, sender's address, and block number
     * 
     * @return response in string format
     */
    function askOracle() public returns (string memory) {
        // pseudo-random number based on block timestamp, sender, and block number
        uint256 randomIndex = uint256(
            keccak256(abi.encodePacked(block.timestamp, msg.sender, block.number))
        ) % 20;

        string memory response = responses[randomIndex];

        // trigger event
        emit QuestionAsked(msg.sender, response);

        return response;
    }

    // view all possible responses for front end
    function getAllResponses() public view returns (string[20] memory) {
        return responses;
    }
}