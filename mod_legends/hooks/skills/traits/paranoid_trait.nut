::mods_hookExactClass("skills/traits/paranoid_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Excluded.extend(
		[
			::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive),
			::Legends.Traits.getID(::Legends.Trait.LegendTalented)
		]);
	}
});
