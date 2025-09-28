function includeFile( _file )
{
	::FU.includeFile("scripts/fu/systems/serialization/", _file);
}
includeFile("metadata_emulator");
includeFile("serde_emulator");
includeFile("serialization_emulator");
includeFile("deserialization_emulator");

includeFile("serialization_system.nut");
::FU.System.Serialization <- ::FU.Class.SerializationSystem();
// Ensure MetaData exists early to avoid null cloning when mods serialize flags
if (!("MetaData" in ::FU.System.Serialization) || ::FU.System.Serialization.MetaData == null)
{
	::FU.System.Serialization.MetaData = ::FU.Class.MetaDataEmulator();
}
includeFile("serialization_mod_addon.nut");

::FU.UI.addOnConnectCallback(function()
{
	// If a real MSU Serialization system is present, don't run FU's bootstrap to avoid conflicts
	if ("MSU" in getroottable() && "System" in ::MSU && "Serialization" in ::MSU.System)
	{
		return;
	}
	local worldState = ::new("scripts/states/world_state");
	local serEm = ::FU.Class.SerializationEmulator(::FU.ID, "WorldStateOnBeforeSerialize", ::new("scripts/tools/tag_collection"), ::FU.Class.MetaDataEmulator());
	::FU.System.Serialization.MetaData = serEm.getMetaData();
	::World.Assets <- {
		getName = @() "FUDummy",
		getBanner = @() "FUDummy",
		getCombatDifficulty = @() 1,
		getEconomicDifficulty = @() 1,
		isIronman = @() false,
	}
	::World.Assets.setdelegate({ // attempted patch for any other function calls
		_get = @(_k)@(...)""
	});
	worldState.onBeforeSerialize(serEm);
	delete ::World.Assets;
});
