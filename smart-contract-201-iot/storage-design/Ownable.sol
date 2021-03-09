pragma solidity 0.8.0;

contract Ownable {
    address internal owner;

    constructor(){
        owner = msg.sender;
    }
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
}

