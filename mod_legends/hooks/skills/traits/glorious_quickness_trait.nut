::mods_hookExactClass("skills/traits/glorious_quickness_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Forged in the arenas of the south, this character has fought many a battle, and is an expert in dispatching multiple opponents in a row. This fabulous lifestyle demands high pay, but they\'ll never desert you  and can\'t be dismissed. If all three original members should die, your campaign ends.";
	}
});
