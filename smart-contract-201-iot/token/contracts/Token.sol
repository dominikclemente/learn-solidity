pragma solidity >=0.6.0 <0.8.0;

import '../node_modules/@openzeppelin/contracts/token/ERC20/ERC20Capped.sol';
import '../node_modules/@openzeppelin/contracts/access/Ownable.sol';

contract DCToken is ERC20Capped, Ownable {
    constructor() ERC20("DeCentral", "DC") ERC20Capped(21000001){
        _mint(msg.sender, 1000);
    }
}
