import { Component } from 'react';
import './App.css';
import Navbar from './components/Navbar/Navbar';
import { FooterContainer } from './containers/footer'
import {connectToBlockchain, Test} from './loadBlockchainData';

class App extends Component {
  
  componentDidMount() {
    connectToBlockchain();
    Test();
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
