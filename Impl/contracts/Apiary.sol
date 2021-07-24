// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./TownHall.sol";

contract Apiary {
    
    //uint128 public _idApiary;
    
    //uint128 public _idApiaryLicense = 0;
    

    /** Contract states */

    address public _owner;

    string public _producerName_str = "";
    string public _producerLocation_str = "";
    string public _apiaryName_str = "";
    string public _apiaryLocation_str = "";
    string public _honeyTypes_str = ""; 
    string public _apiaryHoney_str = "";
    
    uint128 public _quantity_uint = 0;

    /** Contract events */

    event RegisterHoneyEv(
        string apiaryHoney,
        uint128 quantity
    );
    
    /** Contract access modifiers */
    modifier restricted() {
        require (
        msg.sender == _owner,
        "This function is restricted to the contract's owner"
        );
        _;
    }
    
    constructor () {
        _owner = tx.origin;
    }

    function AddNewHoneyType(string memory honeyType) public restricted {
        require(keccak256(bytes(_honeyTypes_str)) == keccak256(bytes("")));
        _honeyTypes_str = string(abi.encodePacked(_honeyTypes_str, honeyType));
    }

    function SetHoneyQuantityPerType(string memory apiaryHoney, uint128 quantity) public restricted {
        require(keccak256(bytes(_apiaryHoney_str)) == keccak256(bytes("")));
        require(_quantity_uint == 0);
        _apiaryHoney_str = apiaryHoney;
        _quantity_uint = quantity;
        
        emit RegisterHoneyEv(_apiaryHoney_str, _quantity_uint);
    }

    function UpdatePersonalData(
        string memory producerName,
        string memory producerLocation
    )
    public
    restricted {
        _producerName_str = producerName;
        _producerLocation_str = producerLocation;
    }

    function UpdateApiaryData(
        string memory apiaryName,
        string memory apiaryLocation
    )
    public
    restricted {
        _apiaryName_str = apiaryName;
        _apiaryLocation_str = apiaryLocation;
    }

    function RequestLicense() public payable restricted {
        
        TownHall townHall = new TownHall();
        //townHall.EmitLicense("Popescu", "Str. Principala, 19", "ApiSRL", "Str. Salcamilor, 190", "Salcam");
        
        townHall.EmitLicense(
            _producerName_str,
            _producerLocation_str,
            _apiaryName_str,
            _apiaryLocation_str,
            _honeyTypes_str
            );
    }
    
    /**
     * @dev Return value 
     * @return value of 'number'
     */
    function retrieveLicense() public view returns (uint8){
        return 0;
    }
}
