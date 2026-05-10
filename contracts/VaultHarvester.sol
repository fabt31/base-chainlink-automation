// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol";

interface IYieldVault {
    function harvest() external;
    function pendingYield() external view returns (uint256);
    function lastHarvest() external view returns (uint256);
}

/// @title VaultHarvester — Auto-harvest yield vaults on Base via Chainlink
contract VaultHarvester is AutomationCompatibleInterface {
    address public vault;
    uint256 public minHarvestInterval = 24 hours;
    uint256 public minYieldThreshold = 1e16; // 0.01 ETH equivalent

    address public owner;

    event Harvested(address indexed vault, uint256 timestamp);

    constructor(address vault_) {
        vault = vault_;
        owner = msg.sender;
    }

    function checkUpkeep(bytes calldata)
        external view override returns (bool upkeepNeeded, bytes memory) {
        IYieldVault v = IYieldVault(vault);
        bool timeElapsed = block.timestamp - v.lastHarvest() >= minHarvestInterval;
        bool hasYield = v.pendingYield() >= minYieldThreshold;
        upkeepNeeded = timeElapsed && hasYield;
    }

    function performUpkeep(bytes calldata) external override {
        IYieldVault v = IYieldVault(vault);
        require(block.timestamp - v.lastHarvest() >= minHarvestInterval, "Too soon");
        require(v.pendingYield() >= minYieldThreshold, "Yield too low");
        v.harvest();
        emit Harvested(vault, block.timestamp);
    }

    function setParams(uint256 interval, uint256 threshold) external {
        require(msg.sender == owner, "Not owner");
        minHarvestInterval = interval;
        minYieldThreshold = threshold;
    }
}