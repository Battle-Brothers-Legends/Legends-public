// The Oathtakers of OFF+ replace the vanilla origin and take its place in the list
// Its other origins get a header of their own using the new submod category
// Basically just a way for submods to have anything they add be clearly listed as a separate grouping (but only if they want to)
::Legends.Scenarios.Order["scenario.oathtakers"] <- ::Legends.Scenarios.Order["scenario.paladins"];
::Legends.Scenarios.addGroup("Of Flesh and Faith+", [
	"scenario.southern_assassins",
	"scenario.runeknights",
	"scenario.explorers"
]);
