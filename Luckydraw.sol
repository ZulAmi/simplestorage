pragma solidity ^0.8.0;

// Set the fee percentage for the contract owner
uint256 private ownerFeePercentage = 20;

// Set the address of the contract owner
// Replace OWNER_ADDRESS with the actual address of the owner
address private ownerAddress = OWNER_ADDRESS;

// Create a mapping to store the addresses of the participants
// and the amounts they have contributed to the pool
mapping(address => uint256) public contributions;

// Create a variable to track the total amount in the pool
uint256 public totalPool;

// Create an event to be emitted when a participant enters the draw
event EnteredDraw(address indexed participant, uint256 contribution);

// Define a function to allow participants to enter the draw
function enterDraw() public payable {
  // Check that the sender is not the contract owner
  require(msg.sender != ownerAddress, "The contract owner cannot enter the draw");

  // Add the sender's contribution to the pool
  contributions[msg.sender] += msg.value;
  totalPool += msg.value;

  // Emit the EnteredDraw event
  emit EnteredDraw(msg.sender, msg.value);
}

// Define a function to allow the owner to withdraw their fee
function withdrawFee() public {
  // Check that the sender is the contract owner
  require(msg.sender == ownerAddress, "Only the contract owner can withdraw the fee");

  // Calculate the fee amount
  uint256 feeAmount = (ownerFeePercentage * totalPool) / 100;

  // Check that the fee amount is not zero
  require(feeAmount != 0, "The fee amount is zero");

  // Send the fee amount to the owner
  ownerAddress.transfer(feeAmount);
}
