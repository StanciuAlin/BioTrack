// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IAcquisitionCenter {
   function RegisterBeekeeperHoney (
        address apiaryAccount_addr,
        string memory honeyType_str,
        uint128 quantity_uint
        ) external;
}
