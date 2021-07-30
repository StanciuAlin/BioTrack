// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./TownHall.sol";
import "./AcquisitionCenter.sol";

import "../interfaces/IApiary.sol";

/**
 * @title Apiary
 * @dev The Apiary SC Member
 */

contract Apiary is IApiary {
    
    /** Contract states */

    address public _owner;

    string public _producerName_str = "";
    string public _producerLocation_str = "";
    string public _apiaryName_str = "";
    string public _apiaryLocation_str = "";
    string public _honeyTypeAvailableInApiary_str = ""; 
    string public _honeyTypeAvailableToSell_str = "";
    
    uint128 public _quantity_uint = 0;
    
    uint public _apiaryHoneyUID_uint = 1;
    
    struct HoneyInApiaryToSell_st {
        string honeyType;
        uint128 quantity;
    }

    mapping (uint => HoneyInApiaryToSell_st) public honeyInApiaryToSellEvidence;

    /** One instace of Townhall to get the valid license */
    TownHall public townHall;
    
    /** One instace of Acquisition Center to sell the honey */
    AcquisitionCenter public acquisitionCenter;
    
    /** Contract events */

    /** Log honey and quantity when the Apiary register a new honey input */
    event RegisterHoneyEv(
        uint apiaryHoneyUID,
        string apiaryHoney,
        uint128 quantity,
        uint256 totalQuantity,
        uint timestamp
    );
    
    /** Contract access modifiers */
    
    /** This modifier restrict the access to the creator of the smart contract (the owner) */
    modifier restricted() {
        require (
        msg.sender == _owner,
        "This function is restricted to the contract's owner"
        );
        _;
    }
    
    /** When a new instance is deployed, the owner address get the sender address */
    constructor () {
        _owner = msg.sender; 
    }

    /** 
    *   If the Apiary can provide a new honey type, it can append to the existent list of honey types 
    *   Temporary limitation: only one honey type per Apiary
    */
    function AddNewHoneyTypeInApiary(
        string memory honeyType
        ) 
    public 
    restricted {
        
        //require(keccak256(bytes(_honeyTypeAvailableInApiary_str)) == keccak256(bytes("")));
        _honeyTypeAvailableInApiary_str = string(abi.encodePacked(_honeyTypeAvailableInApiary_str, honeyType));
    }

    /** Set the quantity for honey type
        Example set 1000kg when you want to sells or set to 0kg when the honey is sold */
    function AddHoneyInApiaryToSell(
        string memory apiaryHoney, 
        uint128 quantity
        ) 
    public 
    restricted {
        
        _honeyTypeAvailableToSell_str = apiaryHoney;
        require(keccak256(bytes(_honeyTypeAvailableToSell_str)) == keccak256(bytes(_honeyTypeAvailableInApiary_str)));
        
        /* Update global honey quantity */
        _quantity_uint += quantity;
        
        HoneyInApiaryToSell_st memory newHoneyToSell = HoneyInApiaryToSell_st({
            honeyType: apiaryHoney,
            quantity: quantity
        });
        
        honeyInApiaryToSellEvidence[_apiaryHoneyUID_uint] = newHoneyToSell;
        
        _apiaryHoneyUID_uint += 1;
        
        emit RegisterHoneyEv(_apiaryHoneyUID_uint, apiaryHoney, quantity, _quantity_uint, block.timestamp);
    }

    /** Update Apiary keeper personal data */
    function UpdatePersonalData(
        string memory producerName,
        string memory producerLocation
    )
    public
    restricted {
        
        _producerName_str = producerName;
        _producerLocation_str = producerLocation;
    }

    /** Update Apiary society data */
    function UpdateApiaryData(
        string memory apiaryName,
        string memory apiaryLocation
    )
    public
    restricted {
        
        _apiaryName_str = apiaryName;
        _apiaryLocation_str = apiaryLocation;
    }

    /** The Apiary member has to register to the TownHall */   
    function RegisterAtTownHall(
        address townHallContract_addr
        ) 
    public 
    restricted {
        
        townHall = TownHall(townHallContract_addr);
        townHall.UpdateTotalBeekeepers();
    }

    /** The Apiary member has to register to the Acquisition Center */   
    function RegisterAtAcquisitionCenter(
        address acquisitionCenterContract_addr
        ) 
    public 
    restricted {
        
        acquisitionCenter = AcquisitionCenter(acquisitionCenterContract_addr);
    }


    /** The Apiary request a new valid License to be able to market the honey */
    function RequestLicense() 
    public 
    payable
    restricted {

        townHall.EmitLicense(
            _owner,
            _producerName_str,
            _producerLocation_str,
            _apiaryName_str,
            _apiaryLocation_str,
            _honeyTypeAvailableInApiary_str
            );
    }
    
    /**  */
    
    // counter separat pentru ToSell array
    // quantity scade pentru fiecare item din array, nu -= ...
    function SellHoney(
        uint apiaryHoneyUIDToSell,
        string memory apiaryHoney, 
        uint128 quantity
        )
        public
        payable
        restricted {
            
            /* Apiary available honey should be the same type like the honey which is sold */
            require(keccak256(bytes(_honeyTypeAvailableInApiary_str)) == keccak256(bytes(apiaryHoney)));
            
            
            if (apiaryHoneyUIDToSell == 0) {
                require(honeyInApiaryToSellEvidence[_apiaryHoneyUID_uint].quantity >= quantity);
                
                honeyInApiaryToSellEvidence[_apiaryHoneyUID_uint].quantity -= quantity;
                
                /* Sell from the last honey registered */
                
                acquisitionCenter.RegisterReceivedBeekeeperHoney(
                _owner,
                _apiaryHoneyUID_uint,
                apiaryHoney,
                quantity
                );
            } else { /* Delete the honey registered with apiaryHoneyUIDToSell unique ID*/
                //require(honeyInApiaryToSellEvidence[apiaryHoneyUIDToSell].quantity >= quantity);
                
                honeyInApiaryToSellEvidence[apiaryHoneyUIDToSell].quantity -= quantity;
                
                acquisitionCenter.RegisterReceivedBeekeeperHoney(
                _owner,
                _apiaryHoneyUID_uint,
                honeyInApiaryToSellEvidence[apiaryHoneyUIDToSell].honeyType,
                quantity
                );
            }
            
            // require(_quantity_uint >= quantity);
            
            _quantity_uint -= quantity;
            
            /* If there is no other honey of current type, reset the apiary available honey */
            if(_quantity_uint == 0) {
                _honeyTypeAvailableToSell_str = "";
                _honeyTypeAvailableInApiary_str = "";
            }
            
           
            _apiaryHoneyUID_uint += 1;
            
            /* Here should be an event triggered */
            
            /** TODO 
            * Event rised when the honey is solt to one Acquisition Center.
            */
        }
        
        //verfic
    function ReturnNonEcologicalHoneyToApiary (
        uint apiaryHoneyUID_uint,
        string memory honeyType_str,
        uint128 quantity_uint
        ) 
        external
        override {
            //require ( _honeyTypeAvailableInApiary_str == "" && _honeyTypeAvailableToSell_str == )
            
            /* Check if there is honey in apiary stock with the same type*/
            if(_quantity_uint > 0) {
                _quantity_uint += quantity_uint;
                
                HoneyInApiaryToSell_st memory newHoneyReturned = HoneyInApiaryToSell_st({
                    honeyType: honeyType_str,
                    quantity: quantity_uint
                });
                
                honeyInApiaryToSellEvidence[_apiaryHoneyUID_uint] = newHoneyReturned;
            }
        }
}