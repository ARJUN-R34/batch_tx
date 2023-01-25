// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract TokenBatchTx {

    using SafeMath for uint256;

    ERC20 public token;

    // mapping to keep track of admins
    mapping (address => bool) public whitelistedUsers;

    // Modifier to check if the function caller is an admin
    modifier onlyAdmin() {
        require(whitelistedUsers[msg.sender] == true, "Only admin can call this function.");
        _;
    }

    constructor(address _token) {
        token = ERC20(_token);
        whitelistedUsers[msg.sender] = true;
    }

    // admin function to add a new admin
    function addAdmin(address newAdmin) public onlyAdmin returns (bool) {
        require(newAdmin != address(0), "Invalid admin address");

        whitelistedUsers[newAdmin] = true;

        return true;
    }

    // To transfer tokens from Contract to the provided list of token holders with respective amount
    function batchTransfer(address fromAddress, address[] memory targetAddresses, uint256[] memory amounts) external onlyAdmin {
        require(targetAddresses.length == amounts.length, "Invalid number of recipients and amounts");

        for (uint256 indx = 0; indx < targetAddresses.length; indx++) {
            require(token.transferFrom(fromAddress, targetAddresses[indx], amounts[indx]), "Unable to transfer token to the account");
        }
    }

}