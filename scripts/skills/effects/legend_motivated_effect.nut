this.legend_motivated_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendMotivatedEffect);
		this.m.Description = "...and half pay if any of them touch me!";
		this.m.Icon = "skills/coins_square.png";
		this.m.IconMini = "mini_gold56.png"; //new
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDamageMult *= 1.1; //10%
		_properties.MeleeSkillMult *= 1.05; //5%
		_properties.RangedSkillMult *= 1.05; //5%
		_properties.BraveryMult *= 1.15; //15%
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
				icon = "ui/icons/regular_damage.png",
				text = "[color=%positive%]+10%[/color] Melee Damage"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+5%[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+5%[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+15%[/color] Resolve"
			}
		];
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

