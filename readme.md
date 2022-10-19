# cist
**cist** is a blockchain built using Cosmos SDK and Tendermint and created with [Ignite CLI](https://ignite.com/cli).

### Install
To install the latest version of your blockchain node's binary, execute the following command on your machine:

```
curl https://get.ignite.com/username/cist@latest! | sudo bash
```
`username/cist` should match the `username` and `repo_name` of the Github repository to which the source code was pushed. Learn more about [the install process](https://github.com/allinbits/starport-installer).

## Get Started

### Local 1 node 
#### Start chain
```
ignite chain serve
```
#### Test account, transaction on browser
```
cd vue
```
```
npm install
```
```
npm run dev
```
### Local 3 node (testnet)```
```
cd scripts
```
```
chmod +x multinode-testnet.sh
```
#### Test transaction on local
```
cistd keys add account_test --node "tcp://localhost:50000" (port 1 node)  // Create 1 account
```
```
cistd tx bank send node0 address_account_test 100ucist --home path-node0 --keyring-backend test --node "tcp://localhost:50000" //send token from address 
node to address user
```
```
cistd query bank balances address_account_test --node "tcp://localhost:50000" // Query account test
```
#### Test with API: Link git: 


## Learn more

- [Ignite CLI](https://ignite.com/cli)
- [Tutorials](https://docs.ignite.com/guide)
- [Ignite CLI docs](https://docs.ignite.com)
- [Cosmos SDK docs](https://docs.cosmos.network)
- [Developer Chat](https://discord.gg/ignite)
