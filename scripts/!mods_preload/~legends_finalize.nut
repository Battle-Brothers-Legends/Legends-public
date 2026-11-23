local isNoFU = !("FU" in this.getroottable());
local isNoModernHooks = !("Hooks" in this.getroottable());
if (!isNoFU && !isNoModernHooks) return;

::Legends.Popup <- {
	m = {
		JSHandle = null,
		TextCache = ""
	}

	function showRawText( _text, _quit )
	{
		if (this.m.JSHandle == null)
		{
			if (this.m.TextCache != "") this.m.TextCache += "<br>";
			this.m.TextCache += _text;
		}
		else
		{
			local data = {
				forceQuit = _quit,
				text = _text
			}
			this.m.JSHandle.asyncCall("showRawText", data);
		}
	}

	function connect()
	{
		this.m.JSHandle = ::UI.connect("LegendsDependencyPopup", this);
		if (this.m.TextCache != "")
		{
			this.showRawText(this.m.TextCache, true)
		}
	}

	function quitGame()
	{
		// overwritten by mainMenuScreen hook, closes the game
	}
}; // create popup

::mods_registerJS("legends/popup.js");
::mods_registerCSS("legends/css/popup.css");

::mods_hookExactClass("ui/screens/menu/modules/main_menu_module", function(o)
{
	local create = o.create;
	o.create <- function()
	{
		create();
		::Legends.Popup.quitGame = o.onQuitButtonPressed.bindenv(this);
	}
	o.connectBackend <- function()
	{
		::Legends.Popup.connect();
	}
});

local text = "";

if (isNoFU)
	text += "ERROR: Legends requires Functional Utilities (FU). Reinstall the complete Legends package.<br>";
if (isNoModernHooks)
	text += "ERROR: Legends requires Modern Hooks.<br><a style=\"color: lightblue; text-decoration: underline;\"onclick=\"openURL('https://www.nexusmods.com/battlebrothers/mods/685')\">Get Modern Hooks from Nexusmods</a>";

::Legends.Popup.showRawText(text, true);

::mods_registerJS("legends/connect_popup.js");
