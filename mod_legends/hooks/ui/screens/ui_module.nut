::mods_hookBaseClass("ui/screens/ui_module", function ( o )
{
	while(!("ID" in o.m)) o=o[o.SuperName];

	o.queryLoad <- function ()
	{
		return null;
	}

});
