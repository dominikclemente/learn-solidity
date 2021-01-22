pragma solidity 0.7.5;

contract HelloWorld {
    int a = -3;
    uint b = 2;
    bool c = false;
    string message;
    address x = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    
    constructor (string memory _message){
        message = _message;
    }
    
    function hello() public returns (string memory){
        return message;
    }
}