// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./LpToken.sol";
import "./PoolToken.sol";
import "./GovernanceToken.sol";

// import "../interfaces/ILpToken.sol";

contract LiquidityPool {

    PoolToken public poolToken;
    LpToken public lpToken;
    GovernanceToken public govToken;
    uint public tokenAmount;

    // mapping (address => uint) public poolTokenProvided;
    // mapping (address => uint) public lpTokenProvided;

    constructor(address _poolToken, address _lpToken, address _govToken) public {
        poolToken = PoolToken(_poolToken);
        lpToken = LpToken(_lpToken);
        govToken = GovernanceToken(_govToken);

    }

    function depositPool(uint _amount) external {
        require(_amount > 0, "Amount must be greater than 0");
        poolToken.transferFrom(msg.sender, address(this), _amount);
        // poolTokenProvided[msg.sender] += _amount;
        lpToken.mint(msg.sender, _amount);
    }


    function withdrawPool(uint _lpAmount) external {
        require(_lpAmount > 0, "Amount must be greater than 0");
        uint amountToReturn = _lpAmount / lpToken.getDividend();
        lpToken.transferFrom(msg.sender, address(this), _lpAmount);
        // poolTokenProvided[msg.sender] -= tokenAmount;
        
        poolToken.transfer(msg.sender, amountToReturn);
        govToken.mint(msg.sender, _lpAmount);
    }


}