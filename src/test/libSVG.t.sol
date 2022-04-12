// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";

import {libSVG} from "../libSVG.sol"; 


contract libSVGTest is DSTest {
    
    function setUp() public {}

    function testLibrary() public {
        
        string memory attributes = string(abi.encodePacked(libSVG.viewBox(0, 0, 350, 350), libSVG.preserveAspectRatio(libSVG.alignmentValues.Min, libSVG.alignmentValues.Min, true)));

        emit log_string(libSVG.svg(attributes, libSVG.text("test", 10, 20,"")));
        
    }

    function testBasic() public {
        string memory base = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 350 350" preserveAspectRatio="xMinYMin meet"><text x="10 y="20">test</text></svg>';

        emit log_string(base);


    }
}
