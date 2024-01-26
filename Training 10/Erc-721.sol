// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721Token {
    string public name;
    string public symbol;
    
    uint256 public totalTokens;
    
    mapping(uint256 => address) public tokenOwner;
    mapping(address => uint256) public ownedTokensCount;
    mapping(uint256 => address) public tokenApprovals;

    event Transfer(address indexed from, address indexed to, uint256 tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 tokenId);

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function mint() public {
        uint256 tokenId = totalTokens + 1;
        totalTokens += 1;
        
        tokenOwner[tokenId] = msg.sender;
        ownedTokensCount[msg.sender] += 1;

        emit Transfer(address(0), msg.sender, tokenId);
    }

    function transfer(address to, uint256 tokenId) public {
        require(tokenOwner[tokenId] == msg.sender, "ERC721: transfer of token that is not owned");
        require(to != address(0), "ERC721: transfer to the zero address");

        tokenOwner[tokenId] = to;
        ownedTokensCount[msg.sender] -= 1;
        ownedTokensCount[to] += 1;

        emit Transfer(msg.sender, to, tokenId);
    }

    function approve(address to, uint256 tokenId) public {
        require(tokenOwner[tokenId] == msg.sender, "ERC721: approve caller is not owner");
        tokenApprovals[tokenId] = to;

        emit Approval(msg.sender, to, tokenId);
    }

    function takeOwnership(uint256 tokenId) public {
        require(tokenApprovals[tokenId] == msg.sender, "ERC721: caller is not approved");
        address currentOwner = tokenOwner[tokenId];

        tokenOwner[tokenId] = msg.sender;
        ownedTokensCount[currentOwner] -= 1;
        ownedTokensCount[msg.sender] += 1;

        emit Transfer(currentOwner, msg.sender, tokenId);
    }
}
