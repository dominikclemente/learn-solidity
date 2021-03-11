pragma solidity 0.8.0;

contract Mapping {

    struct Entity {
        uint data;
        bool isEntity;
    }

    mapping (address => Entity) entities;

    function addEntity(uint _data) public returns (bool success) {
        require(!entities[msg.sender].isEntity);
        entities[msg.sender].data = _data;
        entities[msg.sender].isEntity = true;
        return true;
    }

    function updateEntity(uint _data) public returns (bool success) {
        require(entities[msg.sender].isEntity);
        entities[msg.sender].data = _data;
        return true;
    }
}