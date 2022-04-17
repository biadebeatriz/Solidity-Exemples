
  
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Royalty.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./timelock.sol";

contract Futster is ERC721, ERC721Enumerable,Pausable, ERC721Burnable, ERC721Royalty, TimeLock {
    event BaseURIChanged(string baseURI);
    event Received(address sender, uint value);
    event DnaChanged(uint256 tokenID, uint256 dna);
    event DenominatorChanged(uint96 denominator);
    using Counters for Counters.Counter;


    address public thiscontract;
    string public baseURI;
    uint96 public denominator;
    bool public onlyOwnerApprove;

    mapping (uint256 => uint256) public indexDna;

    Counters.Counter private _tokenIdCounter;

    constructor(string memory _name, string memory _symbol, address signer) ERC721(_name, _symbol) TimeLock(signer) {
        thiscontract = address(this);
        onlyOwnerApprove = true;
    }

    modifier onlyOwnerApproveControl() {
        require(getOnlyOwnerApprove() == false, "Only owner can receive approval");
        _;
    }

    function getOnlyOwnerApprove() public view returns (bool) {
        return onlyOwnerApprove;
    }

    function setOnlyOwnerApprove(bool _approval) public onlyOwner {
        onlyOwnerApprove = _approval;
    }

    function changeDenominator(uint96 _denominator) public onlyOwner returns (uint96) {
        denominator = _denominator;
        emit DenominatorChanged(denominator);
        return denominator;
    }

    function setDefaultRoyalty(address receiver, uint96 feeNumerator) public onlyOwner {
        _setDefaultRoyalty(receiver, feeNumerator);
    }

    function setTokenRoyalty(uint256 tokenId,address receiver,uint96 feeNumerator) public onlyOwner {
        _setTokenRoyalty(tokenId, receiver, feeNumerator);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory _newURI) external onlyOwner returns (string memory) {
        baseURI = _newURI;
        emit BaseURIChanged(baseURI);
        return baseURI;
    }

    function tokenURI(uint256 tokenId) public view override(ERC721) returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, Strings.toString(tokenId))) : "";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function safeMint(address to, uint256 dna) public onlyOwner authorized {
        uint256 tokenId = _tokenIdCounter.current();
        _setDna(tokenId, dna);
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function setDna(uint256 _tokenID, uint256 _dna) public onlyOwner {
        _setDna(_tokenID, _dna);
    }

    function _setDna(uint256 _tokenID, uint256 _dna) internal onlyOwner {
        indexDna[_tokenID] = _dna;
        emit DnaChanged(_tokenID, _dna);
    }

    function setApprovalForAll(address operator, bool approved) public override(ERC721) onlyOwnerApproveControl {
        _setApprovalForAll(_msgSender(), operator, approved);
    }
    
    function approve(address to, uint256 tokenId) public override(ERC721) onlyOwnerApproveControl {
        address owner = ERC721.ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");

        require(
            _msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "ERC721: approve caller is not owner nor approved for all"
        );

        _approve(to, tokenId);
    }

    function setApproveToContractOwner(uint256 _tokenId, bool _status) public {
        require(_exists(_tokenId), "ERC721: approve to contract owner: non-existent token");
        require(ownerOf(_tokenId) == _msgSender(), "ERC721: approveToContractOwner: caller is not owner");
        if (_status) {
            _approve(owner(), _tokenId);
        } else {
            _approve(address(0), _tokenId);
        }
    }

    // Internal functions //

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override (ERC721Royalty, ERC721) {
        super._burn(tokenId);
        _resetTokenRoyalty(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable, ERC721Royalty)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}