pragma solidity ^0.4.25;

contract Escrow {
	uint public value;
	address public buyer;
	address public seller;
	enum State { Created, Confirmed, Shipped, Completed, Aborted }
	State public state;

	constructor() public payable {
		seller = msg.sender;
		value = msg.value / 2;
		state = State.Created;
	}

	modifier onlyBuyer() {
		require (msg.sender == buyer);
		_;
	}

	modifier onlySeller() {
		require (msg.sender == seller);
		_;
	}

	modifier inState(State requiredState) {
		require (state == requiredState);
		_;
	}

	function abort() public onlySeller inState(State.Created) {
		state = State.Aborted;
		seller.transfer(address(this).balance);
	}

	function confirmPurchase() public payable inState(State.Created) {
		require (msg.value == value * 2);
		buyer = msg.sender();
		state = State.Confirmed;
	}

	function ship() public onlySeller inState(State.Confirmed) {
		state = State.Shipped;
	}

	function confirmReceived() public onlyBuyer inState(State.Shipped) {
		state = State.Completed;
		buyer.transfer(value);
		seller.transfer(address(this).balance);
	}
}
