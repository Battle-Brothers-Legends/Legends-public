::mods_hookExactClass("skills/traits/fragile_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "With a physique like an eggshell, this character is not the natural born brawler.";
		this.m.Excluded.extend(
		[
			::Legends.Traits.getID(::Legends.Trait.LegendHeavy),
			::Legends.Traits.getID(::Legends.Trait.LegendMartial)
		]);
	}
});
