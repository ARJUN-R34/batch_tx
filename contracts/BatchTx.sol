// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BatchTokenTransfer {

    ERC20 public erc20;

    // mapping to keep track of admins
    mapping (address => bool) public whitelistedUsers;

    constructor(address _token) {
        erc20 = ERC20(_token);
        whitelistedUsers[msg.sender] = true;
    }

    // Modifier to check if the function caller is an admin
    modifier onlyAdmin() {
        require(whitelistedUsers[msg.sender] == true, "Only admin can call this function.");
        _;
    }

    // admin function to add a new admin
    function addAdmin(address newAdmin) public onlyAdmin returns (bool) {
        require(newAdmin != address(0), "Invalid admin address");

        whitelistedUsers[newAdmin] = true;

        return true;
    }

    // event to emit when a batch transfer is complete
    event BatchTransfer(address fromAddress, address[] recipients, uint256[] amounts);

    // sample event to check allowance
    event Allowance(address spender, address owner, uint256 amount);

    // function to perform batch transfer of tokens
    function batchTransfer(address fromAddress, address[] memory recipients, uint256[] memory amounts) public onlyAdmin {
        require(recipients.length == amounts.length, "Invalid input: mismatched number of recipients and amounts.");

        // loop through recipients and amounts to transfer tokens
        for (uint256 i = 0; i < recipients.length; i++) {
            // check if the address is a valid Ethereum address
            require(recipients[i] != address(0), "Invalid input: recipient address is not valid.");

            // check if the amount is greater than 0
            require(amounts[i] > 0, "Invalid input: transfer amount must be greater than 0.");

            // transfer tokens
            erc20.transferFrom(fromAddress, recipients[i], amounts[i]);
        }

        // emit event
        emit BatchTransfer(fromAddress, recipients, amounts);
    }
}
