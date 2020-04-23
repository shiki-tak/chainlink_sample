pragma solidity >=0.4.21 <0.7.0;

import "@chainlink/contracts/src/v0.4/Chainlinked.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract HelloChainlink is Chainlinked, Ownable {
  // solium-disable-next-line zeppelin/no-arithmetic-operations
  uint256 constant private ORACLE_PAYMENT = 1 * LINK;

  bytes32 internal jobId;
  uint256 public currentPrice;

  event RequestFulfilled(
    bytes32 indexed requestId,  // User-defined ID
    uint256 indexed price
  );

  constructor(address _oracle, bytes32 _jobId) public {
    setLinkToken(0x20fE562d797A42Dcb3399062AE9546cd06f63280);
    setOracle(_oracle);
    jobId = _jobId;
  }

  function requestEthereumPrice() public {
    Chainlink.Request memory req = newRequest(jobId, this, this.fulfill.selector);
    req.add("endpoint", "price");
    req.add("fsym", "ETH");
    req.add("tsyms", "USD");
    req.add("copyPath", "USD");
    chainlinkRequestTo(oracleAddress(), req, ORACLE_PAYMENT);
  }

  function fulfill(bytes32 _requestId, uint256 _price)
    public
  recordChainlinkFulfillment(_requestId)
  {
    emit RequestFulfilled(_requestId, _price);
    currentPrice = _price;
  }
}