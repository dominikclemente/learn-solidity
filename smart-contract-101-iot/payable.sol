pragma solidity 0.7.5;

contract Bank {
    mapping(address => uint) balance;
    address owner;

    constructor(){
        owner = msg.sender;
    }

    event depositDone(uint amount, address indexed depositedTo);

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    modifier costs(uint price){
        require(msg.value >= price);
        _; // run the function
    }

    function deposit() public payable onlyOwner returns (uint){
        balance[msg.sender] += msg.value;
        emit depositDone(msg.value, msg.sender);
        return balance[msg.sender];
    }

    function getBalance() public view returns(uint){
        return balance[msg.sender];
    }
    
    function withdraw(uint amount) public returns(uint){
        require(balance[msg.sender] >= amount, "You can't withdraw more money than you have!");
        
        balance[msg.sender] -= amount;
        msg.sender.transfer(amount);
        return balance[msg.sender];
    }

    function transfer(address recipient, uint amount) public payable costs(100){
        require(balance[msg.sender] >= amount, "Balance not sufficient");
        require(msg.sender != recipient, "Don't send money to yourself");

        uint previousSenderBalance = balance[msg.sender];

        _transfer(msg.sender, recipient, amount);

        assert(previousSenderBalance - amount == balance[msg.sender]);
    }

    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }
}