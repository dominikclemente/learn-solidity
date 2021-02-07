pragma solidity 0.7.5;

import "./Ownable.sol";

contract Government is Ownable {

    struct Transaction {
        address from;
        address to;
        uint amount;
        uint txnId;
    }

    Transaction[] transactionLog;

    function addTransaction(address _from, address _to, uint _amount) external payable{
        transactionLog.push(Transaction(_from, _to, _amount, transactionLog.length));
    }

    function getTransaction(uint _index) public view returns (address, address, uint){
        Transaction memory txn = transactionLog[_index];
        return (txn.from, txn.to, txn.amount);
    }
}