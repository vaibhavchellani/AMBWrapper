// SPDX-License-Identifier: MIT
// @unsupported: ovm

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import "../interfaces/arbitrum/messengers/IInbox.sol";
import "../interfaces/arbitrum/messengers/IBridge.sol";
import "../interfaces/arbitrum/messengers/IOutbox.sol";
import "./MessengerWrapper.sol";

/**
 * @notice Deployed on layer-1
 */

contract Arbitrum is MessengerWrapper {
    IInbox public arbInbox;

    uint256 public immutable defaultGasPrice;
    uint256 public immutable defaultCallValue;
    uint256 public immutable defaultGasLimit;

    constructor(
        address _authorisedCaller,
        IInbox _arbInbox,
        uint256 _defaultGasLimit,
        uint256 _defaultGasPrice,
        uint256 _defaultCallValue
    ) public MessengerWrapper(_authorisedCaller) {
        arbInbox = _arbInbox;
        defaultGasLimit = _defaultGasLimit;
        defaultGasPrice = _defaultGasPrice;
        defaultCallValue = _defaultCallValue;
    }

    /**
     * @dev Sends a message to the l2BridgeAddress from layer-1
     * @param _calldata The data that l2BridgeAddress will be called with
     */
    function sendCrossDomainMessage(address _to, bytes memory _calldata) public override onlyL1Bridge {
        uint256 maxSubmissionCost = defaultGasLimit * defaultGasPrice;
        arbInbox.createRetryableTicket(_to, 0, 0, tx.origin, address(0), 100000000000, 0, _calldata);
    }
}
