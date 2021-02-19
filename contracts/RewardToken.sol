// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract RewardToken is ERC20 {
    constructor(address _owner, uint256 _initialSupply) ERC20("Reward", "RWT") {
        _mint(_owner, _initialSupply);
    }
}
