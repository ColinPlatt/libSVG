// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

// need to include Base64 and Strings
import {Base64} from "openzeppelin-contracts/contracts/utils/Base64.sol";
import {Strings} from "openzeppelin-contracts/contracts/utils/Strings.sol";

library libSVG {
    using Strings for uint256;

    string internal constant _SVG = 'xmlns="http://www.w3.org/2000/svg"';
    string internal constant _HTML = 'xmlns="http://www.w3.org/1999/xhtml"';
    string internal constant _XMLNS = 'http://www.w3.org/2000/xmlns/ ';
    string internal constant _XLINK = 'http://www.w3.org/1999/xlink ';

    /*//////////////////////////////////////////////////////////////
                                 ELEMENTS
    //////////////////////////////////////////////////////////////*/

    function svg(string memory _attributes, string memory _innerElements) internal pure returns (string memory) {

        string[3] memory parts;

        parts[0] = string(abi.encodePacked('<svg ', _SVG, _attributes, '>'));
        
        parts[1] = _innerElements;

        parts[2] = '</svg>';


        return string(abi.encodePacked(parts[0], parts[1], parts[2]));
    }

    function style(string memory _name, string memory _styleList) internal pure returns (string memory) {
        string[4] memory parts;

        parts[0] = '<style>.';

        parts[1] = _name;

        parts[2] = _styleList;

        parts[3] = '</style>';

        return string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3]));
    }

    function text(string memory _text, uint256 x, uint256 y, string memory _attributes) internal pure returns (string memory) {

        string[6] memory parts;

        parts[0] = '<text';

        parts[1] = xy(x, y);

        parts[2] = _attributes;

        parts[3] = '>';

        parts[4] = _text;

        parts[5] = '</text>';

        return string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]));

    }

    //Basic shapes

    //<circle>, <ellipse>, <line>, <polygon>, <polyline>, <rect>


    function circle(uint256 cx, uint256 cy, uint256 r, string memory _attributes) internal pure returns (string memory) {

        string[5] memory parts;

        parts[0] = '<circle';

        parts[1] = prefacedXY('c', cx, cy);

        parts[2] = prefacedAttrSingle('r', r);

        parts[3] = _attributes;

        parts[4] = '/>';

        return string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4]));

    }

    function ellipse(uint256 cx, uint256 cy, uint256 rx, uint256 ry, string memory _attributes) internal pure returns (string memory) {

        string[5] memory parts;

        parts[0] = '<ellipse';

        parts[1] = prefacedXY('c', cx, cy);

        parts[2] = prefacedXY('r', rx, ry);

        parts[3] = _attributes;

        parts[4] = '/>';

        return string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4]));

    }

    function line(string memory strokeColour, uint256 x1, uint256 y1, uint256 x2, uint256 y2, string memory _attributes) internal pure returns (string memory) {

        string[8] memory parts;

        parts[0] = '<line';

        parts[1] = suffixedXY('1', x1, y1);

        parts[2] = suffixedXY('2', x2, y2);

        parts[3] = ' stroke="';

        parts[4] = strokeColour;

        parts[5] = '"';

        parts[6] = _attributes;

        parts[7] = '/>';

        return string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6], parts[7]));

    }

    function polygon(uint256[2][] memory points, string memory strokeColour, string memory fillColour, string memory _attributes) internal pure returns (string memory) {

        string[9] memory parts;

        parts[0] = '<polygon ';

        parts[1] = _points(points);

        parts[2] = ' fill="';

        parts[3] = fillColour;

        parts[4] = '" stroke="';

        parts[5] = strokeColour;

        parts[6] = '"';

        parts[7] = _attributes;

        parts[8] = '/>';

        return string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6], parts[7], parts[8]));

    }

    function polyline(uint256[2][] memory points, string memory strokeColour, string memory fillColour, string memory _attributes) internal pure returns (string memory) {

        string[9] memory parts;

        parts[0] = '<polyline ';

        parts[1] = _points(points);

        parts[2] = ' fill="';

        parts[3] = fillColour;

        parts[4] = '" stroke="';

        parts[5] = strokeColour;

        parts[6] = '"';

        parts[7] = _attributes;

        parts[8] = '/>';

        return string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6], parts[7], parts[8]));

    }

    function rect(uint256 x, uint256 y, uint256 width, uint256 height, string memory _attributes) internal pure returns (string memory) {
        //<rect x="120" width="100" height="100" rx="15" />

        string[6] memory parts;

        parts[0] = '<rect';

        parts[1] = xy(x, y);

        parts[2] = prefacedAttrSingle("width", width);

        parts[3] = prefacedAttrSingle("height", height);

        parts[4] = _attributes;

        parts[5] = '/>';

        return string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]));


    }


    /*//////////////////////////////////////////////////////////////
                                 ATTRIBUTES
    //////////////////////////////////////////////////////////////*/


    function viewBox(uint256 _minX, uint256 _minY, uint256 _width, uint256 _height) internal pure returns (string memory) {

        return string(abi.encodePacked(' viewBox="', _minX.toString(), ' ', _minY.toString(), ' ', _width.toString(), ' ', _height.toString(), '"'));

    }

    enum alignmentValues {
        Min,
        Max,
        Mid
    }

    function preserveAspectRatio(alignmentValues _x, alignmentValues _Y, bool _meet) internal pure returns (string memory) {
        string memory alignment;

        if(_x == alignmentValues.Min) {
            alignment = '"xMin';
        } else if (_x == alignmentValues.Max){
            alignment = '"xMax';
        } else {
            alignment = '"xMid';
        }

        if(_Y == alignmentValues.Min) {
            alignment = string(abi.encodePacked(alignment,'YMin'));
        } else if (_Y == alignmentValues.Max){
            alignment = string(abi.encodePacked(alignment,'YMax'));
        } else {
            alignment = string(abi.encodePacked(alignment,'YMid'));
        }

        if (_meet) {
            alignment = string(abi.encodePacked(alignment,' meet"'));
        } else {
            alignment = string(abi.encodePacked(alignment,' slice"'));
        }
        
        return string(abi.encodePacked(' preserveAspectRatio=', alignment));

    }

    function xy(uint256 _x, uint256 _y) internal pure returns (string memory) {

        return string(abi.encodePacked(' x="', _x.toString(), '" y="', _y.toString(), '"'));

    }

    //use for cXcY, rXrY, dXdY
    function prefacedXY(string memory _preface, uint256 _x, uint256 _y) internal pure returns (string memory) {

        return string(abi.encodePacked(' ' , _preface, 'x="', _x.toString(), '" ', _preface, 'y="', _y.toString(), '"'));

    }

    function prefacedAttrSingle(string memory _preface, uint256 _attr) internal pure returns (string memory) {

        return string(abi.encodePacked(' ' , _preface, '="', _attr.toString(), '"'));

    }

    //use for x1y1, x2y2 
    function suffixedXY(string memory _suffix, uint256 _x, uint256 _y) internal pure returns (string memory) {

        return string(abi.encodePacked(' x' , _suffix, '="', _x.toString(), '" y', _suffix, '="', _y.toString(), '"'));

    }

    // shouldn't be used directly, should use attributeList functions to wrap it properly
    function _attributeEntry(string memory _attribute, string memory _value) internal pure returns (string memory) {
        return string(abi.encodePacked(_attribute, ': ', _value));
    }

    function attributeList(string memory _attributes, string memory _values) internal pure returns (string memory) {
        return string(abi.encodePacked(' {', _attributeEntry(_attributes, _values), ' }'));
    }

    function attributeList(string[] memory _attributes, string[] memory _values) internal pure returns (string memory) {
        require(_attributes.length == _values.length, "libSVG: Unbalanced Arrays");

        uint256 len = _attributes.length;

        string memory results = ' {';

        for (uint256 i = 0; i<len; i++) {
            results = string(abi.encodePacked(results, _attributeEntry(_attributes[i], _values[i]), '; '));
        }

        return string(abi.encodePacked(results, '}'));
    }

    // for now only deals with integers (i.e. no decimals)
    function _points(uint256[2][] memory pointsArray) internal pure returns (string memory) {
        require(pointsArray.length >= 3, "libSVG: Array too short");

        uint256 len = pointsArray.length-1;


        string memory results = 'points="';

        for (uint256 i=0; i<len; i++){
            results = string(abi.encodePacked(results, pointsArray[i][0].toString(), ',', pointsArray[i][1].toString(),' '));
        }

        return string(abi.encodePacked(results, pointsArray[len][0].toString(), ',', pointsArray[len][1].toString(),'"'));

    }



}



