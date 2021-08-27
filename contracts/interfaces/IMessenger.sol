// SPDX-License-Identifier: MIT

pragma solidity >=0.6.12 <0.8.0;
pragma experimental ABIEncoderV2;

interface IMessenger {
    function sendCrossDomainMessage(bytes memory _calldata) external;
}
