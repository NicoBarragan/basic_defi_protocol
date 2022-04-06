// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LpToken is ERC20 {

    uint public constant LP_FOR_TOKEN = 25000000000000000000;
    uint public amount;

    constructor() ERC20("LpToken", "LP") {}

    function mint(address _to, uint _amountProvided) external {
        require(_amountProvided > 0, "Amount must be greater than 0");
        amount = _amountProvided * LP_FOR_TOKEN;
        _mint(_to, amount);
    }

    function getDividend() external view returns(uint) {
        return LP_FOR_TOKEN;
    }

}