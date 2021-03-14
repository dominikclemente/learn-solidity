const Migrations = artifacts.require("Helloworld");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};

