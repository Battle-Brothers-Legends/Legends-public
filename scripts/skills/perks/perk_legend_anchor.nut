this.perk_legend_anchor <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 1,
		HasMoved = false,
		Bonuses = [0, 5, 9, 12, 14, 15, 15] // 6 is a failsafe ig
	},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendAnchor);
		this.m.IconMini = "perk_anchor_mini";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function getDescription() {
		return "Hold your ground!";
	}

	function isHidden() {
		return this.m.Stacks == 0;
	}

	function getTooltip() {
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
				text = "[color=%positive%]+" + (this.m.Bonuses[this.m.Stacks]) + "[/color] Melee Skill, Ranged Skill and Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "If you would get Staggered instead remove a stack of Anchor"
			}
		];
	}

	function onUpdate ( _properties ) {
		local actor = this.getContainer().getActor();
		if (actor.m.IsMoving) {
			this.m.HasMoved = true;
			this.m.Stacks = 0;
			actor.getFlags().set("CanNotBeStaggered", false);
		}

		this.m.Stacks = this.Math.min(this.m.Stacks, 5);

		actor.getFlags().set("CanNotBeStaggered", true);
		_properties.MeleeSkill += this.m.Bonuses[this.m.Stacks];
		_properties.RangedSkill += this.m.Bonuses[this.m.Stacks];
		_properties.MeleeDefense += this.m.Bonuses[this.m.Stacks];
	}

	function onTurnEnd() {
		if (this.m.HasMoved)
			this.m.HasMoved = false;
		else
			this.m.Stacks += 1;
	}

	function onCombatStarted() {
		this.m.Stacks = 1;
		this.m.HasMoved = false;
	}

	function onCombatFinished() {
		this.m.Stacks = 1;
		this.m.HasMoved = false;
	}

});
