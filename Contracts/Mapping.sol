// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

//["alice", "bob", "charlie"]
// {"alice": true, "bob": true, "charlie":true}

contract Mapping{
//mapping(key => value)
    mapping(address =>  uint) public balances;
    //mapeia os address is a friend of other address
    mapping(address => mapping(address => bool)) public isFriend; 

    function examples() external {
        //set 
        balances[msg.sender] = 123;
        uint= balances[msg.sender];
        uint bal2 = balances[address(1)]; //0
        //update
        balances[msg.sender] = 456;
        //increment
        balances[msg.sender] += 456;

        //clear
        //delegate balances[msg.sender];

        isFriend[msg.sender][address(this)]=true;
    }



}