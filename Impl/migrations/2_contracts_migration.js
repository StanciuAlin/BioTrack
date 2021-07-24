const AcquisitionCenter = artifacts.require("../contracts/AcquisitionCenter.sol");
const Apiary = artifacts.require("../contracts/Apiary.sol");
const Laboratory = artifacts.require("../contracts/Laboratory.sol");
const PharmaceuticalAndBeauty = artifacts.require("../contracts/PharmaceuticalAndBeauty.sol");
const Processor = artifacts.require("../contracts/Processor.sol");
const ProcessorStorage = artifacts.require("../contracts/ProcessorStorage.sol");
const SaleUnit = artifacts.require("../contracts/SaleUnit.sol");
const TownHall = artifacts.require("../contracts/TownHall.sol");
const Transporter = artifacts.require("../contracts/Transporter.sol");
const WarehouseUnit = artifacts.require("../contracts/WarehouseUnit.sol");


module.exports = function(deployer, network, accounts) {
    deployer.deploy(AcquisitionCenter, {from: accounts[0]});
    deployer.deploy(Apiary, {from: accounts[1]});
    deployer.deploy(Laboratory, {from: accounts[2]});
    deployer.deploy(PharmaceuticalAndBeauty, {from: accounts[3]});
    deployer.deploy(Processor, {from: accounts[4]});
    deployer.deploy(ProcessorStorage, {from: accounts[5]});
    deployer.deploy(SaleUnit, {from: accounts[6]});
    deployer.deploy(TownHall, {from: accounts[7]});
    deployer.deploy(Transporter, {from: accounts[8]});
    deployer.deploy(WarehouseUnit, {from: accounts[9]});
}