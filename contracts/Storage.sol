// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Storage {
    string ipfsHash;

    function setIPFSHash(string memory _ipfsHash) public {
        ipfsHash = _ipfsHash;
    }

    function getIPFSHash() public view returns (string memory) {
        return ipfsHash;
    }
}
