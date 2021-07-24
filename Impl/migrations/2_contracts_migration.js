const TownHall = artifacts.require("../contracts/TownHall.sol");
const Apiary = artifacts.require("../contracts/Apiary.sol");

module.exports = function(deployer, network, accounts) {
    deployer.deploy(TownHall, {from: accounts[0]});
    deployer.deploy(Apiary, {from: accounts[1]});
}