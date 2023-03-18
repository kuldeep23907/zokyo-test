// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;
pragma abicoder v2;

import "forge-std/Test.sol";

import "../src/Vault.sol";
import "../src/FlashLoanAttack.sol";

contract FlashLoanAttackTest is Test {
    function testFlashLoanAttack() public {
        Vault vault = new Vault();

        address victim = address(1);

        vm.deal(victim, 2 ether);
        vm.prank(victim);
        vault.deposit{value: 2 ether}();

        // TODO: Steal the victim's money
        FlashLoanAttack thief = new FlashLoanAttack((vault));
        address attacker = address(2);
        vm.prank(attacker);

        thief.flashLoanAttackStart();
        thief.flashloanSteal();

        assertEq(address(vault).balance, 0);
        assertEq(address(victim).balance, 0);
        assertEq(address(thief).balance, 2 ether);
    }
}
