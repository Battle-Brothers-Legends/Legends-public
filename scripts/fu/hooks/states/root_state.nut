::mods_addHook("root_state.onInit", function(r) // executed once per game session
{
	::FU.System.Keybinds.importPersistentSettings();
	::FU.System.ModSettings.importPersistentSettings();
});
