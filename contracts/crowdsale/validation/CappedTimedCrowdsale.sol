//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../Crowdsale.sol";

/**
 * @title CappedTimedCrowdsale
 * @dev Crowdsale accepting contributions only within a time frame and with a limit for total contributions.
 */
contract CappedTimedCrowdsale is Crowdsale {
    using SafeMath for uint256;

    uint256 private _cap;
    uint256 private _openingTime;
    uint256 private _closingTime;

    /**
     * @dev Reverts if not in crowdsale time range.
     */
    modifier onlyWhileOpen() {
        require(isOpen());
        _;
    }

    /**
     * @dev Constructor, takes crowdsale opening and closing times.
     * @param openingTime_ Crowdsale opening time
     * @param closingTime_ Crowdsale closing time
     */
    constructor(
        uint256 _rate,
        address _wallet,
        ERC20 _token,
        uint256 cap_,
        uint256 openingTime_,
        uint256 closingTime_
    ) Crowdsale(_rate, _wallet, _token) {
        // solium-disable-next-line security/no-block-members
        require(openingTime_ >= block.timestamp);
        require(closingTime_ > openingTime_);
        require(cap_ > 0);
        
        _openingTime = openingTime_;
        _closingTime = closingTime_;
        _cap = cap_;
    }

     /**
     * @return the cap of the crowdsale.
     */
    function cap() public view returns (uint256) {
        return _cap;
    }

    /**
     * @dev Checks whether the cap has been reached.
     * @return Whether the cap was reached
     */
    function capReached() public view returns (bool) {
        return weiRaised >= _cap;
    }

    /**
     * @return the crowdsale opening time.
     */
    function openingTime() public view returns (uint256) {
        return _openingTime;
    }

    /**
     * @return the crowdsale closing time.
     */
    function closingTime() public view returns (uint256) {
        return _closingTime;
    }

    /**
     * @return true if the crowdsale is open, false otherwise.
     */
    function isOpen() public view returns (bool) {
        // solium-disable-next-line security/no-block-members
        return
            block.timestamp >= _openingTime && block.timestamp <= _closingTime;
    }

    /**
     * @dev Checks whether the period in which the crowdsale is open has already elapsed.
     * @return Whether crowdsale period has elapsed
     */
    function hasClosed() public view returns (bool) {
        // solium-disable-next-line security/no-block-members
        return block.timestamp > _closingTime;
    }

    /**
     * @dev Extend parent behavior requiring to be within contributing period
     * @param beneficiary Token purchaser
     * @param weiAmount Amount of wei contributed
     */
    function _preValidatePurchase(address beneficiary, uint256 weiAmount)
        internal
        override
        onlyWhileOpen
    {
        super._preValidatePurchase(beneficiary, weiAmount);
        require(weiRaised.add(weiAmount) <= _cap);
    }
}
