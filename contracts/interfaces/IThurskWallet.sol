// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.16;

/**
 @title Main Wallet interface
 @author Edicha Joshua <mredichaj@gmail.com>
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
     * @dev emitted when their is a confirmation requirement changes
     * @param _required id of the requirement
     */
    event RequirementChange(uint256 _required);

    /**
     * @dev used with revert for unauthorized operations
     */
    error Unauthorized(string msg);

    /// @dev Trasaction data structure
    struct Trx {
        address dest;
        uint256 amt;
        bytes data;
        bool executed;
    }

    /**
     * @notice adds new owner to the available owners
     * @dev only wallet can perform this action and owner can only be added if it doesn't exist and not a zero address
     * Note: must emit {NewOwnerAdded} event
     * @param _owner address of the new owner
     */
    function addOwner(address _owner) external;

    /**
     * @notice removes existing owner
     * @dev `_owner` has to exist and only wallet can perform this action
     * @param _owner address of the owner to be removed
     * Note: must emit {OwnerRemoved} event
     */
    function removeOwner(address _owner) external;

    /**
     * @notice change the one of the owners of the wallet
     * @dev `_currentOwner` and `_newOwner` must not be zero addresses and only wallet can perform this action
     * @param _currentOwner address of current owner to replace
     * @param _newOwner address of new owner
     */
    function replaceOwner(address _currentOwner, address _newOwner) external;

    /**
     * @notice update the number of required confirmations
     * @notice action can only ber performed by wallet
     * @param _required the new required confirmations
     */
    function updateRequirement(uint256 _required) external;

    /**
     * @notice submit a transaction for approval
     * @dev must emit {TrxSubmitted} event
     * @param _dest address of the destination account
     * @param _amt ether value of the transaction
     * @param _data additional data sent with the transaction
     */
    function submitTransaction(
        address _dest,
        uint256 _amt,
        bytes memory _data
    ) external;

    /**
     * @notice confirm a pending transaction
     * @param _trxId transaction identifier
     */
    function confirmTransaction(uint256 _trxId) external;

    /**
     * @notice revoke transaction confirmation
     * @param _trxId transaction identifier
     */
    function revokeConfirmation(uint256 _trxId) external;

    /**
     * @notice allows any of the owners to execute a confirmed transaction
     * @param _trxId transaction 
     */
    function executeTransaction(uint256 _trxId) external;

    /**
     * @dev check if transaction has already been confirmed
     * @param _trxId transaction identifier
     * @return returns `True` if confirmed else `False`
     */
    function isConfirmed(uint256 _trxId) external returns (bool);
}
