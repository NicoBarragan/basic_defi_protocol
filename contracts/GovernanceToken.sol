// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract GovernanceToken is ERC20 {

    IERC20 public LpToken;
    uint constant GOV_FOR_LP = 250000000000000000000;
    uint public amount;

    constructor() ERC20("GovernanceToken", "GOV") {
    }

    function mint(address _to, uint _lpReturned) external {
        require(_lpReturned > 0, "Amount must be greater than 0");
        amount = _lpReturned * GOV_FOR_LP;
        _mint(_to, amount);
    }

}