if (!("LegendMod" in ::Const)) {
	::Const.LegendMod <- {}
}

// load config folder
foreach (file in ::IO.enumerateFiles("mod_legends/!!!config")) {
	::include(file);
}
foreach (file in ::IO.enumerateFiles("mod_legends/!!config")) {
	::include(file);
}
foreach (file in ::IO.enumerateFiles("mod_legends/!config")) {
	::include(file);
}
foreach (file in ::IO.enumerateFiles("mod_legends/config")) {
	::include(file);
}

// load helpers
foreach (file in ::IO.enumerateFiles("mod_legends/helper")) {
	::include(file);
}

// load query folder
foreach (file in ::IO.enumerateFiles("mod_legends/system"))
{
	::include(file);
}

// load register folder
foreach (file in ::IO.enumerateFiles("mod_legends/register"))
{
	::include(file);
}

// load hooks folder
foreach (file in ::IO.enumerateFiles("mod_legends/hooks"))
{
	::include(file);
}

// load afterHooks folder
::mods_hookNewObjectOnce("ui/screens/menu/main_menu_screen", function(o) {
	local connect = o.connect;
	o.connect = function()
	{
		foreach (file in ::IO.enumerateFiles("mod_legends/afterHooks"))
			::include(file);
		connect();
	}
});
