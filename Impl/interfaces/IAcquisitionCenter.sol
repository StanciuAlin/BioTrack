// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IAcquisitionCenter {
   function RegisterReceivedBeekeeperHoney (
        address apiaryAccount_addr,
        uint apiaryHoneyUID_uint,
        string memory honeyType_str,
        uint128 quantity_uint
        ) external;
        
}

