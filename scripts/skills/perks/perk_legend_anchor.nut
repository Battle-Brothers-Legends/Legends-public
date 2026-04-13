this.perk_legend_anchor <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 1,
		HasMoved = false
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendAnchor);
		this.m.IconMini = "perk_anchor_mini";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function isHidden()
	{
		return this.m.Stacks == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=%positive%]+" + (this.m.Stacks * 5) + "[/color] Melee Skill, Ranged Skill and Melee Defense"
		});
		tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "If you would get Staggered instead remove a stack of Anchor"
		});

		return tooltip;
	}

	function getBonus()
	{
		return this.m.Stacks == 0 ? 0 : this.m.Bonus;
	}

	function onUpdate ( _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.m.IsMoving)
		{
			this.m.HasMoved = true;
			this.m.Stacks = 0;
			actor.getFlags().set("CanNotBeStaggered", false);
		}

		actor.getFlags().set("CanNotBeStaggered", true);
		_properties.MeleeSkill += this.m.Stacks * 5;
		_properties.RangedSkill += this.m.Stacks * 5;
		_properties.MeleeDefense += this.m.Stacks * 5;
	}

	function onTurnEnd()
	{
		if (this.m.HasMoved)
			this.m.HasMoved = false;
		else
			this.m.Stacks += 1;
	}

	function onCombatStarted()
	{
		this.m.Stacks = 1;
		this.m.HasMoved = false;
	}

	function onCombatFinished()
	{
		this.m.Stacks = 1;
		this.m.HasMoved = false;
	}

});
