this.legend_mead_warmth_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendMeadWarmthEffect);
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
		return "Having just consumed mead, this character has [color=%positive%]+9[/color] Resolve, Melee and Ranged Skill, [color=%negative%]-9[/color] Defenses and [color=%negative%]-18[/color] Initiative for [color=%negative%]" + this.m.TurnsLeft + "[/color] turn(s).";
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
				text = "[color=%positive%]+9[/color] Resolve"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+9[/color] Melee Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+9[/color] Ranged Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-9[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-9[/color] Ranged Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-18[/color] Initiative"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{

		_properties.Bravery += 9;
		_properties.MeleeSkill += 9;
		_properties.RangedSkill += 9;
		_properties.MeleeDefense -= 9;
		_properties.RangedDefense -= 9;
		_properties.Initiative -= 18;

	}

	function onAdded()
	{
		this.m.TurnsLeft = 3;
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
		local actor = this.getContainer().getActor();
		if (this.Math.rand(1, 100) <= 30 && !actor.getSkills().hasTrait(::Legends.Trait.Drunkard))
		{
			::Legends.Effects.grant(this, ::Legends.Effect.Hangover);
		}
		else if (this.Math.rand(1, 100) <= 15 && actor.getSkills().hasTrait(::Legends.Trait.Drunkard))
		{
			::Legends.Effects.grant(this, ::Legends.Effect.Hangover);
		}
	}

});

