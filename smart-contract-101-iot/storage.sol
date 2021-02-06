pragma solidity 0.7.5;

contract DataLocation {

    //storage - persistent data storage
    //memory - temporary data storage
    //calldata - similar to memory, but READ-ONLY

    //state variables
    uint data = 123; //storaed in storage
    string lastText = "Hello Dominik";

    function getString(string memory text, uint number) public view returns(string memory){
        number += 10;
        string memory newString = lastText;
        newString = text;
        return text;
    }
}