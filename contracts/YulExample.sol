// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.16;

/// @title Example contract with an exponentiation function implementation and usage
/// @notice Using Yul intermediary language to implement power function
/// Note: This contract has nothing to do with the Thursk Wallet
contract Practice {
    /**
     * @dev local implementation of an exponentiation function
     * @param base the base number
     * @param exponent the power (the number of times the base will be multiplied by itself)
     * Note: To write Yul in a solidity file, it must be inside this block
     * assembly {
     *    // Your Yul code here
     * }
     */
    function pow(uint256 base, uint256 exponent) public pure returns (uint256 result) {
        assembly {
            // function implementation in Yul
            function power(b, e) -> r {
                switch e
                case 0 { r := 0 }
                case 1 { r := b}
                default {
                    r := power(mul(b, b), div(e, 2))
                    switch mod(e, 2)
                    case 1 { r := mul(b, r)}
                }
            }

            // call the function and assign the result to the contract function return variable
            result := power(base, exponent)
        }
    }

    function _usage() internal pure {
        // just call 
        uint256 twoPowerSix = pow(2, 6);
        uint256 threePowerTen = pow(3, 10);
    }
}