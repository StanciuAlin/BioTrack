pragma solidity >=0.7.0 <0.9.0;

import "./TownHall.sol";

contract Apiary {
    
    uint128 public _idApiary;
    
    uint128 public _idApiaryLicense = 0;
    
    string public _producerName;
    string public _producerAddress;
    string public _apiaryName;
    string public _apiaryAddress;
    string public _honeyTypes;
    
    string public apiaryHoney;
    uint128 public quantity;
    
    constructor (string memory producerName) {
        _producerName = producerName;
        //TownHall townHall = new TownHall();
    }


    function TestPerf() public payable {
        /**/
        // TownHall townHall;
        // townHall.EmitLicense(0, "Popescu", "Str. Principala, 19", "ApiSRL", "Str. Salcamilor, 190", "Salcam");
        // townHall.EmitLicense(1, "Ionescu", "Str. Aviatorilor, 10", "ApySRL", "Str. Salcamilor, 195", "Poliflora");
        // townHall.EmitLicense(2, "Radu", "Str. G. Enescu", "XYZSRL", "Str. Eroilor", "Rapita");
    }
    
    /**
     * @dev Return value 
     * @return value of 'number'
     */
    // function retrieve() public view returns (uint256){
    //     return 0;
    // }
}