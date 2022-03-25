//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../Crowdsale.sol";

/**
 * @title MaxAmountCrowdsale
 * @dev Crowdsale with the max amount.
 */
contract MaxAmountCrowdsale is Crowdsale {
    using SafeMath for uint256;

    uint256 private _max_amount;

    /**
     * @dev Constructor, takes maximum amount of wei accepted in the crowdsale.
     * @param max_amount_ Max amount of wei to be contributed
     */
    constructor(
        uint256 _rate,
        address _wallet,
        ERC20 _token,
        uint256 max_amount_
    ) Crowdsale(_rate, _wallet, _token) {
        emit DebugUint256("max_amount_", max_amount_, max_amount_ > 0);
        require(max_amount_ > 0);
        _max_amount = max_amount_ * 1e9;
    }

    /**
     * @return the max amount for crowdsale.
     */
    function maxAmount() public view returns (uint256) {
        return _max_amount;
    }

    /**
     * @dev Extend parent behavior requiring purchase to respect the funding cap.
     * @param beneficiary Token purchaser
     * @param weiAmount Amount of wei contributed
     */
    function _preValidatePurchase(address beneficiary, uint256 weiAmount)
        internal
        virtual
        override
    {
        super._preValidatePurchase(beneficiary, weiAmount);
        emit DebugUint256("maxAmount", maxAmount(), maxAmount() >= weiAmount);
        emit DebugUint256("weiAmount", weiAmount, maxAmount() >= weiAmount);
        require(maxAmount() >= weiAmount);
    }
}
