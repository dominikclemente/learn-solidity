pragma solidity 0.7.5;
pragma abicoder v2;

// test owner addresses array 
// ["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"] 

contract MultiSig {
    address[] owners;
    
    uint requiredApprovals;
    
    event depositSent(address _depositor, uint _amount);
    event transactionSent(address _to, uint _amount, uint _txnId);
    
    struct Transaction {
        uint id;
        address payable receiver;
        uint amount;
        uint approvals;
        bool hasBeenSent;
    }
    
    Transaction[] pendingTransactions;
    
    mapping(address => mapping(uint => bool)) approvals;
    
    constructor(address[] memory _owners, uint  _requiredApprovals){
        requiredApprovals = _requiredApprovals;
        owners = _owners;
    }

    modifier onlyOwners(){
        bool owner = false;
        for (uint i = 0; i < owners.length; i++) {
            if (owners[i] == msg.sender) {
                owner = true;
            }
        }
        require(owner == true);
        _;
    }
    
    function deposit() public payable{
        emit depositSent(msg.sender, msg.value);
    }
    
    function requestTransfer(address payable _to, uint  _amount) public onlyOwners{
        pendingTransactions.push(
            Transaction(pendingTransactions.length, _to, _amount, 1, false)
        );
    }
    
    function approve(uint _txnId) public {
        Transaction memory txn = pendingTransactions[_txnId];

        require(txn.hasBeenSent == false);
        require(approvals[msg.sender][_txnId] == false);

        if (txn.approvals >= requiredApprovals){
            txn.hasBeenSent = true;
            txn.receiver.transfer(txn.amount);
            emit transactionSent(txn.receiver, txn.amount, _txnId);
        }
    }

    function getTransactionsRequests() public view returns (Transaction[] memory){
        return pendingTransactions;
    }
}