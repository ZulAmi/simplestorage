pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract Example {
    // Address of the oracle contract
    Oracle public oracle;

    // The current price of the cryptocurrency, as provided by the oracle
    uint256 public cryptoPrice;

    // The ticker symbol of the cryptocurrency (e.g. "BTC" for Bitcoin)
    string public cryptoTicker;

    // Constructor that sets the address of the oracle contract and the ticker symbol
    constructor(address _oracle, string memory _cryptoTicker) public {
        oracle = Oracle(_oracle);
        cryptoTicker = _cryptoTicker;
    }

    // Function to query the oracle contract and update the crypto price
    function updateCryptoPrice() public {
        // Query the oracle contract to get the current crypto price
        (bool success, uint256 price) = oracle.latestAnswer(cryptoTicker);
        require(success, "Failed to query oracle for crypto price");

        // Update the crypto price
        cryptoPrice = price;
    }

    // Function that uses the crypto price
    function useCryptoPrice() public {
        // Do something with the crypto price
        // ...
    }
}
