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
    // WinningTeam winner;
}

struct Bet {
    address creator;
    WinningTeam optionId;
    //uint256 matchId // depends on how it is stored, with matchId or not
    // amount is 0.1eth for all
    // paid
}

contract SportsBetting {
    mapping(uint256 => Match) public idToMatches; // id?
    mapping(uint256 => Bet) public matchIdToPendingBets; // change this to store all bets
    // add user balances

    event BetCreated(address creator, uint256 matchId, WinningTeam winner);
    event BetFinished(address creator, uint256 matchId, bool won);
    event matchAdded(uint256 matchId, string teamA, string teamB);
    event matchRemoved(
        uint256 matchId,
        string teamA,
        string teamB,
        WinningTeam winner
    );

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

    function createBet(uint256 matchId, WinningTeam winnerSelection)
        public
        payable
    {
        // add require match exists
        require(msg.value == 0.1 ether);
        // change here to add many bets to each game
        //matchIdToPendingBets[matchId] = Bet(msg.sender, winnerSelection);

        emit BetCreated(msg.sender, matchId, winnerSelection);
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
