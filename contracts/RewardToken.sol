// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract RewardToken is ERC20 {
    constructor() ERC20("Reward", "RWT") {
        _mint(msg.sender, 1000000000000000000);
    }
}
