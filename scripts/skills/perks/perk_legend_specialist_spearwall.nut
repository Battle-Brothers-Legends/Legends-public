this.perk_legend_specialist_spearwall <- this.inherit("scripts/skills/skill", {
	m = {
		SkillsToAdjust = [
			::Legends.Active.LegendStaffwall,
			::Legends.Active.Spearwall
		]
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecSpearWall);
		this.m.Order = this.Const.SkillOrder.Last;
	}

	function onAfterUpdate( _properties ) {
		foreach(skill in this.m.SkillsToAdjust) {
			_properties.SkillCostAdjustments.push({
				ID = ::Legends.Actives.getID(skill),
				APAdjust = -1,
				FatigueMultAdjust = 0.5
			});
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

