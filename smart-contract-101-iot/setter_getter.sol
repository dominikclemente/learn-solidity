pragma solidity 0.7.5;

contract SetGet{
    int number;

    function getNumber() public view returns(int){
        return number;
    }


    function setNumber(int _number) public returns(int){
        number = _number;
    }
}