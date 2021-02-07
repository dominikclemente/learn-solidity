pragma solidity 0.7.5;

import "../Ownable.sol"

contract Destroyable is Ownable {
    
    function close() public onlyOwner {
        selfdestruct(owner);
    }
}