const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
require('chai').use(require('chai-as-promised')).should();
const { Web3 } = require('web3');
const { isAddress } = require("ethers/lib/utils");

describe("SportsBetting", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deploySportsBettingFixture() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();

    const SportsBetting = await ethers.getContractFactory("SportsBetting");
    const sportsBetting = await SportsBetting.deploy({ value: ethers.utils.parseEther("1") });

    return { sportsBetting, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("Should be deployed with 1 ether", async function () {
      const { sportsBetting } = await loadFixture(deploySportsBettingFixture);
      console.log("sportsBetting %s", sportsBetting.address);
      const balance = await ethers.provider.getBalance(sportsBetting.address);
      balance.should.equal(ethers.utils.parseEther("1"));
    });
  });

  describe("Match creation", function () {
    it("Should create a match successfully", async function () {
      const { sportsBetting } = await loadFixture(deploySportsBettingFixture);
      await sportsBetting.createMatch([100, 'Croatia', 'Brazil']);

      let AllMatchesFirst = (await sportsBetting.getAllActiveMatches())[0];
      AllMatchesFirst.id.should.equal("100");
      AllMatchesFirst.teamA.should.equal("Croatia");
      AllMatchesFirst.teamB.should.equal("Brazil");

      let activeMatch = await sportsBetting.activeMatches(0);
      activeMatch.id.should.equal("100");
      activeMatch.teamA.should.equal("Croatia");
      activeMatch.teamB.should.equal("Brazil");
    });

    it("Should emit match created event", async function () {
    });

    it("Should fail to add twice the same game ID", async function () {
      const { sportsBetting } = await loadFixture(deploySportsBettingFixture);
      const SAME_GAME_ID = 100;

      await sportsBetting.createMatch([SAME_GAME_ID, 'Croatia', 'Brazil']);
      await sportsBetting.createMatch([SAME_GAME_ID, 'France', 'USA']).
        should.be.rejectedWith("Match already exists or fullfilled");
    });
  });

  describe("Bet creation", function () {
    it("Should create a bet successfully", async function () {
    });

    it("Should emit bet created event", async function () {
    });
  });
});
