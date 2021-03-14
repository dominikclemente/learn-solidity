const DCToken = artifacts.require("DCToken");

module.exports = function (deployer) {
  deployer.deploy(DCToken);
};
