// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

enum WinnerSelection {
    DRAW,
    TEAM_A,
    TEAM_B
}

struct Match {
    uint id;
    string teamA;
    string teamB;
}

struct Bet {
    address creator;
    WinnerSelection winnerSelection;
}

contract SportsBetting is Ownable {
    Match[] public activeMatches;
    mapping(uint256 => bool) isMatchIdActive;
    mapping(uint256 => bool) isMatchIdFullfilled;

    mapping(uint256 => Bet[]) public matchIdToPendingBets; // change this to store all bets

    mapping(address => uint256) public balances;

    event BetCreated(address creator, uint256 matchId, WinnerSelection winner);
    event BetFinished(address creator, uint256 matchId, bool won);
    event matchAdded(uint256 matchId, string teamA, string teamB);
    event matchFinished(
        uint256 matchId,
        string teamA,
        string teamB,
        WinnerSelection winner
    );

    constructor() payable {}

    function fetchNewMatch(Match calldata _newMatch) public {
        require(
            !isMatchIdActive[_newMatch.id] &&
                !isMatchIdFullfilled[_newMatch.id],
            "Match already exists or fullfilled"
        );

        activeMatches.push(_newMatch);
        isMatchIdActive[_newMatch.id] = true;

        emit matchAdded(_newMatch.id, _newMatch.teamA, _newMatch.teamB);
    }

    function createBet(uint256 matchId, WinnerSelection winnerSelection)
        public
        payable
    {
        require(isMatchIdActive[matchId], "Wrong match ID");
        require(msg.value == 0.1 ether, "Send 0.1 eth to participate");

        matchIdToPendingBets[matchId].push(Bet(msg.sender, winnerSelection));

        emit BetCreated(msg.sender, matchId, winnerSelection);
    }

    function getAllActiveMatches() public view returns (Match[] memory) {
        Match[] memory matches = new Match[](activeMatches.length);
        for (uint i = 0; i < activeMatches.length; i++) {
            Match storage match1 = activeMatches[i];
            matches[i] = match1;
        }

        return matches;
    }
}
