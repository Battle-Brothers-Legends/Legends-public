::mods_hookExactClass("skills/traits/strong_trait", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This character is exceptionally muscled and capable of impressive feats of strength";
		this.m.Excluded.extend([
			::Legends.Traits.getID(::Legends.Trait.LegendLight),
			::Legends.Traits.getID(::Legends.Trait.LegendFrail)
		]);
	}
});
