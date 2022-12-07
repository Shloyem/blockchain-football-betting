// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// import "openzeppelin-contracts/token/ERC721/ERC721.sol";
// import "openzeppelin-contracts/access/Ownable.sol";
// import "openzeppelin-contracts/utils/Counters.sol";
// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";

enum WinningTeam {
    DRAW,
    TEAM_A,
    TEAM_B
}

struct Match {
    uint id;
    string teamA;
    string teamB;
    WinningTeam winner;
}

struct Bet {
    address creator;
    uint8 optionId;
    // amount is 0.1eth for all
    // paid
}

contract SportsBetting {
    mapping(uint256 => Match) public idToMatches; // id?
    mapping(uint256 => Bet) public matchIdToPendingBets;

    event BetCreated(address creator, uint256 matchId, uint256 amount);
    event BetFinished(
        address better,
        bool won,
        uint256 matchId,
        uint256 amountPaid
    );

    event matchAdded(uint256 matchId, string teamA, string teamB);
    event matchRemoved(
        uint256 matchId,
        string teamA,
        string teamB,
        WinningTeam winner
    );

    // maybe event(match) finished?

    constructor() payable {}

    function getNewMatch(Match calldata _newMatch) public {
        //adding if doesnt exist
        if (idToMatches[_newMatch.id].id == 0) {
            idToMatches[_newMatch.id].id = _newMatch.id;
            idToMatches[_newMatch.id].teamA = _newMatch.teamA;
            idToMatches[_newMatch.id].teamB = _newMatch.teamB;

            emit matchAdded(_newMatch.id, _newMatch.teamA, _newMatch.teamB);
        }
    }

    function createBet(uint id, uint8 winnerSelection) public payable {
        require(msg.value == 0.1 ether);
    }

    function getResults(Match[] calldata _matchesInfo) public {
        // assume we get finished games
    }

    function payToWin() public payable {
        // accept ether
        //require(msg.value == 0.1 ether);
        //payable(msg.sender).call{value: 2 ether}("");
    }
}
