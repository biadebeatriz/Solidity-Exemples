// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract StoringData {
    function setData(uint256 newValue) public {
        assembly{
            sstore(0, newValue)
        }
    }

    function getData() public view returns(uint256){
        assembly{
            let v := sload(0)
            mstore(0x80,v) // nao é possivel retornar diretamente entao é preciso guardar ela antes
            return(0x80,32)
        }
    }
}