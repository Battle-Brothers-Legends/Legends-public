::mods_hookExactClass("skills/traits/quick_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Already there! This character is quick to act, often before opponents do.";
		this.m.Excluded.push(::Legends.Traits.getID(::Legends.Trait.LegendPragmatic));
	}
});
