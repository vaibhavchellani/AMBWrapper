// SPDX-License-Identifier: MIT

pragma solidity >=0.6.12 <0.8.0;
pragma experimental ABIEncoderV2;

import "../interfaces/IMessenger.sol";

abstract contract Messenger  is IMessenger {
	string name;
    constructor(string memory _namej) internal {
        name = _name;
    }
}
