pragma solidity 0.8.0;

contract ArrayStorage {

    struct Entity {
        uint data;
        address _address;
    }

    Entity[] entities;

    function addEntity(address _entityAdress, uint _entityData) public returns (bool success){
        Entity memory newEntity;
        newEntity.data = _entityData;
        newEntity._address = _entityAdress;
        entities.push(newEntity);
        return true;
    }

    function updateEntity(uint _index, uint _data) public returns (bool success){
        // ensure the editor is the owner of the address
        require(entities[_index]._address == msg.sender);
        entities[_index].data = _data;
        return true;
    }
} 