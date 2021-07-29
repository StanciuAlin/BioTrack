// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "../interfaces/IAcquisitionCenter.sol";

/**
 * @title Acquisition Center
 * @dev The Acquisition Center SC Member
 */

contract AcquisitionCenter is IAcquisitionCenter{
    
    /** Contract states */
     address public _owner;
     
     uint public creationTime_uint = block.timestamp;
     
     string public _acquisitionCenterName_str = "";
     string public _acquisitionCenterLocation_str = "";
     
     
     struct AcquisitionCenterHoney_st {
         string _honeyType_str;
         uint8 _pricePerKg_uint;
         uint16 _quantity_uint;
     }
     
     struct BeekeeperHoney_st {
         //uint256 _idNewHoney_uint;
         address _apiaryAccount_addr;
         string _honeyType_str;
         uint128 _quantity_uint;
         bool _isAvailable; /* flag for further delete process */
         //string timestamp;
     }
    
    AcquisitionCenterHoney_st[] public honeyTypesEvidence;
    
    /** TODO 
    * Check the function which changes the beekeeperHoneyEvidence values
    */

    mapping(uint256 => BeekeeperHoney_st) public beekeeperHoneyEvidence;
    
    uint128 public _counterBeekeeperHoney_uint = 0;
    
    //BeekeeperHoney_st[] public beekeeperHoneyEvidence;
    
    /** Contract events */

    /** TODO 
    * Event rised when the analyse report is requested.
    */
    
    /** Contract access modifiers */
    
    /** This modifier restrict the access to the creator of the smart contract (the owner) */
    modifier restricted() {
        require (
        msg.sender == _owner,
        "This function is restricted to the contract's owner"
        );
        _;
    }
    
    modifier onlyAfterPeriod(uint _time) {
        require(
            block.timestamp >= _time,
            "Function called too early."
        );
        _;
    }
    
    /** When a new instance is deployed, the owner address get the sender address */
    constructor () {
        _owner = msg.sender; 
    }
    
    /** Update Acquisition Center society data */
    function UpdateAcquisitionCenterData(
        string memory acquisitionCenterName,
        string memory acquisitionCenterLocation
    )
    public
    restricted {
        
        _acquisitionCenterName_str = acquisitionCenterName;
        _acquisitionCenterLocation_str = acquisitionCenterLocation;
    }
    
    
    /**  */
    function RegisterNewHoneyType(
        string memory honeyType,
        uint8 price
        )
        public
        restricted {
             
            /** Flag used for searching in honey types array
             *      false = the actual value of honey type does not exist in actual list
             *      true = the actual value of honey type exists in actual list
             */
            bool existFlag = false;
            
            /** Create a new structure object */
            AcquisitionCenterHoney_st memory acquisitionCenterHoney;
            
            /** Search secquentially for the honey type in order to insert in list if it does not exist */
            for(uint8 itHoney = 0; itHoney < honeyTypesEvidence.length; ++itHoney) {
                /** If the honey type exists, toggle the flag to true */
                if( keccak256(bytes(honeyType)) == keccak256(bytes(honeyTypesEvidence[itHoney]._honeyType_str)) ) {
                    existFlag = true;
                }
            }
            
            if ( !existFlag ) {
                acquisitionCenterHoney._honeyType_str = honeyType;
                acquisitionCenterHoney._pricePerKg_uint = price;
                acquisitionCenterHoney._quantity_uint = 0;
                
                honeyTypesEvidence.push(acquisitionCenterHoney);
            }
            
        }

    /** Here, return the price quantity_uint * price din arrayul cu evidenta tipurilor de miere */ 
    function RegisterBeekeeperHoney (
        address apiaryAccount_addr,
        string memory honeyType_str,
        uint128 quantity_uint
        )
        external
        override {
            
            BeekeeperHoney_st memory newBeekeeperHoney = BeekeeperHoney_st({
                //_idNewHoney_uint: _counterBeekeeperHoney_uint,
                _apiaryAccount_addr: apiaryAccount_addr,
                _honeyType_str: honeyType_str,
                _quantity_uint: quantity_uint,
                _isAvailable: false
            });
            
            /* Check if _counterBeekeeperHoney_uint position is available to register */
            //if(beekeeperHoneyEvidence[_counterBeekeeperHoney_uint]._isAvailable != false) {
            {    beekeeperHoneyEvidence[_counterBeekeeperHoney_uint] = newBeekeeperHoney;
                _counterBeekeeperHoney_uint += 1;
            }
            
        }
    
    /**  */
    function DeleteBeekeeperHoneyData()
        public
        onlyAfterPeriod(creationTime_uint + 365 days) {
            
            for(uint256 itHoney; itHoney < _counterBeekeeperHoney_uint; ++itHoney) {
                beekeeperHoneyEvidence[itHoney]._isAvailable = true;
            }
            
            /* Reset the counter again to point from start list, over-writing the existent data which is unavailable */
            _counterBeekeeperHoney_uint = 0;
        }
}
