this.legend_martial_march_effect <- this.inherit("scripts/skills/skill", {
	m = {
		songStacks = 0,
		turnsWithoutSong = 0,
		IsSpent = false
	},
	function create()
	{
		this.m.ID = "effects.legend_martial_march";
		this.m.Name = "Martial March";
		this.m.Description = "This character is being influenced by a martial march and has a chance to recover Action Points with every skill used.";
		this.m.Icon = "ui/effects/drums_of_war.png";
		// this.m.IconMini = "drums_of_war_mini.png";
		// this.m.Overlay = "drums_of_war";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return "This character is being influenced by a martial march and has a chance to recover Action Points with every skill used.";
	}

	function incrementStacks()
	{
		this.m.songStacks += 1;
	}

	function resetTurnsWithoutSong()
	{
		this.m.turnsWithoutSong = 0;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Chance to recover [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.songStacks + "[/color] Action Points"
			}
		];
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == null || _skill.isGarbage())
			return;
		local actor = this.getContainer().getActor();
		if (actor.isAlliedWith(_targetEntity) || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != actor.getID())
			return;
		if (this.m.IsSpent || this.Tactical.TurnSequenceBar.getActiveEntity() == null)
			return;
		local rand = this.Math.rand(1, 100);
		local isHit = rand <= _skill.ActionPointCost ? true : false;
		if (!_user.isHiddenToPlayer() && !_targetEntity.isHiddenToPlayer())
		{
			if (isHit)
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(actor) + " uses " + _skill.getName() + " while affected by Martial March and feels the battle frenzy, recovering " + this.m.songStacks + "Action Points (Chance: 100" + _skill.ActionPointCost + ", Rolled: " + rand + ")");
		}
		if (isHit)
		{
			this.m.IsSpent = true;
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + this.m.songStacks));
			actor.setDirty(true);
			this.spawnIcon("perk_35", this.m.Container.getActor().getTile());
		}
	}

	function onAdded()
	{
		this.m.songStacks = 1;
		this.m.turnsWithoutSong = 0;
		this.m.IsSpent = false;
	}

	function onTurnEnd()
	{		
		if (this.m.turnsWithoutSong == 2)
		{
			this.m.songStacks = 0;
			this.m.turnsWithoutSong = 0;
			this.removeSelf();
			return;
		}
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
		this.m.turnsWithoutSong += 1;
	}

	function onCombatFinished()
	{
		this.m.songStacks = 0;
		this.m.turnsWithoutSong = 0;
		this.m.IsSpent = false;
		this.removeSelf();
	}
});
