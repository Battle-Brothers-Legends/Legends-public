this.perk_legend_rebound <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendRebound);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local maxFat = actor.getFatigueMax();
		local currentFat = actor.getFatigue();
		local ratio = currentFat / maxFat;

		if (ratio > 0.9)
		{
			_properties.FatigueRecoveryRate += 5;
		}
		else if (ratio > 0.75 && actor.getSkills().hasPerk(::Legends.Perk.LegendRecuperation))
		{
			_properties.FatigueRecoveryRate += 5;
		}
	}

});

