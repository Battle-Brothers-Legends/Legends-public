::mods_hookExactClass("skills/traits/fear_beasts_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Some past event or particularly convincing story in this character\'s life has left them scared of what the monstrous beasts of the wild are capable of, making this character less reliable when facing beasts on the battlefield.";
		this.m.Excluded.extend([
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendPragmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendTalented)
		]);
	}
});
