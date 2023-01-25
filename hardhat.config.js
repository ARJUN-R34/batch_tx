require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    hardhat: {
      forking: {
        url: "https://polygon-mainnet.g.alchemy.com/v2/18zqoO1o2Trqnf4i8SD8qgEXAQTO7jDl",
        blockNumber: 38500000,
        enabled: true
      }
    },
    goerli: {
      url: "https://eth-goerli.g.alchemy.com/v2/N7NXwc6qE9P95zyVaI8PLMxvgnw4s0WB",
      networkId: 5,
    }
  }
};

