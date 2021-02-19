// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract Staker {
    address[] internal stakers;
    mapping(address => uint256) internal stakes;

    //
    // function isStaker(address _address) public view returns (bool, uint256) {
    //     for (uint256 i = 0; i < stakers.length; i++) {
    //         if (_address == stakers[i]) return (true, i);
    //     }
    //     return (false, 0);
    // }

    function addStaker(address _staker) public {
        bool isStaker = false;
        for (uint256 i = 0; i < stakers.length; i++) {
            if (_staker == stakers[i]) {
                isStaker = true;
                break;
            }
        }
        if (!isStaker) stakers.push(_staker);
    }

    function removeStaker(address _staker) public {
        for (uint256 i = 0; i < stakers.length; i++) {
            if (_staker == stakers[i]) {
                // do this so no gap in array
                stakers[i] = stakers[stakers.length - 1];
                delete stakers[stakers.length - 1];
                break;
            }
        }
    }

    function totalStakes() public view returns (uint256) {
        uint256 _totalStakes = 0;
        for (uint256 i = 0; i < stakers.length; i++) {
            _totalStakes += stakes[stakers[i]];
        }
        return _totalStakes;
    }
}
