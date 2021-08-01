// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IProcessor {

    function TransferHoneyFromAcqCenterToProcessor (
        uint acquisitionCenterHoneyUID,
        string memory honeyType,
        uint128 quantity
        )
        external;

}