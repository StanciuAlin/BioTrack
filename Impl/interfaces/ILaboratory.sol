// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface ILaboratory {
   function AnalyzeHoney (
        address accountRequester_addr,
        string memory honeyTypes_str
        ) external;
}