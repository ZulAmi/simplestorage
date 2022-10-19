// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract C {
    // data[n] is an array of uints
    uint256[][] data;

    function append(uint256 _a, uint256 _b) public {
        data.push([_a, _b]);
    }

    function read(uint256 _idx) public view returns (uint256) {
        return data[_idx].retrieve();
    }
}
