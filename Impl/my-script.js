const Web3 = require('web3')
const web3 = new Web3('ws://localhost:7545')

const fs = require('fs')
const TownHall = require('C:/Users/Alin/Desktop/Licenta/Ethereum setup/BioTrack/build/contracts/TownHall.json')
const Apiary = require('C:/Users/Alin/Desktop/Licenta/Ethereum setup/BioTrack/build/contracts/Apiary.json')

const init = async () => {
  const id_t = await web3.eth.net.getId()
  const deployedNetwork_t = TownHall.networks[id_t]
  const townHall = new web3.eth.Contract(
    TownHall.abi,
    deployedNetwork_t.address,
  )

  const id_a = await web3.eth.net.getId()
  const deployedNetwork_a = Apiary.networks[id_a]
  const apiary = new web3.eth.Contract(Apiary.abi, deployedNetwork_a.address)

  const accounts = await web3.eth.getAccounts()
  console.log(accounts)

  showPastEvents();

}

function showTransaction(txHash) {
  web3.eth
    .getTransaction(txHash)
    .then((tr) => console.log(tr))
    .catch((err) => console.log(err))
}

function showPastEvents() {
  var events = townHall
    .getPastEvents('LicenseEv', { fromBlock: 0, toBlock: 'latest' })
    .then((ev) =>
      fs.writeFile(
        'C:/Users/Alin/Desktop/Licenta/Ethereum setup/BioTrack' +
          '/out/test.txt',
        JSON.stringify(ev, null, 4),
        function (err) {
          if (err) {
            return console.log(err)
          }
          console.log('The file was saved!')
        },
      ),
    )
    .catch((err) => console.log(err))

  console.log(events)
}

init()
