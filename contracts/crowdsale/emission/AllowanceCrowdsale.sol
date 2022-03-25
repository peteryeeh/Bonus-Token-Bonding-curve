//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "../Crowdsale.sol";

/**
 * @title AllowanceCrowdsale
 * @dev Extension of Crowdsale where tokens are held by a wallet, which approves an allowance to the crowdsale.
 */
contract AllowanceCrowdsale is Crowdsale {
    using SafeMath for uint256;

    address public tokenWallet;

    /**
     * @dev Constructor, takes token wallet address.
     * @param _tokenWallet Address holding the tokens, which has approved allowance to the crowdsale
     */
    constructor(
        uint256 _rate,
        address _wallet,
        ERC20 _token,
        address _tokenWallet
    ) Crowdsale(_rate, _wallet, _token) {
        require(_tokenWallet != address(0));
        tokenWallet = _tokenWallet;
    }

    /**
     * @dev Checks the amount of tokens left in the allowance.
     * @return Amount of tokens left in the allowance
     */
    function remainingTokens() public view returns (uint256) {
        return token.allowance(tokenWallet, address(this));
    }

    /**
     * @dev Overrides parent behavior by transferring tokens from wallet.
     * @param _beneficiary Token purchaser
     * @param _tokenAmount Amount of tokens purchased
     */
    function _deliverTokens(address _beneficiary, uint256 _tokenAmount)
        internal
        override
    {
        token.transferFrom(tokenWallet, _beneficiary, _tokenAmount);
    }
}
