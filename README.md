<div align="center">
  
# Solidity Token Vesting Contract
  
<img src="https://bs-uploads.toptal.io/blackfish-uploads/components/blog_post_page/4086045/cover_image/regular_1708x683/cover-time-locked-wallet-truffle-tutorial-f2a5cc7f02e108b6a1994d7b5598fafc.png" alt="Token Vesting Contract" width="800">

### ERC20 Token Locking & Vesting System

Built with Solidity • OpenZeppelin • Gnosis Safe

![License](https://img.shields.io/badge/License-MIT-green)
![Solidity](https://img.shields.io/badge/Solidity-0.8.x-blue)
![Security](https://img.shields.io/badge/Security-ReentrancyGuard-red)
![ERC20](https://img.shields.io/badge/Token-ERC20-purple)

</div>

<br>

## Features

* ERC20 token vesting
* One-time token claim
* Configurable release timestamp
* SafeERC20 integration
* OpenZeppelin ReentrancyGuard
* OpenZeppelin Ownable
* Gnosis Safe multisig ownership support
* Allocation tracking
* Unique beneficiary IDs
* Event logging
* Immutable token and release time configuration

## Smart Contract Overview

The contract allows a project owner to:

1. Deposit ERC20 tokens into the vesting contract.
2. Register team members with predefined token allocations.
3. Lock tokens until a specific release date.
4. Allow beneficiaries to claim their tokens once the vesting period has ended.

## Security Measures

* Reentrancy protection using ReentrancyGuard
* Safe token transfers using SafeERC20
* Multisig administration through Gnosis Safe
* Allocation validation against deposited tokens
* Duplicate beneficiary prevention
* Duplicate ID prevention

## Main Functions

### addPerson()

Adds a new beneficiary and assigns token allocation.

### depositTokens()

Deposits ERC20 tokens into the vesting contract.

### release()

Allows beneficiaries to claim their vested tokens after the release time.

### getUserInfo()

Returns beneficiary information.

### contractBalance()

Returns the current token balance of the vesting contract.

## Technologies Used

* Solidity
* OpenZeppelin Contracts
* Gnosis Safe
* ERC20 Standard

## License

MIT
