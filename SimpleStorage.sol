//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract SimpleStorage {
    uint256 value;

    function setValue(uint256 _value) public {
        value = _value;
    }

    function exposeValue() public view returns(uint256) {
        return value;
    }
}