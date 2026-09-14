this.legend_wine_tipsy_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 6
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendWineTipsyEffect);
		this.m.Icon = "skills/status_effect_92.png";
		this.m.IconMini = "status_effect_92_mini";
		this.m.Overlay = "status_effect_92";
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.DrugEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "Having recently imbibed wine, this character has [color=%positive%]6[/color] Resolve, Melee and Ranged Skill, [color=%negative%]-6[/color] Defenses and [color=%negative%]-12[/color] Initiative for [color=%negative%]" + this.m.TurnsLeft + "[/color] turn(s).";
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
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+6[/color] Resolve"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+6[/color] Melee Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+6[/color] Ranged Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-6[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-6[/color] Ranged Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-12[/color] Initiative"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += 6;
		_properties.MeleeSkill += 6;
		_properties.RangedSkill += 6;
		_properties.MeleeDefense -= 6;
		_properties.RangedDefense -= 6;
		_properties.InitiativeMult -= 12;

	}

	function onAdded()
	{
		this.m.TurnsLeft = 6;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onRemoved()
	{
		if (this.Math.rand(1, 100) <= 20)
		{
			::Legends.Effects.grant(this, ::Legends.Effect.Hangover);
		}
	}

});

