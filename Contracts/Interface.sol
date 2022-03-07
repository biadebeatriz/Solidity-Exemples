// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

interface ICounter {
    function count() external view returns (uint);
    function inc() external;
}

contract CallInterface {
    uint public count;
    function exakmples(address _counter) external{
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}