// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/// @title PriceGuard — Trigger actions when price crosses thresholds on Base
contract PriceGuard is AutomationCompatibleInterface {
    AggregatorV3Interface public priceFeed;
    int256 public lowerBound;
    int256 public upperBound;

    bool public triggered;
    address public target;
    bytes public actionData;
    address public owner;

    // Base Chainlink feeds
    // ETH/USD: 0x71041dddad3595F9CEd3dCCFBe3D1F4b0a16Bb70
    // BTC/USD: 0xCCADC697c55bbB68dc5bCdf8d3CBe83CdD4E071E

    constructor(address feed, int256 lower, int256 upper, address target_, bytes memory data) {
        priceFeed = AggregatorV3Interface(feed);
        lowerBound = lower;
        upperBound = upper;
        target = target_;
        actionData = data;
        owner = msg.sender;
    }

    function checkUpkeep(bytes calldata)
        external view override returns (bool upkeepNeeded, bytes memory) {
        (, int256 price,,,) = priceFeed.latestRoundData();
        upkeepNeeded = !triggered && (price < lowerBound || price > upperBound);
    }

    function performUpkeep(bytes calldata) external override {
        (, int256 price,,,) = priceFeed.latestRoundData();
        require(!triggered && (price < lowerBound || price > upperBound), "Condition not met");
        triggered = true;
        (bool ok,) = target.call(actionData);
        require(ok, "Action failed");
    }

    function reset() external { require(msg.sender == owner); triggered = false; }
}