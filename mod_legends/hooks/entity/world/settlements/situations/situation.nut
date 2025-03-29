::mods_hookBaseClass("entity/world/settlements/situations/situation", function(o)
{
	while(!("IsStacking" in o.m)) o=o[o.SuperName];

	o.m.IsSouthern <- false;

	o.onResolved <- function ( _settlement )
	{
		return this.onRemoved(_settlement);
	}

	o.onUpdateStablesList <- function ( _list )
	{
	}
});
