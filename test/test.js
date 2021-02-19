const { expectRevert } = require('@openzeppelin/test-helpers')

const RewardToken = artifacts.require('RewardToken')
const StakeHolder = artifacts.require("StakeHolder")
const BigNumber = require('big-number');


contract('RewardToken', (accounts) => {
  let rewardToken;
  const tokens = BigNumber(1000000000000000000) //10^18
  const [owner, account1] = [accounts[0], accounts[1]];

  describe('Staking', () => {
    beforeEach(async () => {
      rewardToken = await StakeHolder.new(
        owner,
        tokens.toString(10)
      );

    });

    it('createStake creates a stake.', async () => {
      await rewardToken.transfer(account1, 3, { from: owner });
      await rewardToken.createStake(1, { from: account1 });

      assert.equal(await rewardToken.balanceOf(account1), 2);
      assert.equal(
        await rewardToken.totalSupply().toString(10),
        tokens.minus(1).toString(10)
      );
      assert.equal(await rewardToken.totalStakes(), 1);
    });
  })
});