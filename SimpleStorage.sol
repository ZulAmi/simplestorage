// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8; // 0.8.12

contract SimpleStorage {
    // boolean, uint, int, address, bytes
    // bool hasFavouriteNumber = false;
    // uint256 hasFavouriteNumber = 123;
    // uint256 hasFavouriteNumber without number will be null value "0"
    // string favoutiteNumberInText = "five";
    // int256 favouriteInt = -5;
    // address myAddress = 0xF9614b1724250F9e814e015034Eb58A1dbF8A012;
    // bytes32 favouriteBytes = "cat";

    // if no visibility declared, it will be internal
    uint256 favoriteNumber;

    mapping(string => uint256) public nametoFavoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // uint256[] public favoriteNumberList;
    // empty [] Dynamic array
    People[] public people;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    //view,pure doesn't use gas, it just reads the variable. It doesn't affect anything on the blockchain
    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    // calldata, memory, storage
    // calldata - variable that exists temporarily that cannot be modified
    // memory - variable that exists temporarily that can be modified
    // storage - vriables that exists permanently that can be modified

    // Strings are secretly an array so need MEMORY
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nametoFavoriteNumber[_name] = _favoriteNumber;
    }

    // 0xd9145CCE52D386f254917e481eB44e9943F39138
}
