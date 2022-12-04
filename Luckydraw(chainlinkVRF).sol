pragma solidity ^0.8.0;

// Import the Chainlink library
import "https://github.com/smartcontractkit/chainlink/tree/master/evm-contracts/src/v0.6/ChainlinkClient.sol";

// Set the address of the VRF oracle
// Replace VRF_ORACLE_ADDRESS with the actual address of the oracle
address private vrfOracleAddress = VRF_ORACLE_ADDRESS;

// Set the fee percentage for the contract owner
uint256 private ownerFeePercentage = 20;

// Set the address of the contract owner
// Replace OWNER_ADDRESS with the actual address of the owner
address private ownerAddress = OWNER_ADDRESS;

// Create an instance of the ChainlinkClient contract
ChainlinkClient public vrfOracle;

// Create a constructor to set the VRF oracle address and initialize the ChainlinkClient contract
constructor() public {
  vrfOracle = new ChainlinkClient(vrfOracleAddress);
}

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

// Define a function to randomly select a winner using the VRF oracle
function selectWinner() public {
  // Set the parameters for the VRF request
  // The input data for the request is a hash of the concatenated addresses of the participants
  bytes32 inputData = keccak256(abi.encodePacked(participants));
  Chainlink.Request memory request = buildChainlinkRequest(inputData, vrfOracle.address, this, abi.encodePacked(this.selectWinner.selector));

  // Send the VRF request to the oracle
  vrfOracle.send(request);
}

// Define the callback function to be called by the VRF oracle
function fulfill(bytes32 output) public {
  // Decode the VRF output and extract the winning index
  uint256 winningIndex = output[output.length - 1];

  // Calculate the number of participants in the draw
  uint256 numParticipants = participants.length;

  // Check that the winning index is valid
  require(winningIndex < numParticipants, "Invalid winning index");

  // Retrieve the address of the winning participant
  address winner = participants[winningIndex];

  // Calculate the amount
