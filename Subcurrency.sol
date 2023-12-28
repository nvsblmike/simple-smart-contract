//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

contract Subcurrency {
    address public currencyCreator;

    mapping(address => uint256) public balances;

    event sentTokens(address indexed sender, address reciever, uint256 amount);

    constructor() {
        currencyCreator = msg.sender;
    }

    function minterSend(address receiver, uint256 amount) public {
        require(msg.sender == currencyCreator, "You are not the currency creator");
        balances[receiver] += amount;

        emit sentTokens(msg.sender, receiver, amount);
    }

    function send(address receiver, uint256 amount) public {
        require(balances[msg.sender] > 0, "Your balance is empty, you can't send");

        balances[msg.sender] -= amount;
        balances[receiver] += amount;

        emit sentTokens(msg.sender, receiver, amount);
    }
}