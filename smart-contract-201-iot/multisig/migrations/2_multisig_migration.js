const Multisig = artifacts.require("MultisigWallet");

module.exports = function (deployer, network, accounts) {
    const ownerAdresses = accounts.slice(0.3);
    const requiredApprovals = 2;
    deployer.deploy(Multisig, ownerAdresses, requiredApprovals);
};

