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
includeFile("serialization_mod_addon.nut");

::FU.UI.addOnConnectCallback(function()
{
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
