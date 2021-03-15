const DCToken = artifacts.require("ERC20MinterPauserCapped");

module.exports = function (deployer) {
  deployer.deploy(DCToken, "DeCentral", "DC", 6942069);
};
