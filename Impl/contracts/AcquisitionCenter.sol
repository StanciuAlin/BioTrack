// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "../interfaces/IAcquisitionCenter.sol";

import "./Apiary.sol";

/**
 * @title Acquisition Center
 * @dev The Acquisition Center SC Member
 */

contract AcquisitionCenter is IAcquisitionCenter{
    
    /** Contract states */
     address public _owner;
     
     uint public _creationTime_uint = block.timestamp;
     
     string public _acquisitionCenterName_str = "";
     string public _acquisitionCenterLocation_str = "";
     
     Apiary public apiary;
     
     struct AcquisitionCenterHoney_st {
         string honeyType_str;
         uint8 pricePerKg_uint;
         uint16 quantity_uint;
     }
     
     struct BeekeeperHoney_st {
         //uint256 _idNewHoney_uint;
         uint acquisitionCenterHoneyUID_uint;
         uint apiaryHoneyUID_uint;
         address apiaryAccount_addr;
         string honeyType_str;
         uint128 quantity_uint;
         bool isAvailable; /* flag for further delete process based on boolean Linux logical*/
         //string timestamp;
     }
    
    AcquisitionCenterHoney_st[] public honeyTypesWithPriceEvidence;
    
    /** TODO 
    * Check the function which changes the beekeeperHoneyEvidence values
    */

    //cand vine miere, o trimit imediat la analize, nu astept dupa mai multe sa fac un lot
    mapping(uint256 => BeekeeperHoney_st) public beekeeperHoneyEvidence;
    
    uint128 public _counterBeekeeperHoney_uint = 0;
    
    uint public _acquisitionCenterHoneyUID_uint = 0;

    
    /** Contract events */

    event HoneyReceivedFromApiaryEv (
        uint acquisitionCenterHoneyUID_uint,
        uint apiaryHoneyUID_uint,
        address apiaryAccount_addr,
        string honeyType,
        uint128 honeyQuantity,
        uint payment
        ); 
        
    event ReturnNonEcologicalHoneyToApiaryEv();
    
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
    
    
    /** This modifier restrict the access to a resource untill the specified time is passed */
    modifier onlyAfterPeriod(uint time) {
        require(
            block.timestamp >= time,
            "Function called too early."
        );
        _;
    }
    
    /** When a new instance is deployed, the owner address get the sender address */
    constructor () {
        _owner = msg.sender; 
    }
    
    /** Update Acquisition Center society data */
    function UpdateAcquisitionCenterInfo(
        string memory acquisitionCenterName,
        string memory acquisitionCenterLocation
    )
    public
    restricted {
        
        _acquisitionCenterName_str = acquisitionCenterName;
        _acquisitionCenterLocation_str = acquisitionCenterLocation;
    }
    
    
    /**  */
    function RegisterNewHoneyTypeInCenter(
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
            for(uint8 itHoney = 0; itHoney < honeyTypesWithPriceEvidence.length; ++itHoney) {
                /** If the honey type exists, toggle the flag to true */
                if( keccak256(bytes(honeyType)) == keccak256(bytes(honeyTypesWithPriceEvidence[itHoney].honeyType_str)) ) {
                    existFlag = true;
                }
            }
            
            if ( !existFlag ) {
                acquisitionCenterHoney.honeyType_str = honeyType;
                acquisitionCenterHoney.pricePerKg_uint = price;
                acquisitionCenterHoney.quantity_uint = 0;
                
                honeyTypesWithPriceEvidence.push(acquisitionCenterHoney);
            }
            
        }

    /** HWithPriceere, return the price quantity_uint * price din arrayul cu evidenta tipurilor de miere */ 
    function RegisterReceivedBeekeeperHoney (
        address apiaryAccount_addr,
        uint apiaryHoneyUID_uint,
        string memory honeyType_str,
        uint128 quantity_uint
        )
        external
        override {
            
            /** Flag used for searching in honey types array
             *      false = the actual value of honey type does not exist in actual list
             *      true = the actual value of honey type exists in actual list
             */
            bool existFlag = false;
            
            /** Search secquentially for the honey type in order to insert in list if it does not exist */
            for(uint8 itHoney = 0; itHoney < honeyTypesWithPriceEvidence.length; ++itHoney) {
                /** If the honey type exists, toggle the flag to true */
                if( keccak256(bytes(honeyType_str)) == keccak256(bytes(honeyTypesWithPriceEvidence[itHoney].honeyType_str)) ) {
                    existFlag = true;
                }
            }
            
            require(existFlag == true);
            
            BeekeeperHoney_st memory newBeekeeperHoney = BeekeeperHoney_st({
                //_idNewHoney_uint: _counterBeekeeperHoney_uint,
                acquisitionCenterHoneyUID_uint: _acquisitionCenterHoneyUID_uint,
                apiaryHoneyUID_uint: apiaryHoneyUID_uint,
                apiaryAccount_addr: apiaryAccount_addr,
                honeyType_str: honeyType_str,
                quantity_uint: quantity_uint,
                isAvailable: true
            });
            
            /* Check if _counterBeekeeperHoney_uint position is available to register */
            if(beekeeperHoneyEvidence[_counterBeekeeperHoney_uint].isAvailable == false) {
                beekeeperHoneyEvidence[_counterBeekeeperHoney_uint] = newBeekeeperHoney;
                _counterBeekeeperHoney_uint += 1;
            }
            
            
            /** Temporary solution for payment, 25 fix price */
            emit HoneyReceivedFromApiaryEv(
                _acquisitionCenterHoneyUID_uint,
                apiaryHoneyUID_uint,
                apiaryAccount_addr,
                honeyType_str,
                quantity_uint,
                25 * quantity_uint);
            
        }
    bool public test = true;
    function CheckHoneyAnalysysResults(
        address apiaryContract_addr
        )
        public {
        
        apiary = Apiary(apiaryContract_addr);
        
        if(!test) {
            apiary.ReturnNonEcologicalHoneyToApiary(
                beekeeperHoneyEvidence[_acquisitionCenterHoneyUID_uint].apiaryHoneyUID_uint,
                beekeeperHoneyEvidence[_acquisitionCenterHoneyUID_uint].honeyType_str,
                beekeeperHoneyEvidence[_acquisitionCenterHoneyUID_uint].quantity_uint
                );
            // resetez tipul, cantitatea
        }
        
    }
    
    
    
    
    
    
    
    
    /** Have to fix it */
    function DeleteBeekeeperHoneyData()
        public
        onlyAfterPeriod(_creationTime_uint) {
            
            for(uint256 itHoney; itHoney < _counterBeekeeperHoney_uint; ++itHoney) {
                beekeeperHoneyEvidence[itHoney].isAvailable = true;
            }
            
            /* Reset the counter again to point from start list, over-writing the existent data which is unavailable */
            _counterBeekeeperHoney_uint = 0;
        }
}
