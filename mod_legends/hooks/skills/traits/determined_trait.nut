::mods_hookExactClass("skills/traits/determined_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Excluded.extend(
		[
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued)
		]);
	}
});
