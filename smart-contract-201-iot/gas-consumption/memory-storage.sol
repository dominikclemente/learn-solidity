pragma solidity 0.8.0;

contract C {

        uint[] storageArray; //storage

        // assign by copy
        // assign by reference

        //storage -> memory = COPY
        //memory -> storage = COPY

        //memory -> memory = REFERENCE
        //storage -> local storage = REFERENCE

        function f(uint[] memory memoryArray) public { //[1, 2, 3]
            storageArray = memoryArray; //copy memoryArray into storageArray
            // you can't push to memory arrays, they have a fixed static size
            //memoryArray.push(4); //memArr = [1,2,3,4] storArr = [1,2,3] 
            

            uint[] storage pointerArray = storageArray;

            pointerArray.push(7); //push into storageArr

            memoryArray = pointerArray; //copy [1,2,3,7] into memArr 
        }
}