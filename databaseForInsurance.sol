// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract InsurancePolicyChecker {
    string insurancePolicy;

    mapping(string => string) public retrieveInsurancePolicy;

    struct Client {
        string insurancePolicy;
        string icNumber;
    }
    Client[] public client;

    function addNewClient(
        string memory _icNumber,
        string memory _insurancePolicy
    ) public {
        client.push(Client(_insurancePolicy, _icNumber));
        retrieveInsurancePolicy[_icNumber] = _insurancePolicy;
    }
}
