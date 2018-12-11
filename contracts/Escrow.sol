pragma solidity ^0.4.24;

contract Escrow {
	uint public value;
	address public buyer;
	address public seller;

	constructor() public payable {
		seller = msg.sender;
		value = msg.value / 2;
	}
}
