::mods_hookExactClass("skills/actives/footwork", function(o)
{
	o.onAfterUpdate = function ( _properties )
	{
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendBackflip))
		{
			this.m.MaxRange = 2;
		}

		this.m.FatigueCostMult = _properties.IsFleetfooted ? 0.5 : 1.0;

		if (this.getContainer().getActor().getSkills().hasEffect(::Legends.Effect.GoblinGruntPotion))
		{
			this.m.ActionPointCost = 2;
		}
	}
});
