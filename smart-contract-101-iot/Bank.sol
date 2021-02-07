pragma solidity 0.7.5;

interface GovernmentInterface{
    function addTransaction(address _from, address _to, uint amount) external;
}

contract Bank {
    GovernmentInterface GovernmentInstance = GovernmentInterface(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);

    mapping(address => uint) balance;
    address owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    modifier costs(uint price){
        require(msg.value >= price);
        _; // run the function
    }

    function addBalance(uint _toAdd) public onlyOwner returns (uint){
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
    }

    function getBalance() public view returns(uint){
        return balance[msg.sender];
    }

    function getOwner() public view returns (address){
        return owner;
    }

    function transfer(address recipient, uint amount) public payable costs(100){
        require(balance[msg.sender] >= amount);
        require(msg.sender != recipient);

        uint previousSenderBalance = balance[msg.sender];

        _transfer(msg.sender, recipient, amount);

        GovernmentInstance.addTransaction(msg.sender, recipient, amount);

        assert(previousSenderBalance - amount == balance[msg.sender]);
    }

    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }
}