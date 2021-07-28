export const TOWNHALL_ADDRESS = '0xA192105a19eC3E6116c49DAc7235FD17b8a48599';

export const TOWNHALL_ABI = [
  {
    "inputs": [],
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "components": [
          {
            "internalType": "uint128",
            "name": "_idLicense_uint",
            "type": "uint128"
          },
          {
            "internalType": "string",
            "name": "_producerName_str",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "_producerAddress_str",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "_apiaryName_str",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "_apiaryAddress_str",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "_honeyTypes_str",
            "type": "string"
          },
          {
            "internalType": "uint8",
            "name": "_validityMonths_uint",
            "type": "uint8"
          },
          {
            "internalType": "string",
            "name": "_expirationDate_str",
            "type": "string"
          }
        ],
        "indexed": false,
        "internalType": "struct TownHall.License_st",
        "name": "lic",
        "type": "tuple"
      }
    ],
    "name": "LicenseEv",
    "type": "event"
  },
  {
    "inputs": [],
    "name": "_counterLicenses",
    "outputs": [
      {
        "internalType": "uint16",
        "name": "",
        "type": "uint16"
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
    "inputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "name": "licenses",
    "outputs": [
      {
        "internalType": "uint128",
        "name": "_idLicense_uint",
        "type": "uint128"
      },
      {
        "internalType": "string",
        "name": "_producerName_str",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_producerAddress_str",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_apiaryName_str",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_apiaryAddress_str",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_honeyTypes_str",
        "type": "string"
      },
      {
        "internalType": "uint8",
        "name": "_validityMonths_uint",
        "type": "uint8"
      },
      {
        "internalType": "string",
        "name": "_expirationDate_str",
        "type": "string"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "numOfBeekeepers_uint",
    "outputs": [
      {
        "internalType": "uint16",
        "name": "",
        "type": "uint16"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "townCountry_str",
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
    "name": "townName_str",
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
    "inputs": [
      {
        "internalType": "string",
        "name": "_producerName",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_producerAddress",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_apiaryName",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_apiaryAddress",
        "type": "string"
      },
      {
        "internalType": "string",
        "name": "_honeyTypes",
        "type": "string"
      }
    ],
    "name": "EmitLicense",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "UpdateTotalBeekeepers",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  }
];