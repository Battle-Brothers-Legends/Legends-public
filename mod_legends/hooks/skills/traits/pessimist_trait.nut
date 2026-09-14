::mods_hookExactClass("skills/traits/pessimist_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Excluded.extend(
		[
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendPragmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendUnpredictable),
			::Legends.Traits.getID(::Legends.Trait.LegendTalented),
			::Legends.Traits.getID(::Legends.Trait.LegendGiftOfPeople)
		]);
	}
});
