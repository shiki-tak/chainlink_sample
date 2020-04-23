const HelloChainlink = artifacts.require("HelloChainlink");

module.exports = (deployer) => {
    const oracleAddress = "0xc99B3D447826532722E41bc36e644ba3479E4365";
    const JobId = "e0d9bb9d52b84966b246a78851cf9444";
    deployer.deploy(HelloChainlink, oracleAddress, JobId, { gas: 2000000 });
};