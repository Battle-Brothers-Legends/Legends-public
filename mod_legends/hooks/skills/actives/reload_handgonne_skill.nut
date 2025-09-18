::mods_hookExactClass("skills/actives/reload_handgonne_skill", function(o)
{
	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		onAfterUpdate(_properties);
		this.m.ActionPointCost = 9;
		if (_properties.IsSpecializedInCrossbows)
			this.m.ActionPointCost -= 3; 
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendSpecialistInventor))
			this.m.ActionPointCost -= 1;
	}
});
