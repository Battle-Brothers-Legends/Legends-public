this.perk_legend_blend_in <- this.inherit("scripts/skills/skill", {
	m = {
		MeekStacks = 1,
		MeekCounter = 0,
		AffectedSkills = [ // put these in this array so submodder has an easier time to mod affected skills by this perk
			"actives.legend_evasion",
			"actives.legend_leap",
			"actives.footwork",
		]
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendBlendIn);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return "Hold yourself in a way that makes you seem more trouble than its worth, lean into trees, place objects between you and an enemy, and hide behind allies.";
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 0.50;
		_properties.MeleeDefense += 3;
		_properties.RangedDefense += 5;
		// this.m.IsHidden = this.m.Stacks == 0;
	}

	function getTooltip()
	{
		local tooltip = [
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
				id = 6,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+3[/color] Melee Defense."
			},
			{
				id = 7,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Ranged Defense."
			},
			{
				id = 8,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Makes enemies less likely to attack you instead of an ally."
			}
		];
		if (!this.getContainer().getActor().isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
		{
			tooltip.push(
			{
				id = 6,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Always evade the next attack made against this character in combat."
			});
		}
		else
		{
			
			if (this.m.MeekStacks > 0)
			{
				tooltip.push(
				{
					id = 6,
					type = "hint",
					icon = "ui/icons/special.png",
					text = "Always evade the next attack made against this character in combat."
				});
			}
			else if (this.getContainer().hasSkill("perk.legend_unburdened"))
			{
				tooltip.push(
				{
					id = 6,
					type = "hint",
					icon = "ui/icons/warning.png",
					text = "The evasion stack will recover in: [color=" + this.Const.UI.Color.NegativeValue + "]" + (2 - this.m.MeekCounter) + "[/color] turns."
				});
			}
		}

		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 0.50;
		_properties.MeleeDefense += 3;
		_properties.RangedDefense += 5;
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (this.m.MeekStacks > 0)
			_properties.IsEvadingAllAttacks = true;
	}

	function onMissed( _attacker, _skill )
	{
		if (this.m.MeekStacks > 0)
		{
			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_attacker) + " underestimated " + this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " due to " + ["their","his","her"][this.getContainer().getActor().getGender() + 1] + " meekness!");
			this.m.MeekStacks -= 1;
		}
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.MeekStacks <= 0)
			return;

		if (this.m.AffectedSkills.find(_skill.getID()) != null)
			this.m.MeekStacks -= 1;
	}

	function onAfterUpdate( _properties )
	{
		if (this.m.MeekStacks <= 0)
			return;

		foreach (id in this.m.AffectedSkills)
		{
			local skill = this.getContainer().getSkillByID(id);

			if (skill == null)
				continue;

			skill.m.ActionPointCost = 0;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.MeekStacks == 0)
			return;
		if (_skill.getID() == "actives.legend_leap" || _skill.getID() == "actives.footwork" || _skill.getID() == "actives.legend_evasion" )
			_skill.m.ActionPointCost = 0;
			this.m.MeekStacks -= 1;
	}

	function onTurnEnd()
	{
		if (this.getContainer().hasSkill("perk.legend_unburdened"))
			this.m.MeekCounter += 1;

		if (this.m.MeekCounter == 2)
		{
			this.m.MeekStacks = this.Math.min(2, this.m.MeekStacks + 1);
			this.m.MeekCounter = 0;
		}
	}

	function onCombatStarted()
	{
		this.skill.onCombatStarted();
		this.m.MeekStacks = 1;
		this.m.MeekCounter = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.MeekStacks = 1;
		this.m.MeekCounter = 0;
	}

});
