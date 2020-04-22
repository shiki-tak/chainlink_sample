const HelloChainlink = artifacts.require("HelloChainlink");

module.exports = (deployer) => {
    const oracleAddress = "0x7AFe1118Ea78C1eae84ca8feE5C65Bc76CcF879e";
    const JobID = "ec579afb1fe740b186248ba7ba990d37";
    deployer.deploy(HelloChainlink, oracleAddress, JobID, { gas: 2000000 });
};