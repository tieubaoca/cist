module cist

go 1.16

require (
	github.com/btcsuite/btcd v0.22.1 // indirect
	github.com/cosmos/cosmos-sdk v0.45.4
	github.com/cosmos/ibc-go/v3 v3.0.0
	github.com/ethereum/go-ethereum v1.10.16
	github.com/gogo/protobuf v1.3.3
	github.com/golang/protobuf v1.5.2
	github.com/gorilla/mux v1.8.0
	github.com/grpc-ecosystem/grpc-gateway v1.16.0
	github.com/grpc-ecosystem/grpc-gateway/v2 v2.14.0 // indirect
	github.com/hashicorp/golang-lru v0.5.5-0.20210104140557-80c98217689d // indirect
	github.com/ignite-hq/cli v0.22.0
	github.com/improbable-eng/grpc-web v0.15.0 // indirect
	github.com/onsi/ginkgo v1.16.5 // indirect
	github.com/regen-network/cosmos-proto v0.3.1 // indirect
	github.com/spf13/cast v1.4.1
	github.com/spf13/cobra v1.4.0
	github.com/spf13/viper v1.11.0 // indirect
	github.com/stretchr/testify v1.7.1
	github.com/syndtr/goleveldb v1.0.1-0.20210819022825-2ae1ddf74ef7 // indirect
	github.com/tendermint/spn v0.2.1-0.20220609194312-7833ecf4454a
	github.com/tendermint/tendermint v0.34.19
	github.com/tendermint/tm-db v0.6.7
	github.com/tharsis/ethermint v0.15.1
	golang.org/x/net v0.2.0 // indirect
	google.golang.org/genproto v0.0.0-20221114212237-e4508ebdbee1
	google.golang.org/grpc v1.50.1
	gopkg.in/yaml.v2 v2.4.0
)

replace (
	github.com/gogo/protobuf => github.com/regen-network/protobuf v1.3.3-alpha.regen.1
	github.com/keybase/go-keychain => github.com/99designs/go-keychain v0.0.0-20191008050251-8e49817e8af4
	github.com/tharsis/ethermint => github.com/evmos/ethermint v0.15.1
	google.golang.org/grpc => google.golang.org/grpc v1.33.2
)
