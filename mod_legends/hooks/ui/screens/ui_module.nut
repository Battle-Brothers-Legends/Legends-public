::mods_hookBaseClass("ui/screens/ui_module", function ( o )
{
	while(!("queryLoad" in o)) o = o[o.SuperName];
	
	o.queryLoad <- function ()
	{
		return null;
	}

});
