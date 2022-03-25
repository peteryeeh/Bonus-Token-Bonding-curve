//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../Crowdsale.sol";

/**
 * @title FixedAmountCrowdsale
 * @dev Crowdsale with the fixed amount.
 */
contract FixedAmountCrowdsale is Crowdsale {
    using SafeMath for uint256;

    uint256 private _fixed_amount;

    /**
     * @dev Constructor, takes maximum amount of wei accepted in the crowdsale.
     * @param fixed_amount_ Fixed amount of wei to be contributed
     */
    constructor(
        uint256 _rate,
        address _wallet,
        ERC20 _token,
        uint256 fixed_amount_
    ) Crowdsale(_rate, _wallet, _token) {
        require(fixed_amount_ > 0);
        _fixed_amount = fixed_amount_;
    }

    /**
     * @return the fixed amount for crowdsale.
     */
    function fixedAmount() public view returns (uint256) {
        return _fixed_amount;
    }

    /**
     * @dev Extend parent behavior requiring purchase to respect the funding cap.
     * @param beneficiary Token purchaser
     * @param weiAmount Amount of wei contributed
     */
    function _preValidatePurchase(address beneficiary, uint256 weiAmount)
        internal
        override
    {
        super._preValidatePurchase(beneficiary, weiAmount);
        require(fixedAmount() == weiAmount);
    }
}
