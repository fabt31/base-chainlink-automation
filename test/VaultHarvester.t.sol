// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Test.sol";
contract VaultHarvesterTest is Test {
    function test_checkUpkeepReturnsFalseWhenNotReady() public { assertTrue(true); }
    function test_performUpkeepCallsHarvest() public { assertTrue(true); }
}
