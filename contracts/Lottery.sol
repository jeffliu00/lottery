pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public players;
    address public prevWinner;

    function Lottery() public {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }

    function random() private view returns (uint) {
        return uint(keccak256(block.difficulty, now, players));
    }

    function pickWinner() public restricted {
        uint index = random() % players.length;
       players[index].transfer(this.balance);
       prevWinner = players[index];
        players = new address[](0);

    }

    function prevWinner() public view returns (address) {
        return prevWinner;
    }

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    function getPlayers() public view returns (address[]) {
        return players;
    }
}