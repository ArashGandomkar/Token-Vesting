// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/utils/SafeERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/ReentrancyGuard.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Vesting is Ownable, ReentrancyGuard {

    using SafeERC20 for IERC20;
    IERC20 public immutable token;
    uint256 public immutable releaseTime;
    uint256 public totalAllocated;
    uint256 public totalDeposited;
    uint256 public totalClaimed;
    struct Team {
        uint16 id;
        uint256 allocation;
        bool claimed;
        bool exists;
    }
    mapping (address => Team) public teams;
    mapping (uint16 => bool) public usedIds;
    address[] public teamAddresses;

    event PersonAdded(uint256 indexed id, address indexed wallet, uint256 allocation);
    event TokensDeposited(address indexed from, uint256 amount);
    event VestingClaimed(uint16 indexed id, address indexed wallet, uint256 amount);

    constructor(IERC20 _token, uint256 _releaseTime)
    Ownable(_msgSender()) {
        require(address(_token) != address(0), "Invalid token address");
        require(_releaseTime > block.timestamp, "Invalid release time");
        token = _token;
        releaseTime = _releaseTime;
    }
    
    function addPerson(uint16 _id, address _wallet, uint256 _allocation) external onlyOwner {

        require(_wallet != address(0), "Invalid address");
        require(!teams[_wallet].exists, "Already exists");
        require(_allocation > 0, "Vesting: Allocation must be positive.");
        require(totalAllocated + _allocation <= totalDeposited, "Not enough deposited tokens");
        require(!usedIds[_id], "ID already used.");
        totalAllocated += _allocation;
        usedIds[_id] = true;
        teams[_wallet] = Team({
            id: _id,
            allocation: _allocation,
            claimed: false,
            exists: true
        });
        teamAddresses.push(_wallet);
        emit PersonAdded(_id, _wallet, _allocation);
    }

    function getUserInfo(address _user)
    external view 
    returns(
        uint16 id,
        uint256 allocation,
        bool claimed,
        bool exists
    ) {
        Team memory member = teams[_user];
        return(
            member.id,
            member.allocation,
            member.claimed,
            member.exists
        );
    }

    function contractBalance() external view returns(uint256) {
    return token.balanceOf(address(this));
    }

    function remainingTokens() external view returns(uint256) {
    return totalAllocated - totalClaimed;
    }

    function depositTokens(uint256 _amount) external onlyOwner {
        
        require(_amount >  0, "Vesting: Amount must be positive.");
        token.safeTransferFrom(owner(), address(this), _amount);
        totalDeposited += _amount;
        emit TokensDeposited(msg.sender, _amount);
    }
    
    function release() nonReentrant public {

        Team storage member = teams[msg.sender];
        require(member.exists, "Not a team member");
        require(!member.claimed, "Already claimed");
        require(block.timestamp >= releaseTime, "Vesting time not reached yet");

        uint256 amountToRelease = member.allocation;
        require(token.balanceOf(address(this)) >= amountToRelease, "Insufficient balance");
        member.claimed = true;
        
        token.safeTransfer(msg.sender, amountToRelease);
        totalClaimed += amountToRelease;
        emit VestingClaimed(member.id, msg.sender, amountToRelease);
    }
}