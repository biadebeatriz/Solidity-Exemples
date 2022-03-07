// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// 3 ways to send ETH
// transfer - 2300 gas, reverts
// sedn 2300 gas, returns bool
// call - all gas, return bool and data


//pay when this contract is deployed for receive ether
contract SendEther{

    contract() payable{}

    //other way
    fallback() external payable{}
    //we're only going to receive ether and if you try call a function that
    //tahat does not exist inside this contract so tour function call will fail 
    receive() external payable{}

    function sendViaTransfer(address payable _to) external payable{
        _to.transfer(123);
   
    }

    function sendViaSend(address payable _to) external payable{
        bool sent _to.send(123);
        require(send, "send failed");
    }

    function sendViaCall(address payable _to) external payable{
        (bool sucess) = _to.call{value: 123}("");
        require(sucess, "call failed");
    }

}

contract EtheReceiver {
    event Log(uint amoubt, uint gas);

    receive() external payable{
        emit Log(msg.value, gasleft());
    }
}