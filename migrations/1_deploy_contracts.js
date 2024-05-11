
var HelloWorld = artifacts.require("MyContract2");

module.exports = function(deployer) {
    deployer.deploy(HelloWorld);
    // Additional contracts can be deployed here
}