# Solidity Token Vesting Contract

A secure ERC20 token vesting smart contract developed in Solidity.

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
