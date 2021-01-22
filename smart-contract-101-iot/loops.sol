pragma solidity 0.7.5;

contract Loop{

    function count(int number) public pure returns(int){
        int i = 0;
        while(i < 10){
            number++;
            i++;
        }
        return number;
    }



    function count2(int number) public pure returns(int){
        for(int i = 0; i < 10; i++){

        }
        return number;
    }
}