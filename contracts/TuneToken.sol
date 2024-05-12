// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TuneToken {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner, address indexed spender, uint256 value
    );
    event SongAdded(address indexed artist, string songName);

    uint256 public totalSupply;
    address[] private artistAddresses;
    mapping(address => uint256) public balanceOf;
    mapping(address => string[]) private artistSongs;
    mapping(address => mapping(string => string)) private songIPFS;
    mapping(address => mapping(address => string[])) private boughtSongs;
    string public name;
    string public symbol;

    uint256 public songAdditionCost = 100;
    uint256 public songListenCost = 1;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function transfer(address recipient, uint256 amount)
        external
        returns (bool)
    {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function compareStrings(string memory a, string memory b) internal pure returns (bool) {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }

    function getIPFSValue(address artist, string memory songName) external view returns (string memory) {
        string[] memory songs = boughtSongs[msg.sender][artist];

        for (uint i = 0; i < songs.length; i++) {
            if (compareStrings(songs[i], songName)) {
                return songIPFS[artist][songName];
            }
        }

        return "";
    }

    function getAllArtistAddresses() public view returns (address[] memory) {
        return artistAddresses;
    }

    function getBalanceOf(address user) public view returns (uint256) {
        return balanceOf[user];
    }

    function addSong(string memory songName, string memory ipfs) external {
        require(balanceOf[msg.sender] >= songListenCost, "Not enough tokens for the security deposit");

        balanceOf[msg.sender] -= songAdditionCost;

        if (artistSongs[msg.sender].length == 0) {
            artistAddresses.push(msg.sender);
        }

        artistSongs[msg.sender].push(songName);
        songIPFS[msg.sender][songName] = ipfs;
        emit SongAdded(msg.sender, songName);
    }

    function buySong(address artist, string memory songName) external {
        require(balanceOf[msg.sender] >= songListenCost, "Not enough tokens to listen");

        balanceOf[msg.sender] -= songListenCost;
        balanceOf[artist] += songListenCost;
        
        boughtSongs[msg.sender][artist].push(songName);
    }

    function getSongsByArtist(address artist) external view returns (string[] memory) {
        return artistSongs[artist];
    }

    function getMySongs() external view returns (string[] memory) {
        return artistSongs[msg.sender];
    }

    function _mint(address to, uint256 amount) internal {
        balanceOf[to] += amount;
        totalSupply += amount;
        emit Transfer(address(0), to, amount);
    }

    function _burn(address from, uint256 amount) internal {
        balanceOf[from] -= amount;
        totalSupply -= amount;
        emit Transfer(from, address(0), amount);
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external {
        _burn(from, amount);
    }
}
