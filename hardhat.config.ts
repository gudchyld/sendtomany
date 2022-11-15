import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-toolbox';

require('dotenv').config({ path: '.env' });

const INFURA_MAINNET_API_KEY_URL = process.env.INFURA_MAINNET_API_KEY_URL;
const ALCHEMY_GOERLI_API_KEY_URL = process.env.ALCHEMY_GOERLI_API_KEY_URL;
const QUICKNODE_GOERLI_API_KEY_URL = process.env.QUICKNODE_GOERLI_API_KEY_URL;

const ACCOUNT_PRIVATE_KEY = process.env.ACCOUNT_PRIVATE_KEY;
const ACCOUNT_PRIVATE_KEY2 = process.env.ACCOUNT_PRIVATE_KEY2;

module.exports = {
  solidity: '0.8.9',

  networks: {
    hardhat: {
      forking: {
        //url: INFURA_MAINNET_API_KEY_URL,
        url: ALCHEMY_GOERLI_API_KEY_URL,
      },
    },
    mainnet: {
      url: INFURA_MAINNET_API_KEY_URL,
      accounts: [ACCOUNT_PRIVATE_KEY],
    },

    goerli: {
      url: QUICKNODE_GOERLI_API_KEY_URL,
      accounts: [ACCOUNT_PRIVATE_KEY],
    },
  },
  settings: {
    optimizer: {
      enabled: true,
      runs: 200,
    },
  },
};
