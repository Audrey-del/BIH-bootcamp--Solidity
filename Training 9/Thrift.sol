// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ThriftContract {
    address public owner;
    mapping(address => uint256) public deposits;
    mapping(address => uint256) public depositTimestamp;
    
    uint256 public interestRate = 5; // 5% interest rate per year
    uint256 public withdrawalPeriod = 365 days; // 1 year withdrawal period

    event Deposit(address indexed depositor, uint256 amount, uint256 timestamp);
    event Withdrawal(address indexed withdrawer, uint256 amount, uint256 interest);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        deposit();
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount should be greater than 0");

        deposits[msg.sender] += msg.value;
        depositTimestamp[msg.sender] = block.timestamp;

        emit Deposit(msg.sender, msg.value, block.timestamp);
    }

    function calculateInterest(uint256 amount, uint256 duration) internal view returns (uint256) {
        return (amount * interestRate * duration) / (100 * 365 days);
    }

    function withdraw() public {
        require(deposits[msg.sender] > 0, "No deposit found");

        uint256 depositAmount = deposits[msg.sender];
        uint256 depositTime = block.timestamp - depositTimestamp[msg.sender];
        
        require(depositTime >= withdrawalPeriod, "Withdrawal period not reached");

        uint256 interest = calculateInterest(depositAmount, depositTime);
        uint256 totalAmount = depositAmount + interest;

        // Reset user's deposit information
        deposits[msg.sender] = 0;
        depositTimestamp[msg.sender] = 0;

        payable(msg.sender).transfer(totalAmount);

        emit Withdrawal(msg.sender, depositAmount, interest);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function setInterestRate(uint256 newInterestRate) public onlyOwner {
        interestRate = newInterestRate;
    }

    function setWithdrawalPeriod(uint256 newWithdrawalPeriod) public onlyOwner {
        withdrawalPeriod = newWithdrawalPeriod;
    }
}
