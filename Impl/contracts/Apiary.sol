// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./TownHall.sol";
import "./AcquisitionCenter.sol";

/**
 * @title Apiary
 * @dev The Apiary SC Member
 */

contract Apiary {
    
    /** Contract states */

    address public _owner;

    string public _producerName_str = "";
    string public _producerLocation_str = "";
    string public _apiaryName_str = "";
    string public _apiaryLocation_str = "";
    string public _honeyTypeAvailableInApiary_str = ""; 
    string public _honeyTypeAvailableToSell_str = "";
    
    uint128 public _quantity_uint = 0;

    /** One instace of Townhall to get the valid license */
    TownHall public townHall;
    
    /** One instace of Acquisition Center to sell the honey */
    AcquisitionCenter public acquisitionCenter;
    
    /** Contract events */

    /** Log honey and quantity when the Apiary register a new honey input */
    event RegisterHoneyEv(
        string apiaryHoney,
        uint128 quantity,
        uint256 totalQuantity
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
    function SetHoneyQuantityPerType(
        string memory apiaryHoney, 
        uint128 quantity
        ) 
    public 
    restricted {
        
        _honeyTypeAvailableToSell_str = apiaryHoney;
        require(keccak256(bytes(_honeyTypeAvailableToSell_str)) == keccak256(bytes(_honeyTypeAvailableInApiary_str)));
        //require(_quantity_uint == 0);
        _quantity_uint += quantity;
        
        emit RegisterHoneyEv(apiaryHoney, quantity, _quantity_uint);
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
    function SellHoney(
        string memory apiaryHoney, 
        uint128 quantity
        )
        public
        payable
        restricted {
            
            /* Apiary available honey should be the same type like the honey which is sold */
            require(keccak256(bytes(_honeyTypeAvailableInApiary_str)) == keccak256(bytes(apiaryHoney)));
            //_honeyTypeAvailableToSell_str = "";
            require(_quantity_uint >= quantity);
            _quantity_uint -= quantity;
            
            /* If there is no other honey of current type, reset the apiary available honey */
            if(_quantity_uint == 0) {
                _honeyTypeAvailableToSell_str = "";
                _honeyTypeAvailableInApiary_str = "";
            }
            
            acquisitionCenter.RegisterBeekeeperHoney(
                _owner,
                apiaryHoney,
                quantity
                );
            
            /* Here should be an event triggered */
            
            /** TODO 
            * Event rised when the honey is solt to one Acquisition Center.
            */
        }
    
}