::mods_hookExactClass("skills/actives/footwork", function(o)
{
	o.onAfterUpdate = function ( _properties )
	{
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendBackflip))
		{
			this.m.MaxRange = 2;
		}

		this.m.FatigueCostMult = _properties.IsFleetfooted ? 0.5 : 1.0;

		if (this.getContainer().getActor().getSkills().hasSkill("effects.goblin_grunt_potion"))
		{
			this.m.ActionPointCost = 2;
		}
	}
});
