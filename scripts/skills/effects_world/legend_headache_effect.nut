this.legend_headache_effect <- this.inherit("scripts/skills/injury/injury", {
	m = {
		IrritableHealingTime = 0
	},
	function create()
	{
		this.injury.create();
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendHeadache);
		this.m.Description = "Not so loud! This character suffers a serious headache.";
		this.m.Icon = "skills/status_effect_62.png";
		this.m.Type = this.m.Type | this.Const.SkillType.StatusEffect;
		this.m.IsHealingMentioned = false;
		this.m.IsContentWithReserve = true;
		this.m.IsTreatable = false;
		this.m.HealingTimeMin = 1;
		this.m.HealingTimeMax = 2;
	}

	function getTooltip()
	{
		local ret = [
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
				id = 13,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%negative%]-15%[/color] Resolve"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%negative%]-15%[/color] Melee Skill"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-15%[/color] Ranged Skill"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-15%[/color] Melee Defense"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-15%[/color] Ranged Defense"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-15%[/color] Initiative"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);
		_properties.BraveryMult *= 0.85;
		_properties.MeleeSkillMult *= 0.85;
		_properties.RangedSkillMult *= 0.85;
		_properties.MeleeDefenseMult *= 0.85;
		_properties.RangedDefenseMult *= 0.85;
		_properties.InitiativeMult *= 0.85;
	}

	function onRemoved()
	{
		this.injury.onRemoved();
		local days = this.m.IrritableHealingTime;
		if (::Legends.Traits.has(this, ::Legends.Trait.Dumb))
			days *= 2;
		if (this.getContainer().hasSkill("injury.brain_damage"))
			days *= 2;
		if (::Legends.Perks.has(this, ::Legends.Perk.Student))
			this.Math.floor(days /= 1.5);
		if (::Legends.Traits.has(this, ::Legends.Trait.Bright))
			this.Math.floor(days /= 2);
		::Legends.Effects.grant(this, ::Legends.Effect.LegendIrritable, function (_effect) {
			_effect.m.HealingTime = days;
		}.bindenv(this));
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeU32(this.m.IrritableHealingTime);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.IrritableHealingTime = _in.readU32();
	}

});

