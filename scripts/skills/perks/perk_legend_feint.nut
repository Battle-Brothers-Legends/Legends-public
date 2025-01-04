this.perk_legend_feint <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendFeint);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		local actor = this.getContainer().getActor();
		actor.setFatigue(this.Math.max(0, actor.getFatigue() - this.Math.floor(_skill.getFatigueCost() * 0.2)));
		if (!_targetEntity.getSkills().hasSkill("effects.legend_parried"))
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/legend_parried_effect"));

			if (!actor.isHiddenToPlayer() && !_targetEntity.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " feinted " + this.Const.UI.getColorizedEntityName(_targetEntity) + " leaving them exposed!");
			}
		}
	}


});

