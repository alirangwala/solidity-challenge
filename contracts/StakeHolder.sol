// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.6.0 <0.8.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./RewardToken.sol";

contract StakeHolder is RewardToken, Ownable {
    using SafeMath for uint256;

    constructor(address _owner, uint256 _supply) {
        _mint(_owner, _supply);
    }

    address[] internal stakers;
    mapping(address => uint256) internal stakes;

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
            _totalStakes = _totalStakes.add(stakes[stakers[i]]);
        }
        return _totalStakes;
    }

    // add check to see if sender has high enough balance to send-- make modifier
    function createStake(uint256 _stake) public {
        if (msg.sender.balance >= _stake) {
            bool isStaker = false;
            _burn(msg.sender, _stake);
            for (uint256 i = 0; i < stakers.length; i++) {
                if (msg.sender == stakers[i]) {
                    isStaker = true;
                    stakes[stakers[i]] = stakes[stakers[i]].add(_stake);
                    break;
                }
            }
            if (!isStaker) {
                addStaker(msg.sender);
                stakes[msg.sender] = _stake;
            }
        }
    }
}
