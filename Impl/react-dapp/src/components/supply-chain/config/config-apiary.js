import Web3 from 'web3';

export const APIARY_ADDRESS = '0x90FA315C1944fB272c9455d6610e9AA8EdFBc2aF';

export const APIARY_ABI = [
  {
    "inputs": [],
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "string",
        "name": "apiaryHoney",
        "type": "string"
      },
      {
        "indexed": false,
        "internalType": "uint128",
        "name": "quantity",
        "type": "uint128"
      }
    ],
    "name": "RegisterHoneyEv",
    "type": "event"
  },
  {
    "inputs": [],
    "name": "_apiaryHoney_str",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "_apiaryLocation_str",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "_apiaryName_str",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "_honeyTypes_str",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "_owner",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "_producerLocation_str",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "_producerName_str",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "_quantity_uint",
    "outputs": [
      {
        "internalType": "uint128",
        "name": "",
        "type": "uint128"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "townHall",
    "outputs": [
      {
        "internalType": "contract TownHall",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [
      {
        "internalType": "string",
        "name": "honeyType",
        "type": "string"
      }
    ],
    "name": "AddNewHoneyType",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "string",
        "name": "apiaryHoney",
        "type": "string"
      },
      {
        "internalType": "uint128",
        "name": "quantity",
        "type": "uint128"
      }
    ],
    "name": "SetHoneyQuantityPerType",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "string",
        "name": "producerName",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "producerLocation",
        "type": "string"
      }
    ],
    "name": "UpdatePersonalData",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "string",
        "name": "apiaryName",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "apiaryLocation",
        "type": "string"
      }
    ],
    "name": "UpdateApiaryData",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "townHallContract_addr",
        "type": "address"
      }
    ],
    "name": "RegisterToTownHall",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "RequestLicense",
    "outputs": [],
    "stateMutability": "payable",
    "type": "function",
    "payable": true
  }
];


// var web3js;

// if (typeof web3js !== 'undefined') {
//   web3js = new Web3(Web3.currentProvider);
// } else {
//   // set the provider you want from Web3.providers
//   web3js = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));
//   //web3js.eth.sendTransaction();
// }
// console.log(web3js);
// export const apiary_ctr = new web3js.eth.Contract(APIARY_ABI, APIARY_ADDRESS);
