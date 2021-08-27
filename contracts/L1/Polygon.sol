// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import "../interfaces/optimism/messengers/iOVM_L1CrossDomainMessenger.sol";
import "./Messenger.sol";

/**
 * @notice Deployed on layer-1
 */

contract Polygon is Messenger {
    // state sender contract
    IFxStateSender public fxRoot;

    // child tunnel contract which receives and sends messages
    address public fxChildTunnel;

    constructor(
        address _authorisedCaller,
        address _fxRoot,
        address _fxChildTunnel
    ) public MessengerWrapper(_authorisedCaller) {
        setFxRoot(_fxRoot);
        setFxChildTunnel(_fxChildTunnel);
    }

    // set fxChildTunnel if not set already
    function setFxChildTunnel(address _fxChildTunnel) public {
        require(fxChildTunnel == address(0x0), "MSG: FX_CHILD_ALREADY_SET");
        fxChildTunnel = _fxChildTunnel;
    }

    // set fxRoot if not set already
    function setFxRoot(address _fxRoot) public {
        require(_fxRoot == address(0x0), "MSG: FX_ROOT_ALREADY_SET");
        fxRoot = _fxRoot;
    }

    /**
     * @dev Sends a message to the l2BridgeAddress from layer-1
     * @param _to Receiver on the destination for the calldata
     * @param _calldata The data that l2BridgeAddress will be called with
     */
    function sendCrossDomainMessage(address _to, bytes memory _calldata) public override onlyAuth {
        fxRoot.sendMessageToChild(fxChildTunnel, abi.encode(msg.sender, _calldata));
    }
}
