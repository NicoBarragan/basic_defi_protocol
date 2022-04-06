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
    uint public govAmount;
    uint public constant GOV_PER_BLOCK = 1;

    constructor(address _poolToken, address _lpToken, address _govToken) public {
        poolToken = PoolToken(_poolToken);
        lpToken = LpToken(_lpToken);
        govToken = GovernanceToken(_govToken);
    }

    struct TxProvided {
        uint amount;
        uint blockNumber;
    }
    mapping (address => TxProvided) public blockTokenProvided;

    function depositPool(uint _amount) external {
        require(_amount > 0, "Amount must be greater than 0");
        poolToken.transferFrom(msg.sender, address(this), _amount);
        blockTokenProvided[msg.sender] = TxProvided(_amount, block.number);
        lpToken.mint(msg.sender, _amount);
    }

    function withdrawPool() external {
        require(blockTokenProvided[msg.sender].amount > 0, "No tokens provided");
        uint amountToReturn = blockTokenProvided[msg.sender].amount / lpToken.getDividend();
        uint govAmount = blockTokenProvided[msg.sender].amount * ((block.number - blockTokenProvided[msg.sender].blockNumber) * GOV_PER_BLOCK);
        
        lpToken.transferFrom(msg.sender, address(this), blockTokenProvided[msg.sender].amount);
        
        poolToken.transfer(msg.sender, amountToReturn);
        govToken.mint(msg.sender, govAmount);
    }

}