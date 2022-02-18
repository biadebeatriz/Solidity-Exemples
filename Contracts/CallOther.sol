// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;
//IDEIA: Chamar funções de outros contratos passando o address 
contract CallTestContract{
    function setX(address _test, uint _x) external {
        //the addres of the contract
        TestContract(_test).setX(_x);
    }

//    function setX(TestContract _test, uint _x) external {
        //the addres of the contract
//        (_test).setX(_x);
 //   }

    function getX(address _test) external view returns(uint x){
        //the addres of the contract
        x = TestContract(_test).getX();
        return x;
    }
        function setXandSendEther(address  _test, uint _x) external  payable{
        //the addres of the contract
        TestContract(_test).setXandReceiveEther{value: msg.value}(_x);
    }

    function getXandValue(address _test) external view returns(uint, uint){
        //the addres of the contract
        (uint x, uint value) = TestContract(_test).getXandValue();
        return (x, value);
    }
     
}

contract TestContract {
    uint public x;
    uint public value = 123;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() external view returns (uint) {
        return x;
    }
// payable- that we can send ether to this function
    function setXandReceiveEther(uint _x) external payable{
    x = _x;
    value = msg.value;

    }

    function getXandValue() external view returns (uint, uint){
        return (x,value);
    }
}