// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "../interfaces/ITownHall.sol";

/**
 * @title TownHall
 * @dev TownHall SC Member
 */
 
 contract TownHall is ITownHall {

    /** Contract states */

    address public _owner;
   
    /** Variable which contains the total number of licenses available */
    uint16 public _counterLicenses = 0;
    
    /** 
    *   Increase the variable whenever a new Apiary instance is created 
    *   _numOfBeekeepers_uint != _counterLicenses
    *   Number of beekeepers may be higher then the number of licenses because one beekeeper
    *       does not always have a valid license
    */
    uint16 public _numOfBeekeepers_uint = 0;

    string public _townName_str = "";
    string public _townCountry_str = "";
 
    /** TownHall keeps the track of valid licenses, with address as a key and apiary address as a value */
    //mapping(address => ApiaryAddress_st) public licenses;
    mapping(address => License_st) public licenses;

    /* License_st _validLicense_st; No needed for the moment */

    event LicenseEv (address owner, License_st lic);
 
    /* Struct to keep a pair of ApiaryAddress with its id in TownHall registers
    struct ApiaryAddress_st {
        //address apiaryAddress_addr; No needed because --> myContract.address
        uint128 idAddress_uint;
        License_st validLicense;
    }
    */

    struct License_st {
        uint128 _idLicense_uint;
        address _accountRequester_addr;
        string _producerName_str;
        string _producerAddress_str;
        string _apiaryName_str;
        string _apiaryAddress_str;
        string _honeyTypes_str;
        uint8 _validityMonths_uint;
        uint _expirationDate_str;
    }
    
    
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
        /* Perform some operations */
    }
    
    /**  */
    function UpdateTownHallLocation(
        string memory townName_str,
        string memory townCountry_str
        )
        public
        restricted {
        
            _townName_str = townName_str;
            _townCountry_str = townCountry_str;
    }

    /** Emit a new valid license for an Apiary requester */
    function EmitLicense(
        address accountRequester,
        string memory producerName,
        string memory producerAddress,
        string memory apiaryName,
        string memory apiaryAddress,
        string memory honeyTypes)
    external 
    override {
            
        /* Create a new license and update the fields */
        License_st memory license = License_st({
                                    _idLicense_uint : _counterLicenses,
                                    _accountRequester_addr: accountRequester,
                                    _producerName_str :producerName,
                                    _producerAddress_str :producerAddress,
                                    _apiaryName_str : apiaryName,
                                    _apiaryAddress_str : apiaryAddress,
                                    _honeyTypes_str : honeyTypes,
                                    _validityMonths_uint : 12,
                                    _expirationDate_str : block.timestamp + 365 days});

        /* Save the apiary sender request and his license, uniquely
        ApiaryAddress_st memory _newApiaryAddress = ApiaryAddress_st({
                                                        apiaryAddress_addr : msg.sender,
                                                        idAddress_uint : _counterLicenses,
                                                        validLicense : license});
        */

        /* Save the license in TownHall registers */
        licenses[msg.sender] = license;

        /* increase the number of valid licenses */
        _counterLicenses += 1;

        /* Emit License event */
        emit LicenseEv(accountRequester, license);
    }

    /** When a new Apiary is created, increase the number of total beekeeper in TownHall registers */
    function UpdateTotalBeekeepers ()
        external
        override {

            _numOfBeekeepers_uint += 1;
    }

}