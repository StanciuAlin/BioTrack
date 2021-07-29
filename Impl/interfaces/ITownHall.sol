// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface ITownHall {
    function EmitLicense(
        address _accountRequester,
        string memory _producerName,
        string memory _producerAddress,
        string memory _apiaryName,
        string memory _apiaryAddress,
        string memory _honeyTypes) external;
    
    function UpdateTotalBeekeepers () external;
}
