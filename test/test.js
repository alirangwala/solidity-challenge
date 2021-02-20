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

    it('Should create a stake', async () => {
      await rewardToken.transfer(account1, 3, { from: owner });
      await rewardToken.deposit(1, { from: account1 });

      assert.equal(await rewardToken.balanceOf(account1), 2);
      assert.equal(await rewardToken.totalStakes(), 1);
    });

    // at this point truffle test started hanging so I have no idea if the tests actually pass. I've run into this problem in the past and what worked was deleting everything and re-cloning. Didn't have time to do this however
    it('Should NOT create a stake if insufficient balance', async () => {
      await rewardToken.transfer(account1, 3, { from: owner });
      await expectRevert(
        rewardToken.deposit(5, { from: account1 })
        , 'insufficient balance')
    });
  })

  it('Should reward stakeholders', async () => {
    await rewardToken.transfer(account1, 100, { from: owner });
    await rewardToken.deposit(100, { from: account1 });
    await rewardToken.rewardStakeHolders({ from: owner });

    assert.equal(await rewardToken.checkBalance(account1), 101);
  });

  it('Should withdraw full balance', async () => {
    await rewardToken.transfer(account1, 100, { from: owner });
    await rewardToken.deposit(100, { from: account1 });
    await rewardToken.rewardStakeHolders({ from: owner });

    assert.equal(await rewardToken.checkBalance(account1), 101);
    await rewardToken.withdraw({ from: account1 });
    assert.equal(await rewardToken.checkBalance(account1), 0);
  });

});