// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract HashFunc {
    function hash(string memory text, uint num, address addr) external pure returns (bytes32){
        //transform input to the bytes firts
        return keccak256(abi.encodePacked(text, num, addr));
    }

    //abi.encode encodes the data into bytes
    //abi.encondePacked encodes the data into bytes it compresses in the output will be smaller and it 
    //reduce some of the information that was contained in abi encode

    function encode(string memory text0, string memory text1) external pure returns (bytes memory){
        return abi.encode(text0, text1);
    }

    function encodePacked(string memory text0, string memory text1) external pure returns (bytes memory){
        return abi.encodePacked(text0, text1);
    }
    //for avoid colision use encode
    function collision(string memory text0, uint x, string memory text1), external pure returns(bytes32){
        return keccak256(abi.encodePacked(text0, text1));
    }
}
