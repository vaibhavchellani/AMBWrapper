// SPDX-License-Identifier: MIT

pragma solidity >=0.6.12 <0.8.0;
pragma experimental ABIEncoderV2;

import "../interfaces/IMessenger.sol";

abstract contract Messenger is IMessenger {
    address public immutable authorisedCaller;

    constructor(address _authorisedCaller) internal {
        authorisedCaller = _authorisedCaller;
    }

    modifier onlyAuth() {
        require(msg.sender == authorisedCaller, "Sender must be the authorised");
        _;
    }
}
