// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./interfaces/IToken.sol";

contract Wallet {
  event SetTokenContractAddress(address _tokenAddr);
  event Receive(address indexed sender, uint amount, uint balance);
  event MintSmartTokensForTokens();

  address payable public owner;

  address tokenAddr;

  constructor() {
    owner = payable(msg.sender);
  }

  function setTokenContractAddress(address _tokenAddr) public virtual {
    tokenAddr = _tokenAddr;
    emit SetTokenContractAddress(tokenAddr);
  }

  receive() external payable {
    emit Receive(msg.sender, msg.value, address(this).balance);
    mintSmartTokensForTokens();
  }

  function mintSmartTokensForTokens() public {
    IToken(tokenAddr).mint();
    emit MintSmartTokensForTokens();
  }
}
