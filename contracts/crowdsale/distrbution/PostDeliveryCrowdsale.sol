//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../validation/TimedCrowdsale.sol";

/**
 * @title PostDeliveryCrowdsale
 * @dev Crowdsale that locks tokens from withdrawal until it ends.
 */
contract PostDeliveryCrowdsale is TimedCrowdsale {
    using SafeMath for uint256;

    mapping(address => uint256) private _balances;

    constructor(
        uint256 _rate,
        address _wallet,
        ERC20 _token,
        uint256 openingTime_,
        uint256 closingTime_
    ) TimedCrowdsale(_rate, _wallet, _token, openingTime_, closingTime_) {}

    /**
     * @dev Withdraw tokens only after crowdsale ends.
     * @param beneficiary Whose tokens will be withdrawn.
     */
    function withdrawTokens(address beneficiary) public {
        require(hasClosed());
        uint256 amount = _balances[beneficiary];
        require(amount > 0);
        _balances[beneficiary] = 0;
        _deliverTokens(beneficiary, amount);
    }

    /**
     * @return the balance of an account.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev Overrides parent by storing balances instead of issuing tokens right away.
     * @param beneficiary Token purchaser
     * @param tokenAmount Amount of tokens purchased
     */
    function _processPurchase(address beneficiary, uint256 tokenAmount)
        internal override
    {
        _balances[beneficiary] = _balances[beneficiary].add(tokenAmount);
    }
}
