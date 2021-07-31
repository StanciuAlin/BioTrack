// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


/**
 * @title Laboratory
 * @dev The Laboratory SC Member
 */
 
import "../interfaces/ILaboratory.sol";

contract Laboratory is ILaboratory {
    
    /** Contract states */
     address public _owner;
    
    /** Variable which contains the total number of reports */
    uint16 public _counterReports_uint = 0;
    
    string public _labName_str = "";
    string public _labLocation_str = "";
    
    struct Report_st {
        uint128 _idReport_uint;
        address _accountRequester_addr;
        string _honeyTypes_str;
        string _lName_str;
        string _lLocation_str;
        uint _dateOfAnalysis;
        bool _isEcological;
        uint _price;
    }
    
    mapping(uint => Report_st) public reports;
    
    /** Contract events */

    event ReportEv (address owner, Report_st report);
    
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
    
    /**  */
    function UpdateLaboratoryInfo(
        string memory labName_str,
        string memory labLocation_str
        )
        public
        restricted {
        
            _labName_str = labName_str;
            _labLocation_str = labLocation_str;
    }
    
    /*  */
    function AnalyzeHoney (
        address accountRequester_addr,
        string memory honeyTypes_str
        ) 
        external
        override {
            Report_st memory report = Report_st({
                _idReport_uint: _counterReports_uint,
                _accountRequester_addr: accountRequester_addr,
                _honeyTypes_str: honeyTypes_str,
                _lName_str: _labName_str,
                _lLocation_str: _labLocation_str,
                _dateOfAnalysis: block.timestamp,
                _isEcological: true,
                _price: 200
            });
            
            require(report._isEcological == true, "No BIO");
            
            reports[_counterReports_uint] = report;
            
            _counterReports_uint += 1;
            
            emit ReportEv(_owner, report);
        }
}