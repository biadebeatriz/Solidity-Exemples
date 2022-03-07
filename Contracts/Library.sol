// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

library Math{
//if you declare with public library have to deploy before another coontracts
    functions max(uint x, uint y) internal pure returns (uint) {
    returns x >=y ? x : y;
    }
}

contract testMax(uint x, uint y) external pure returns (uint){
    return Math.max(x,y);
}

library ArrayLib {
    //since we're going to be calling the function find on this state variable array, 
    //this input will be storage
    //can not be pure
    function find(uint[] storage arr, uint x) internal view returns (uint){
        for(uint i = 0; i < arr.length; i++){
            if (arr[i] == x){
                return i;
            }
        }
        revert("not found");
    }
}

contract TestArray {
    using ArrayLib for uint[];
    uint[] public arr = [3,2,1];

    function testFind() external view returns (uint i){
        //return ArrayLib.find(arr, 2);
        return arr.find(2);
    }
}