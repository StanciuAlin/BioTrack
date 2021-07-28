// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./TownHall.sol";

/**
 * @title Processor
 * @dev The Processor SC Member
 */



// Am un array de address intr o structura, pentru a stii lotul din cate stupine diferite a fost creat
// Pot avea un lot creat cu miere din mai multe stupine.



contract Processor {
    
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