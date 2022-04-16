//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// https://github.com/OpenZeppelin/

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "openzeppelin-solidity/contracts/utils/math/SafeMath.sol";

// import "./Interface/IBondingCurve.sol";
import "./BancorFormula.sol";
import "./MaxGasPrice.sol";

contract CurveBondedToken is BancorFormula, Ownable, MaxGasPrice{
    using SafeMath for uint256;

    uint256 public scale = 10**18;
    uint256 public poolBalance = 1 * scale;
    uint256 public reserveRatio;
    uint256 public bonosTokenCirculation = 1 * scale;

    constructor( uint256 _reserveRatio)  {
        reserveRatio = _reserveRatio;
        // emit CurveBondedToken("CurveBondedToken Constructed",reserveRatio);
    }

    function calculateBuyAmountByBancor(uint256 _amount)
        public
        view
        // override
        returns (uint256 mintAmount)
    {
        return
            calculatePurchaseReturn(
                bonosTokenCirculation,
                poolBalance,
                uint32(reserveRatio),
                _amount
            );
    }

    function calculateReimbursementByBancor(uint256 _amount)
        public
        view
        // override
        returns (uint256 burnAmount)
    {
        return  
            calculateSaleReturn(
                bonosTokenCirculation,
                poolBalance,
                uint32(reserveRatio),
                _amount
            );
    }

    modifier validMint(uint256 _amount) {
        require(_amount > 0, "Amount must be non-zero!");
        _;
    }

    // modifier validBurn(uint256 _amount) {
    //     require(_amount > 0, "Amount must be non-zero!");
    //     require(
    //         balanceOf(msg.sender) >= _amount,
    //         "Sender does not have enough tokens to burn."
    //     );
    //     _;
    // }

    function _caculateBuyingTokenAmount(uint256 _deposit)
        internal
        // validGasPrice
        // validMint(_deposit)
        returns (uint256)
    {
        uint256 amount = calculateBuyAmountByBancor(_deposit);
        // _mint(msg.sender, amount);
        bonosTokenCirculation = bonosTokenCirculation.add(amount);
        poolBalance = poolBalance.add(_deposit);
        // emit _caculateAmount( amount, _deposit);
        return amount;
    }

    function _caculatreimbursementAmount(uint256 _amount)
        internal
        // validGasPrice
        // validBurn(_amount)
        returns (uint256)
    {
        uint256 reimbursement = calculateReimbursementByBancor(_amount);
        poolBalance = poolBalance.sub(reimbursement);
        // _burn(msg.sender, _amount);
        // emit CurvedBurn(msg.sender, _amount, reimbursement);
        return reimbursement;
    }
}
