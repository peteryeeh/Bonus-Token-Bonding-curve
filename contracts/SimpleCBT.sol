//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CurveBondedToken.sol";

/**
 * @title Simple Curve Bonded Token
 * @dev A token minted / burned according to an underlying bonding curve.
 *      Uses Ether as the reserve currency.
 */
contract SimpleCBT is CurveBondedToken {
    fallback() external payable {
        mint();
    }

    receive() external payable {
        mint();
    }

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _reserveRatio
    ) CurveBondedToken(_name, _symbol, _reserveRatio) {}

    function mint() public payable {
        require(msg.value > 0, "Must send ether to buy tokens.");
        _curvedMint(msg.value);
    }

    function burn(uint256 _amount) public {
        uint256 returnAmount = _curvedBurn(_amount);
        payable(msg.sender).transfer(returnAmount);
    }
}
