// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "ds-test/test.sol";

import {svg} from "../SVG.sol";
import {utils} from "../Utils.sol";
import {json} from "../JSON.sol";

import {LootOriginal, LootLib} from "./LootURI.sol";

contract renderTest is DSTest {

    LootOriginal public loot;
    LootLib public lootLib;
    
    function setUp() public {
        loot = new LootOriginal();
        lootLib = new LootLib();
    }


    function testRenderOriginalLoot() public returns (string memory output) {
        
        output = loot.tokenURI(1);

        emit log_string(output);

        return output;
    }

    function testRenderLibLoot() public returns (string memory output) {
        
        output = lootLib.tokenURI(1);

        emit log_string(output);

        return output;
    }

    function testCompareLoots() public {
        assertEq(loot.tokenURI(1),lootLib.tokenURI(1));
    }

    
}