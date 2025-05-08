if (!("LegendMod" in ::Const)) {
	::Const.LegendMod <- {}
}

// load order
foreach (dir in [
	"mod_legends/!!config",
	"mod_legends/!config/outfit",
	"mod_legends/!config",
	"mod_legends/config",
	"mod_legends/helper",
	"mod_legends/system",
	"mod_legends/register",
	"mod_legends/hooks"
]) {
	foreach (file in ::IO.enumerateFiles(dir))
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
