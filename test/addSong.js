const TuneToken = artifacts.require("TuneToken");

contract("TuneToken", accounts => {
  const [owner, artist, buyer] = accounts;
  const gasPrice = web3.utils.toWei("27", "gwei"); // specify gas price in gwei

  it("should deploy and measure gas usage for addSong", async () => {
    const instance = await TuneToken.new("TuneToken", "TUNE", { gasPrice });

    // Mint some tokens for the artist to use in addSong
    await instance.mint(artist, 200, { from: owner, gasPrice });

    // Measure gas usage and cost for addSong
    const receipt = await instance.addSong("MySong", "QmIPFSHash", { from: artist, gasPrice });
    const gasUsed = receipt.receipt.gasUsed;
    const transactionCost = gasUsed * gasPrice;

    console.log(`Gas used for addSong: ${gasUsed}`);
    console.log(`Transaction cost for addSong: ${web3.utils.fromWei(transactionCost.toString(), 'ether')} ETH`);
  });

  it("should deploy and measure gas usage for buySong", async () => {
    const instance = await TuneToken.new("TuneToken", "TUNE", { gasPrice });

    // Mint some tokens for both artist and buyer
    await instance.mint(artist, 200, { from: owner, gasPrice });
    await instance.mint(buyer, 100, { from: owner, gasPrice });

    // Add a song by the artist
    await instance.addSong("MySong", "QmIPFSHash", { from: artist, gasPrice });

    // Measure gas usage and cost for buySong
    const receipt = await instance.buySong(artist, "MySong", { from: buyer, gasPrice });
    const gasUsed = receipt.receipt.gasUsed;
    const transactionCost = gasUsed * gasPrice;

    console.log(`Gas used for buySong: ${gasUsed}`);
    console.log(`Transaction cost for buySong: ${web3.utils.fromWei(transactionCost.toString(), 'ether')} ETH`);
  });
});
