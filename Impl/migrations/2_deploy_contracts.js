//var Apiary = artifacts.require('Apiary');
var TownHall = artifacts.require("./TownHall.sol");

module.exports = function(deployer) {
    //deployer.deploy(Apiary(""));
    deployer.deploy(TownHall);
}

// module.exports = (deployer, network, accounts) => {
//     deployer.deploy(Apiary, accounts[0], accounts[1]);
// };
