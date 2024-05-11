
var TuneToken = artifacts.require("TuneToken");

module.exports = function(deployer) {
    deployer.deploy(TuneToken, "TuneToken", "TT");
    // Additional contracts can be deployed here
}