//SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;
import {utils} from './Utils.sol';
import {svg} from './SVG.sol';
import {json} from './JSON.sol';

contract customSVG {

    struct ELEMENT {
        bytes4 functionSig;
        string props;
        string children;
    }

    struct PICTURE {
        ELEMENT[] elements;
    }

    mapping(uint256 => PICTURE) private pictures;

    function Circle(string memory props, string memory children) public pure returns (string memory) {
        return svg.circle(props, children);
    }

    function Text(string memory props, string memory children) public pure returns (string memory) {
        return svg.text(props, children);
    }

    function addPictureElement(uint256 picId, ELEMENT memory _element) public {
        pictures[picId].elements.push(_element);
    }

    function pictureLength(uint256 picId) public view returns (uint256) {
        return pictures[picId].elements.length;
    }

    function checkElements(uint256 picId, uint256 elementId) public view returns (ELEMENT memory) {
        return pictures[picId].elements[elementId];
    }

    function viewPicture(uint256 picId) public returns (string memory output) {
        string memory returnedElements;
        PICTURE storage picture = pictures[picId];
        require(picture.elements.length != 0, 'No picture elements');

        bool success;
        bytes memory data;

        for (uint256 i = 0; i < picture.elements.length; i++) {
            (success, data) = address(this).delegatecall(
                abi.encodeWithSelector(
                    picture.elements[i].functionSig, 
                    picture.elements[i].props, 
                    picture.elements[i].children
                )
            );
            returnedElements = string.concat(returnedElements, abi.decode(data, (string)));
        }
        
        output = svg._svg(
                string.concat(
                    svg.prop('width', '300'),
                    svg.prop('height', '300'),
                    svg.prop('style', 'background:#000')
                ),
                returnedElements
        );
        
        return output;
    }

}