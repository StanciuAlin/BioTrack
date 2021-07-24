// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
 
 contract TownHall {

    address public _owner;
    uint128 _idTownHall_uint;
    string public townName_str;
    string public townCountry_str;
    string public numOfBeekeepers_str;
 
    event LicenseEv (License_st lic);
 
    /* Struct to keep a pair of ApiaryAddress with its id in TownHall registers */
    struct ApiaryAddress_st {
        address apiaryAddress_addr;
        uint128 idAddress_uint;
        License_st validLicense;
    }
   
    /* TownHall keeps the track of valid licenses, with address as a key and apiary address as a value */
    //mapping(uint128 => ApiaryAddress_st) public licenses;
    mapping(address => ApiaryAddress_st) public licenses;
    //mapping(uint128 => uint128) public licenses;
    
    /* Variable which contains the total number of licenses available */
    uint16 public _counterLicenses = 0;
    
    struct License_st {
        uint128 _idLicense_uint;
        string _producerName_str;
        string _producerAddress_str;
        string _apiaryName_str;
        string _apiaryAddress_str;
        string _honeyTypes_str;
        uint8 _validityMonths_uint;
        string _expirationDate_str;
    }
    //License_st _validLicense_st;
    
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
        /* Perform some operations */
    }
    
    function EmitLicense(
        string memory _producerName,
        string memory _producerAddress,
        string memory _apiaryName,
        string memory _apiaryAddress,
        string memory _honeyTypes)
        public {
            
            /* Create a new license and update the fields */
            License_st memory license = License_st({
                                        _idLicense_uint : _counterLicenses,
                                        _producerName_str :_producerName,
                                        _producerAddress_str :_producerAddress,
                                        _apiaryName_str : _apiaryName,
                                        _apiaryAddress_str : _apiaryAddress,
                                        _honeyTypes_str : _honeyTypes,
                                        _validityMonths_uint : 12,
                                        _expirationDate_str : "31.12.2021"});
            
            
            //licenses[msg.sender] = _idApiary;
            /* Save the apiary sender request and his license, uniquely */
            ApiaryAddress_st memory _newApiaryAddress = ApiaryAddress_st({
                                                            apiaryAddress_addr : msg.sender,
                                                            idAddress_uint : _counterLicenses,
                                                            validLicense : license});
            
            /* Save the license in TownHall registers */
            //licenses[_counterLicenses] = _newApiaryAddress;
            licenses[msg.sender] = _newApiaryAddress;

            /* increase the number of valid licenses */
            _counterLicenses += 1;

            /* Emit License event */
            emit LicenseEv(license);
        }
     
 }
 