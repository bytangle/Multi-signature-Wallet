// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.16;

/**
 @title Main Wallet interface
 @author Bytangle (Edicha Joshua)
 @dev This interface contains the standard API for the multi-sig wallet
 */
interface IThurskWallet {
    /**
     * @dev emitted when a transaction is submitted
     * @param _trxId the transaction of the identifier
     */
    event TrxSubmitted(uint256 indexed _trxId);

    /**
     * @dev this event is emitted when a transaction is confirmed
     * @param _sender the address of the sender
     * @param _trxId transaction id
     */
    event TrxConfirmed(address indexed _sender, uint256 indexed _trxId);

    /**
     * @dev emitted when a transaction is executed
     * @param _trxId transaction identifier
     */
    event TrxExecuted(uint256 indexed _trxId);

    /**
     * @dev this event is emitted when a transaction is revoked
     * @param _sender the address of the sender
     * @param _trxId transaction id
     */
    event TrxRevoked(address indexed _sender, uint256 indexed _trxId);

    /**
     * @dev this event is emitted when transaction fails
     * @param _trxId the transaction identifier
     */
    event TrxFailed(uint256 indexed _trxId);
    
    /**
     * @dev emitted when a new owner is added
     * @param _owner the address of the new owner
     */
    event NewOwnerAdded(address indexed _owner);

    /**
     * @dev emitted when an owner is removed
     * @param _owner address of the removed owner
     */
    event OwnerRemoved(address indexed _owner);

    /**
     * @dev this event is emitted when a deposit occurs
     * @param _sender the depositor address
     * @param _amt amount deposited
     */
    event Deposit(address indexed _sender, uint256 _amt);

    /**
     * @dev emitted when their is a requirement changes
     * @param _required id of the requirement
     */
    event RequirementChange(uint256 _required);
}