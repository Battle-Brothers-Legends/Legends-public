::mods_hookExactClass("skills/traits/tiny_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Excluded.push(::Legends.Traits.getID(::Legends.Trait.LegendHeavy));
	}
});
