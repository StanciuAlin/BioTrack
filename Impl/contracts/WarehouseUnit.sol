// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./TownHall.sol";

/**
 * @title Warehouse unit for sale
 * @dev The Warehouse Unit SC Member
 */

contract WarehouseUnit {
    
    /** Contract states */
     address public _owner;
    
    /** Contract events */

    
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
}