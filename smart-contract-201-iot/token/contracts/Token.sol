pragma solidity >=0.6.0 <0.8.0;

import '../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract DCToken is ERC20 {
    constructor() ERC20("DeCentral", "DC"){
        _mint(msg.sender, 1000);
    }
}
