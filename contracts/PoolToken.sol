// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PoolToken is ERC20 {

    address public owner;

    constructor() ERC20("PoolToken", "POOL") {
        owner = msg.sender;
    }

    function mint(address _to, uint _amount) external {
        require (msg.sender == owner, "Only owner can mint");
        require(_amount > 0, "Amount must be greater than 0");
        _mint(_to, _amount);
    }


}