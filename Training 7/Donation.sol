// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DonationContract {

    address public owner;

    mapping(address => uint256) public donations;

    event DonationReceived(address indexed donor, uint256 amount);

    event Withdrawal(address indexed owner, uint256 amount);

    modifier onlyOwner() {

        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    constructor() {

        owner = msg.sender;
    }

    receive() external payable {
        donate();
    }

    function donate() public payable {
        require(msg.value > 10, "Donation amount should be greater than 10");

        donations[msg.sender] += msg.value;
        emit DonationReceived(msg.sender, msg.value);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdraw(uint256 amount) public onlyOwner {
        require(amount > 100, "Withdrawal amount should be greater than 100");
        require(amount <= address(this).balance, "Not enough balance in the contract");

        payable(owner).transfer(amount);
        emit Withdrawal(owner, amount);
    }
}
