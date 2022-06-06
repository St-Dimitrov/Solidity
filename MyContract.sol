// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "hardhat/console.sol";

contract MyContract {
    function _getRandomNumber() private pure returns (uint) {
        return 9;
    }

    function payMeBackLess() external payable {
    uint256 randomNumber = _getRandomNumber();
    console.log("this was the random number: ", randomNumber);
    require(randomNumber < 5, "this will always happen");
    uint256 ethRefund = msg.value / randomNumber;
    payable(msg.sender).transfer(ethRefund);// not recomended transfer
    }
}