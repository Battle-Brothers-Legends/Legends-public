this.perk_legend_specialist_spearwall <- this.inherit("scripts/skills/skill", {
	m = {
		Skills = [
			::Legends.Actives.getID(::Legends.Active.LegendStaffwall),
			::Legends.Actives.getID(::Legends.Active.Spearwall)
		]
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecSpearWall);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function onAfterUpdate( _properties )
	{
		foreach (skill in this.getContainer().getSkillsByFunction((@(_skill) this.m.Skills.find(_skill.getID()) != null).bindenv(this)))
		{
			skill.m.FatigueCostMult *= 0.5;
			skill.m.ActionPointCost = 3;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.getContainer().hasEffect(::Legends.Effect.Spearwall) && (this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != this.getContainer().getActor().getID()))
		{
			_properties.DamageTotalMult *= 1.25;
		}
	}

});

