pragma solidity 0.8.0;
pragma abicoder v2;

contract GasTest {

    function testExternal(uint[10] calldata numbers) external pure returns (uint){
        return numbers[0];
    }

    function testPublic(uint[10] memory numbers) public pure returns (uint) {
        numbers[0] = 10;
        return numbers[0];
    }    


}