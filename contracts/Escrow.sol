// solhint-disable-next-line
pragma solidity ^0.4.25;

contract Escrow {
	uint public value;
	address public buyer;
	address public seller;

	constructor() public payable {
		seller = msg.sender;
		value = msg.value / 2;
	}

	modifier onlyBuyer() {
		require (msg.sender == buyer);
		_;
	}

	modifier onlySeller() {
		require (msg.sender == seller);
		_;
	}


}
