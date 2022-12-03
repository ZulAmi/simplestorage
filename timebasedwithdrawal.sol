pragma solidity ^0.8.0;

contract Withdrawal {
    address payable owner;
    address payable recipient;
    uint256 public withdrawalTime;

    constructor(address payable _recipient) public {
        owner = 0x;//enter owner of the wallet address
        recipient = _recipient; //enter recipient of the wallet address
        withdrawalTime = block.timestamp + 3650 days;
    }

    function withdraw() public {
        require(block.timestamp >= withdrawalTime, "Time has not yet arrived for the transfer to go through");

        // Send the balance to the recipient
        recipient.transfer(address(this).balance);
    }
}