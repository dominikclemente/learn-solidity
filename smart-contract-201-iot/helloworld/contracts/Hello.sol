pragma solidity 0.8.0;

contract Helloworld {

    string message = "Hello world";

    function getMessage() public view returns (string memory){
        return message;
    }

    function setMessage(string memory newMessage) public payable{
        message = newMessage;
    }
}