// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";

import {libSVG} from "../libSVG.sol"; 


contract libSVGTest is DSTest {
    using libSVG for *;


    function setUp() public {}

    function testLibrary() public {
        
        string memory attributes = string(abi.encodePacked(0.viewBox(0, 350, 350), libSVG.alignmentValues.Min.preserveAspectRatio(libSVG.alignmentValues.Min, true)));

        string[] memory styleAttributes = new string[](3);
        string[] memory styleValues = new string[](3);

        styleAttributes[0] = 'fill';
        styleAttributes[1] = 'font-family';
        styleAttributes[2] = 'font-size';

        styleValues[0] = 'black';
        styleValues[1] = 'serif';
        styleValues[2] = '14px';
    
        emit log_string(attributes.svg(string(abi.encodePacked(
                                                                'base'.style(
                                                                    libSVG.attributeList(
                                                                        styleAttributes,
                                                                        styleValues)
                                                                )
                                                                ,"test".text(
                                                                    10,
                                                                    20,
                                                                    ' class="base"'
                                                                )
                                                            )
                                                )
                                        )
                        );

        
    }

    function testBasic() public {
        string memory base = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 350 350" preserveAspectRatio="xMinYMin meet"><text x="10 y="20">test</text></svg>';

        emit log_string(base);


    }
}
