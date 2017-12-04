pragma solidity ^0.4.16;

contract Owned {

  address public owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  function Owned() public {
    owner = msg.sender;
  }

  function changeOwner(address _newOwner) public isOwner {
    OwnershipTransferred(owner, _newOwner);
    owner = _newOwner;
  }

  modifier isOwner() {
    require(msg.sender == owner);
    _;
  }

  modifier isNotOwner() {
    require(msg.sender != owner);
    _;
  }
}