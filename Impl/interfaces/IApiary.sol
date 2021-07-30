// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IApiary {
   function ReturnNonEcologicalHoneyToApiary (
        uint apiaryHoneyUID_uint,
        string memory honeyType_str,
        uint128 quantity_uint
        ) external;
        
}