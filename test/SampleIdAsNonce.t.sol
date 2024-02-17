// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {SampleIdAsNonce} from "../src/SampleIdAsNonce.sol";
import {Verifier} from "../src/Verifier.sol";

contract CounterTest is Test {
    SampleIdAsNonce public sampleIdAsNonce;
    Verifier public verifier;

    string DOMAIN = "bob.cel";
    uint256 TIME_STAMP;
    address USER = address(0x2);

    function setUp() public {
        sampleIdAsNonce = new SampleIdAsNonce();
        verifier = new Verifier();

        TIME_STAMP = block.timestamp;
    }

    function test_nonce() public {
        uint256 nonce = sampleIdAsNonce.getId(address(verifier), USER, TIME_STAMP);

        sampleIdAsNonce.setNonce(nonce);

        assertEq(nonce, sampleIdAsNonce.nonce());

        assertEq(sampleIdAsNonce.validateNonce(address(verifier), USER, TIME_STAMP), true);
    }
}
