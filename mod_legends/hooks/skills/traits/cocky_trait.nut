::mods_hookExactClass("skills/traits/cocky_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This character can be as dangerous to themself as to his opponent.";
		this.m.Excluded.extend([
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.LegendPragmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive)
		]);
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties )
	{
		onUpdate( _properties );
		// removes the negative effect
		if (this.getContainer().hasPerk(::Legends.Perk.LegendAssuredConquest))
		{
			_properties.MeleeDefense += 5;
			_properties.RangedDefense += 5;
		}
	}
});
