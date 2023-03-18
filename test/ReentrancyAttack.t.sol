// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;
pragma abicoder v2;

import "forge-std/Test.sol";

import "../src/Vault.sol";
import "../src/ReentrancyAttack.sol";

contract ReentrancyAttackTest is Test {
    function testReentrancyAttack() public {
        Vault vault = new Vault();

        address victim = address(1);

        vm.deal(victim, 2 ether);
        vm.prank(victim);
        vault.deposit{value: 2 ether}();

        ReentrancyAttack thief = new ReentrancyAttack((vault));

        // TODO: Steal the victim's money
        address attacker = address(2);
        vm.deal(attacker, 1 ether);
        vm.prank(attacker);
        thief.attack{value: 1 ether}();

        assertEq(address(vault).balance, 0);
        assertEq(address(victim).balance, 0);
        assertEq(address(thief).balance, 3 ether);
    }
}
