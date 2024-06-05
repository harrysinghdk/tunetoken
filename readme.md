
# TuneToken Smart Contract

## Getting Started

### Clone the repo

```bash
git clone https://github.com/harrysinghdk/tunetoken
cd TuneToken
```

### Configure Truffle
Edit truffle-config.js to include your network configurations. Below is an example

```javascript

module.exports = {
    networks: {
        ganache: {
            host: "127.0.0.1",
            port: 7545,
            network_id: "5777",
        },
    }
}
```

### Run Ganache

Start the Ganache CLI with the following settings

```bash
ganache-cli --port 7545 --networkId 5777
```

Or use the [Ganache UI](https://archive.trufflesuite.com/ganache/) tool.


### Compile the smart contract
```bash
truffle compile
```

### Migrate (Deploy) the smart contract
```bash
truffle migrate --network ganache
```


### Interact with the smart contract
You can interact with the deployed smart contract using truffle console
```bash
truffle console --network development
```