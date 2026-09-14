::mods_hookExactClass("skills/traits/weasel_trait", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This character is swift as a weasel. Unfortunately, they seem to only be able to call on this ability when running to save their own hide.";
		this.m.Excluded.extend([
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendTalented)
		]);
	}
});
