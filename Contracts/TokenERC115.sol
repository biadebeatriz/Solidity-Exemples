/*
SPDX-License-Identifier: no-license
(c) Developed by Beatriz Siqueira
*/
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

abstract contract ERC721URIStorage is ERC721 {
    using Strings for uint256;

    // Optional mapping for token URIs
    mapping (uint256 => string) private _tokenURIs;

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721URIStorage: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();

        // If there is no base URI, return the token URI.
        if (bytes(base).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }

        return super.tokenURI(tokenId);
    }

    /**
     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    /**
     * @dev Destroys `tokenId`.
     * The approval is cleared when the token is burned.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     *
     * Emits a {Transfer} event.
     */
    function _burn(uint256 tokenId) internal virtual override {
        super._burn(tokenId);

        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
}

contract Token721 is ERC721URIStorage{
    address payable owner;
    address public thiscontract;


    modifier onlyOwner {
        require(msg.sender == owner,"Only owner can call this function.");
    _;
  }
  
    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol){
      owner = payable(msg.sender);
      thiscontract = address(this);
    }

    function changeOwner(address _newOwner) public onlyOwner returns (bool){
        require(_newOwner != address(0), "You must inform a valid address");
        owner = payable(_newOwner);
        return true;
    }

    function setmintURI(address _itemOwner, uint256 _id, string memory _tokenURI) public onlyOwner returns (bool){
        _mint(_itemOwner, _id);
        _setTokenURI(_id, _tokenURI);

        return true;
  }

    function setURI(string memory _tokenURI, uint256 _id) public onlyOwner returns(bool){
    _setTokenURI(_id, _tokenURI);
    return true;
    }


}