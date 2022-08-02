// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity >=0.7.0 <0.9.0;
 
contract TestDelegateCall{
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) external payable{
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract DelegateCall{
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _test, uint _num) external payable{
        //_test.delegatecall(abi.encodeWithSignature("setVars(uin256)", num));
       (bool sucess, bytes memory data) = _test.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );
        require(sucess, "delegateCall failed");
    }
}
