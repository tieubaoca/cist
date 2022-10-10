package cist_test

import (
	"testing"

	keepertest "cist/testutil/keeper"
	"cist/testutil/nullify"
	"cist/x/cist"
	"cist/x/cist/types"
	"github.com/stretchr/testify/require"
)

func TestGenesis(t *testing.T) {
	genesisState := types.GenesisState{
		Params: types.DefaultParams(),

		// this line is used by starport scaffolding # genesis/test/state
	}

	k, ctx := keepertest.CistKeeper(t)
	cist.InitGenesis(ctx, *k, genesisState)
	got := cist.ExportGenesis(ctx, *k)
	require.NotNil(t, got)

	nullify.Fill(&genesisState)
	nullify.Fill(got)

	// this line is used by starport scaffolding # genesis/test/assert
}
