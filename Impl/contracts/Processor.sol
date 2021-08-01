// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "../interfaces/IProcessor.sol"; 

/**
 * @title Processor
 * @dev The Processor SC Member
 */



// Am un array de address intr o structura, pentru a stii lotul din cate stupine diferite a fost creat
// Pot avea un lot creat cu miere din mai multe stupine.



contract Processor is IProcessor {
    
    /** Contract states */
     address public _owner;
    
    string public _processorName_str = "";
    string public _processorLocation_str = "";
    
    struct ProcessorHoney_st {
        string honeyType_str;
        uint8 pricePerKg_uint;
        uint128 quantity_uint;
    }
    
    ProcessorHoney_st[] public honeyTypesWithPriceEvidence;
    
    struct ReceivedAcquisitionCenterHoney_st {
         uint acquisitionCenterHoneyUID_uint;
         string honeyType_str;
         uint128 quantity_uint;
     }
    
    /* Honey received from Acquisition Center */
    ReceivedAcquisitionCenterHoney_st[] public receivedAcquisitionCenterHoneyEvidence;
    
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
    
    /**  */
    function UpdateProcessorInfo(
        string memory processorName_str,
        string memory processorLocation_str
        )
        public
        restricted {
        
            _processorName_str = processorName_str;
            _processorLocation_str = processorLocation_str;
    }
    
    /**  */
    function RegisterNewHoneyTypeInProcessor(
        string memory honeyType,
        uint8 price
        )
        public
        restricted {
             
            /** Flag used for searching in honey types array
             *      false = the actual value of honey type does not exist in actual list
             *      true = the actual value of honey type exists in actual list
             */
            bool existFlag = false;
            
            /** Create a new structure object */
            ProcessorHoney_st memory processorHoney_st;
            
            /** Search secquentially for the honey type in order to insert in list if it does not exist */
            for(uint8 it = 0; it < honeyTypesWithPriceEvidence.length; ++it) {
                /** If the honey type exists, toggle the flag to true */
                if( keccak256(bytes(honeyType)) == keccak256(bytes(honeyTypesWithPriceEvidence[it].honeyType_str)) ) {
                    existFlag = true;
                }
            }
            
            if ( !existFlag ) {
                processorHoney_st.honeyType_str = honeyType;
                processorHoney_st.pricePerKg_uint = price;
                processorHoney_st.quantity_uint = 0;
                
                honeyTypesWithPriceEvidence.push(processorHoney_st);
            }
            
        }
        
        
            /**  */
    function RegisterHoneyTypeInProcessorFromAcqCenter(
        string memory honeyType,
        uint128 quantity
        )
        private {
             
            /** Flag used for searching in honey types array
             *      false = the actual value of honey type does not exist in actual list
             *      true = the actual value of honey type exists in actual list
             */
            bool existFlag = false;
            
            /** Create a new structure object */
            ProcessorHoney_st memory processorHoney;
            
            /** Search secquentially for the honey type in order to insert in list if it does not exist */
            for(uint8 it = 0; it < honeyTypesWithPriceEvidence.length; ++it) {
                /** If the honey type exists, toggle the flag to true */
                if( keccak256(bytes(honeyType)) == keccak256(bytes(honeyTypesWithPriceEvidence[it].honeyType_str)) ) {
                    existFlag = true;
                }
            }
            
            if ( !existFlag ) {
                processorHoney.honeyType_str = honeyType;
                processorHoney.quantity_uint = quantity;
                
                honeyTypesWithPriceEvidence.push(processorHoney);
            } else {
                // TODO --> v[it].quantity += quantity pentru ca la mine se suprascrie cu =
            }
            
        }
        
        /* TODO Inca o functie external pe care o apelez din Aq center intr un for (trimite mierea cu pretul ei doar daca exista acel tip la procesator, verific rin require). 
        *  Trimit element cu element si il verific daca l-am adaugat inainte
        *  cu RegisterNewHoneyTypeInProcessor(), adica daca exista in vectorul honeyTypesWithPriceEvidence, daca da, il adaug aici in array ul cu miere, cu acelasi
        *  tip, dar pretul de la Aq center + adaos, 5 sa zicem.
        */
    
    function TransferHoneyFromAcqCenterToProcessor (
        uint acquisitionCenterHoneyUID,
        string memory honeyType,
        uint128 quantity
        )
        external
        override {
            // This function can be restricted to be called by an Acquisition Center only, which are stored in a queue.
            ReceivedAcquisitionCenterHoney_st memory receivedAcquisitionCenterHoney = ReceivedAcquisitionCenterHoney_st ({
                acquisitionCenterHoneyUID_uint: acquisitionCenterHoneyUID,
                honeyType_str: honeyType,
                quantity_uint: quantity
            });
            
            RegisterHoneyTypeInProcessorFromAcqCenter(
                honeyType,
                quantity
                );
            
            receivedAcquisitionCenterHoneyEvidence.push(receivedAcquisitionCenterHoney);
        }
        
    // TODO --> Functie pentru impartirea mierii in loturi. Aceasta apeleaza o functie privata care ia la rand receivedAcquisitionCenterHoneyEvidence
    //          si aduna acq center id urile intr-un array, aduna cantitatile de miere din aceeasi categorie, toate intr-un struct
    // struct {array cu id urile, tipul mierii si quantity total}
    //
    //          Verific si Tipul de miere SalcamPolifloraTei si daca e suficient doar acq center id-ul sau mai trebuie info primita.
}