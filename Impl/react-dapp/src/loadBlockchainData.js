import React, { Component } from 'react'
import { APIARY_ABI, APIARY_ADDRESS } from './components/supply-chain/config/config-apiary'
import { TOWNHALL_ABI, TOWNHALL_ADDRESS } from './components/supply-chain/config/config-townhall'
import Web3 from 'web3';

export var web3 = undefined;

export async function connectToBlockchain() {

    if (typeof web3 !== 'undefined') {
        web3 = new Web3(Web3.currentProvider);
    } else {
        // set the provider you want from Web3.providers
        web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));
    }
    console.log(web3);
}

export async function Test() {
    const ap = new web3.eth.Contract(APIARY_ABI, APIARY_ADDRESS);
    const th = new web3.eth.Contract(TOWNHALL_ABI, TOWNHALL_ADDRESS);

    console.log(ap);
    console.log(th);


    const accounts = await web3.eth.getAccounts();

    await ap.methods.UpdatePersonalData("Popescu", "Principala, 22").send({from: accounts[1]})
        .on('error', function(error){ console.log('Error in setting data'); })
        .on('transactionHash', function(transactionHash){ console.log('Tx Pers Data= ', transactionHash); })
        .on('receipt', function(receipt){
            console.log(receipt) // contains the new contract address
            })
        .then(function(){
            console.log(); // instance with the new contract address
        });
    // .once('receipt', (receipt) => {
    //     console.log(receipt);
    //   });
   	await ap.methods.UpdateApiaryData("XYZ.SRL", "Ispas, 12").send({from: accounts[1]})
       .on('error', function(error){ console.log('Error in setting data'); })
       .on('transactionHash', function(transactionHash){ console.log('Tx Upd Api= ', transactionHash); })
       .on('receipt', function(receipt){
           console.log(receipt) // contains the new contract address
           })
       .then(function(){
           console.log(); // instance with the new contract address
       });
    await ap.methods.RegisterToTownHall(TOWNHALL_ADDRESS).send({from: accounts[1]})
        .on('error', function(error){ console.log('Error in setting data'); })
        .on('transactionHash', function(transactionHash){ console.log('Tx Reg= ', transactionHash); })
        .on('receipt', function(receipt){
            console.log(receipt) // contains the new contract address
            })
        .then(function(){
            console.log(); // instance with the new contract address
        });

    const f = await ap.methods.RequestLicense().send({from: accounts[1], gas: 6721974});
    console.log("Request tx = ", f);


    // await ap.methods.ReadOwner().call((err, result) => {
    //     if (err){
    //         console.log('Error in setting data');
    //     } else {
    //         console.log('rest = ', result);
    //     }
    // });



    const ow = await ap.methods._owner().call();
    console.log("Owner apiary addr = ", ow);


    const lic = await th.methods.licenses(APIARY_ADDRESS).call();

    console.log("Licenses = ", lic);

    const bek = await th.methods.numOfBeekeepers_uint().call();

    console.log("Beekeepers = ", bek);
}

// export default web3;