::mods_hookExactClass("skills/traits/bright_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Excluded.extend([
			::Legends.Traits.getID(::Legends.Trait.LegendPredictable)
		]);
	}
});
