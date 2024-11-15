// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;

        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        return a - b;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        return a / b;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "SafeMath: modulo by zero");
        return a % b;

    }
}

contract TicTacToe {
    // Game state variables
    address payable player1;
    address payable player2;
    uint8[9] board;
    uint8 currentPlayer;
    bool gameEnded;

    // Game fee
    uint256 gameFee;

    // Constructor
    constructor(uint256 _gameFee) {
        gameFee = _gameFee;
    }
    
    // Function to register a player
    function registerPlayer() external payable {
        require(!gameEnded, "Game has already ended");
        require(msg.value == gameFee, "Incorrect fee");

        if (player1 == address(0)) {
            player1 = payable(msg.sender);
        } else {
            require(player2 == address(0), "Game is full");
            player2 = payable(msg.sender);
        }
    }

    // Function to make a move
    bool _locked;

    function makeMove(uint8 position) external {
        require(!_locked, "Reentrancy Guard");
        _locked = true;
        require(player1 == msg.sender || player2 == msg.sender, "Not your turn"); // or any other correct logic to check for current player.
        require(board[position] == 0, "Position already taken");

        board[position] = currentPlayer;
        currentPlayer = currentPlayer == 1 ? 2 : 1;

        // Check for win or draw
        if (isWinner(currentPlayer)) {
            gameEnded = true;
            // Distribute rewards to the winner
        } else if (isBoardFull()) {
            gameEnded = true;
            // Handle draw scenario
        }
    }

    // Functions to check for win or draw (implement logic)
    function isWinner(uint8 player) private view returns (bool) {
        // ...
    }

    function isBoardFull() private view returns (bool) {
        // ...
    }
}