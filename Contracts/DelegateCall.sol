pragma solidity ^0.8.7;

/*
A calls B, sends 100 wei
    B calls C, sends 50 wei
A----> B ----> C
                msg.sender = B
                msg.value = 50
                execute code on C's state variables
                use ETH in C
A calls B, sends 100 wei
        B delegatecall C
A ---> B ---> C
            msg.sender =A
            msg.value = 100
            execute code on B's state variable
            use ETH in B
*/

contract TestDelegateCall {
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) external payable{
        num =_num;
        sender = msg.sender;
        value = msg.value;
    }

}

contract Delegatecall {
    uint public num;
    address public snder;
    uint public value;

    function setVars(address _test, uint _num) external payable {
//      _test.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num))
        (bool sucess, bytes memory data)=  _test.delegatecall(abi.encodeWithSelector(TestDelegateCall.setVars.selector), _num)
        require(success, "delegatecall fail");
    }
}