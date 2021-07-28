import { Component } from 'react';
import './App.css';
import Navbar from './components/Navbar/Navbar';
import { FooterContainer } from './containers/footer'
import {connectToBlockchain, Test} from './loadBlockchainData';
import {web3} from './loadBlockchainData';


class App extends Component {

  async ft() {
    const accounts = await web3.eth.getAccounts();
    console.log(accounts);
  }


  componentDidMount() {
    connectToBlockchain();
    this.ft();
    //Test();
  }
  

  render() {
    return (
      <div className="App">
        <>
          <Navbar />
          <FooterContainer />
        </>
      </div>
    );
  }
}

export default App;
