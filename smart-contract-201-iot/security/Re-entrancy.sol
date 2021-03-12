pragma solidity 0.8.0;

/* 
    IMPORTANT DESIGN PATTERN IN SOLIDITY
    CHECKS -> EFFECTS (MANAGING STATE) -> INTERACTION
*/

contract test {

    mapping (address  => uint) balance;

    function withdraw() public {
        require(balance[msg.sender] > 0); // CHECK

        uint toTransfer = balance[msg.sender];
        address payable owner = payable(msg.sender);
        balance[msg.sender] = 0; // EFFECT

        bool success = owner.send(toTransfer); // INTERACTION

        if (!success) {
            balance[msg.sender] = toTransfer;
        }
    }

}