// MSU Debug Logging features
// Documentation available at https://github.com/MSUTeam/MSU/wiki/Debug
// NOTE: This script should be called before ::Const.LegendMod.addSettings() so that the configuration can be read from here
// Be careful not be confused by ::Legends.Mod.Debug (which is the MSU object) and ::Const.LegendMod.Debug (which is our table to store the configurations)

::Legends.Mod.Debug.disable(); // by default, default MSU logging for Legends Mod is disabled

::Const.LegendMod.Debug <- {};

// Define all MSU Debug Flags for Legends here
::Const.LegendMod.Debug.Flags <- {
	Default = "default",
	ContractCategories = "contractCategories",
	ContractCategoriesVerbose = "contractCategoriesVerbose",
	WorldEconomy = "worldEconomy",
}

// An array to centralise the configuration for which debug flag is enabled. MSU Settings will set the default logging value based on this array
::Const.LegendMod.Debug.FlagDefs <- [
	{
		ID = ::Const.LegendMod.Debug.Flags.Default,
		Name = "Default",
		Description = "This is the MSU default for logs which haven\'t been given any specific flag",
		Value = false
	},
	{
		ID = ::Const.LegendMod.Debug.Flags.ContractCategories,
		Name = "Contract Categories",
		Description = "Logs related to Contract Categories",
		Value = false
	},
	{
		ID = ::Const.LegendMod.Debug.Flags.ContractCategoriesVerbose,
		Name = "Contract Categories (Verbose)",
		Description = "Addtional logs related to Contract Categories\n\n[color=%negative%]WARNING: Known to cause crashes due to excessive logging[/color]",
		Value = false
	},
	{
		ID = ::Const.LegendMod.Debug.Flags.WorldEconomy,
		Name = "World Economy",
		Description = "Logs related to World Economy activity",
		Value = true
	}
];

// Apply the configuration defined in ::Const.LegendMod.Debug.FlagDefs
foreach (f in ::Const.LegendMod.Debug.FlagDefs)
{
	::Legends.Mod.Debug.setFlag(f.ID,f.Value);
}

/*
NOTE: Saved MSU Settings appear to deserialize towards the end of the game's deserialization process.
This results in the following quirky behavior:
- Given faction.nut prints logs tagged with "contractCategories" in addContract()
- Given addContract() is called during the game's deserialization process (to load all the contracts)
- Given an in-progress game was saved with MSU Setting the debug flag for "contractCategories" to false
- Given this script sets Value = true for ID = "contractCategories" in ::Const.LegendMod.Debug.FlagDefs
- When we first load Battle Brothers and load the in-progress save:
- Then addContract() will print the logs (meaning the flag "contractCategories"=true at this point) even though the save had the flag set to false
- Then, at a later stage of deserialization, MSU Settings will deserialize
- Then, after MSU Settings have been deserialized, the flag "contractCategories"=false, and no more logging for addContract() will occur
- Then, if we load the same save again, addContract() will not print logs, because now flag "contractCategories"=false
  (because of the MSU Settings deserialization the first time we loaded the save)

This means that no matter what the player has configured for the debug flags in MSU Settings,
whatever setting we configure in ::Const.LegendMod.Debug.FlagDefs will always take precedence when an existing save is loaded with the following circumstances:
- First time the save was loaded and the player has not made any changes in Mod Settings since the Battle Brothers game was first booted up

As soon as the player makes any change in Mod Settings to the Debug flag, this change is actually global (since it directly modifies the flag in Legends.Mod.Debug)
and will take precedence until the player makes another change, or a save is finished loading, at which point the the saved MSU setting will be loaded.

To see how the value configured in this script might be contrasted against the value saved in Settings when loading a save, build and run Legends with the following code un-commented:
// ::mods_hookExactClass("states/world_state", function(o){

// 	local old_onDeserialize = o.onDeserialize;
// 	o.onDeserialize = function( _in )
// 	{
// 		::logInfo("Value of Debug Flag for \"contractCategories\" at the START of deserialization: " + ::Legends.Mod.Debug.isEnabled(::Const.LegendMod.Debug.Flags.ContractCategories));
// 		old_onDeserialize(_in);
// 		::logInfo("Value of Debug Flag for \"contractCategories\" at the END of deserialization: " + ::Legends.Mod.Debug.isEnabled(::Const.LegendMod.Debug.Flags.ContractCategories));
// 	}
// });

*/

::Const.LegendMod.Debug.Utils <- {

	function settlementSummaryStr( _settlement, _showAttached = false, _showHouses = false )
	{
		local fort = _settlement.isMilitary() ? "[Fort] " : "";
		local cityState = ::MSU.isKindOf(_settlement, "city_state") ? "[City State] " : "";
		local attached = "";
		local houses = "";
		local extra = "";
		if (_showAttached)
		{
			attached = "Attached:  " + _settlement.getActiveAttachedLocations().len() + "/" + _settlement.getAttachedLocations().len() + "/" + _settlement.getAttachedLocationsMax() + " ";
		}
		if (_showHouses)
		{
			houses = "Houses: " + _settlement.m.HousesTiles.len() + "/" + _settlement.getHousesMax() + " ";
		}
		if (_showAttached || _showHouses)
		{
			extra = " | " + attached + houses;
		}

		return fort + cityState + "{" + _settlement.getName() + "} (Tier " + _settlement.getSize() + " " + _settlement.ClassName + extra + ")";
	},

}
