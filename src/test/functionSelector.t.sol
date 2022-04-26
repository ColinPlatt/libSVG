// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.12;

import "ds-test/test.sol";
import {svg} from "../SVG.sol";
import {customSVG} from "../customSVG.sol";


contract funcSelector is customSVG, DSTest{

    customSVG svgContract;

    event log_bytes4            (bytes4);

    function setUp() public {
        svgContract = new customSVG();
    }

    function createElements() public {
        customSVG.ELEMENT memory circleEl;
        customSVG.ELEMENT memory textEl;

        string memory circleProps = string.concat(
            svg.prop('cx', '100'),
            svg.prop('cy', '50'),
            svg.prop('r', '25'),
            svg.prop('fill', 'red')
        );

        circleEl = customSVG.ELEMENT({
            functionSig: svgContract.Circle.selector,
            props: circleProps,
            children: ''
        });

        string memory textProps = string.concat(
            svg.prop('x', '10'),
            svg.prop('y', '100'),
            svg.prop('fill', 'white')
        );

        textEl = customSVG.ELEMENT({
            functionSig: svgContract.Text.selector,
            props: textProps,
            children: 'test'
        });

        svgContract.addPictureElement(0, circleEl);
        svgContract.addPictureElement(0, textEl);

        

    }

    /*
    struct ELEMENT {
        bytes4 functionSig;
        string props;
        string children;
    }

    struct PICTURE {
        ELEMENT[] elements;
    }
    */

    function testSelectors() public {

        createElements();

        assertEq(2, svgContract.pictureLength(0));

        emit log_string(svgContract.viewPicture(0));

        customSVG.ELEMENT memory newTextEl;

        string memory newTextProps = string.concat(
            svg.prop('x', '10'),
            svg.prop('y', '120'),
            svg.prop('fill', 'white')
        );

        newTextEl = customSVG.ELEMENT({
            functionSig: svgContract.Text.selector,
            props: newTextProps,
            children: 'more text'
        });

        svgContract.addPictureElement(0, newTextEl);

        assertEq(3, svgContract.pictureLength(0));

        emit log_string(svgContract.viewPicture(0));

    }

}

