local function includeFile( _file )
{
	::FU.includeFile("scripts/fu/systems/mod_settings/", _file);
}

includeFile("settings_element.nut");
includeFile("abstract_setting.nut");
includeFile("elements/string_setting.nut");

foreach (file in ::IO.enumerateFiles("scripts/fu/systems/mod_settings/elements/"))
{
	::include(file);
}

includeFile("settings_page.nut");
includeFile("settings_panel.nut");

includeFile("mod_settings_system.nut");
::FU.System.ModSettings <- ::FU.Class.ModSettingsSystem();
::getModSetting <- function( _modID, _settingID )
{
	local panel = ::FU.System.ModSettings.getPanel(_modID);
	if (panel == null && typeof _modID == "string") panel = ::FU.System.ModSettings.getPanel(_modID.tolower());
	if (panel == null) throw ::FU.Exception.KeyNotFound(_modID);
	return panel.getSetting(_settingID);
}
includeFile("mod_settings_mod_addon.nut");

::FU.SettingsScreen <- ::new("scripts/mods/FU/settings_screen");
::FU.UI.registerConnection(::FU.SettingsScreen);
::FU.UI.addOnConnectCallback(::FU.System.ModSettings.finalize.bindenv(::FU.System.ModSettings));
::FU.System.ModSettings.Screen = ::FU.SettingsScreen;


::FU.SettingsFlags <- {
	NewCampaign = {
		required = [
			"NewCampaign"
		]
	},
	World = {
		excluded = [
			"NewCampaignOnly"
		]
	},
	Tactical = {
		excluded = [
			"NewCampaignOnly"
		]
	},
	Main = {
		excluded = [
			"NewCampaignOnly"
		]
	}
};
