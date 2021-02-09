pragma solidity 0.5.12;

contract Hello {
    string message = "Hello World!";

    function getMessage() public view returns (string memory){
        return message;
    }
}