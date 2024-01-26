// SPDX-Licence-Identifier: MIT

pragma solidity ^0.8.19;

contract ArithmeticContract {
    // Function to check if a number is odd
    function oddNum(uint256 number) public pure returns (bool) {
        return number % 2 != 0;
    }

    // Function to check if a number is even
    function evenNum(uint256 number) public pure returns (bool) {
        return number % 2 == 0;
    }

    // Function to get the most significant bit of a number
    function getMostSignificantBits(
        uint256 number,
        uint8 bits
    ) public pure returns (uint256) {
        require(bits > 0 && bits <= 32, "Invalid number of bits");

        // Shift the number to the right to keep only the most significant bits
        return number >> (32 - bits);
    }
}