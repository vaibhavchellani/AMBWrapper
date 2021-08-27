// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import "../interfaces/optimism/messengers/iOVM_L1CrossDomainMessenger.sol";
import "./Messenger.sol";

/**
 * @notice Deployed on layer-1
 */

contract Optimism is Messenger {
    iOVM_L1CrossDomainMessenger public immutable l1MessengerAddress;
    uint256 public immutable defaultGasLimit;

    constructor(
        address _authorisedCaller,
        iOVM_L1CrossDomainMessenger _l1MessengerAddress,
        uint256 _defaultGasLimit
    ) public MessengerWrapper(_authorisedCaller) {
        defaultGasLimit = _defaultGasLimit;
    }

    /**
     * @dev Sends a message to the l2BridgeAddress from layer-1
     * @param _to Receiver on the destination for the calldata
     * @param _calldata The data that _to address will be called with
     */
    function sendCrossDomainMessage(address _to, bytes memory _calldata) public override onlyL1Bridge {
        l1MessengerAddress.sendMessage(_to, _calldata, uint32(defaultGasLimit));
    }
}
