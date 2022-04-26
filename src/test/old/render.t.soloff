// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "ds-test/test.sol";

import {svg} from "../SVG.sol";
import {utils} from "../Utils.sol";
import {json} from "../JSON.sol";

contract renderTest is DSTest {

    function setUp() public {}

    function testRender() public returns (string memory output) {
        
        string memory outputBase = render(1);

        output = renderSVG(1);

        emit log_string(output);

        assertEq(output, outputBase);

        return output;
    }

    function testJSON() public returns (string memory output){
        string memory rawSVG = renderSVG(1);

        output = json.formattedMetadata('\\"test',string.concat(json.DOUBLE_QUOTES, 'test description', json.DOUBLE_QUOTES),rawSVG);

        emit log_string(output);

    }

    function testEscape() public {
        string memory output;

        output = json._prop('\\"test', string.concat(json.DOUBLE_QUOTES, 'test description', json.DOUBLE_QUOTES));
        
        emit log_string(output);
    }

    function render(uint256 _tokenId) public pure returns (string memory) {
        return
            string.concat(
                '<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300" style="background:#000" >',
                svg.text(
                    string.concat(
                        svg.prop('x', '20'),
                        svg.prop('y', '40'),
                        svg.prop('font-size', '22'),
                        svg.prop('fill', 'white')
                    ),
                    string.concat(
                        svg.cdata('Hello, token #'),
                        utils.toString(_tokenId)
                    )
                ),
                svg.rect(
                    string.concat(
                        svg.prop('fill', 'purple'),
                        svg.prop('x', '20'),
                        svg.prop('y', '50'),
                        svg.prop('width', utils.toString(160)),
                        svg.prop('height', utils.toString(10))
                    ),
                    utils.NULL
                ),
                '</svg>'
            );
    }

    function renderSVG(uint256 _tokenId) public pure returns (string memory) {
        return
            string.concat(
                svg._svg(
                    string.concat(
                        svg.prop('xmlns', 'http://www.w3.org/2000/svg'),
                        svg.prop('width', '300'),
                        svg.prop('height', '300'),
                        svg.prop('style', 'background:#000')
                    ),
                    string.concat(
                        svg.text(
                            string.concat(
                                svg.prop('x', '20'),
                                svg.prop('y', '40'),
                                svg.prop('font-size', '22'),
                                svg.prop('fill', 'white')
                            ),
                            string.concat(
                                svg.cdata('Hello, token #'),
                                utils.toString(_tokenId)
                            )
                        ),
                        svg.rect(
                            string.concat(
                                svg.prop('fill', 'purple'),
                                svg.prop('x', '20'),
                                svg.prop('y', '50'),
                                svg.prop('width', utils.toString(160)),
                                svg.prop('height', utils.toString(10))
                            ),
                            utils.NULL
                        )
                    )
                )
            );
    }
}