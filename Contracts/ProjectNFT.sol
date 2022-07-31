// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyProjectNFT is ERC721Enumerable, Ownable {
  using Strings for uint256;
  uint256 public maxNFT = 100;
  uint256 public maxMintAmount = 10;
  uint256[] private _tokenIDs;
  constructor(string memory _name,string memory _symbol) ERC721(_name, _symbol) {}

  // Mint function public.
  ///@dev instead of _tokenIDs[].length method, inbuilt totalSupply() function can be used to increment tokenIDs.
  function mint(uint256 _mintAmt) public {
    require(_mintAmt <= maxMintAmount,"cannot exceed maxMintAmount");
    require(msg.sender != address(0));
    require(_mintAmt > 0);
	
    for(uint256 i=1; i <= _mintAmt; i++){
      _tokenIDs.push(i);
      _safeMint(msg.sender, _tokenIDs.length);
    }      
  }

  function tokenURI(uint256 tokenId) public view virtual override returns (string memory){
    require(_exists(tokenId),"Token Id does not exist");
    return string(abi.encodePacked("ipfs://bafybeihzg2m7jtvtdvcpupz3ciwwhozs7x4msxauvwqy2hrlazxjbgs7ve/",tokenId.toString(),".json"));
    
  }

//only owner functions.

  function AmountOfNFTminted() public view onlyOwner returns(uint256){
    return _tokenIDs.length;
  }

}
//contract deployed address:  0xd9611af6D366c466b7CB9A95683B49AB3868677B
