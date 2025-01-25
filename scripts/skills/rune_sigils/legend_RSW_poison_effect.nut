this.legend_RSW_poison_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3,
		TurnsLeftMax = 3,
		Strength = 10
	},
	function setStats(_s1, _s2)
	{
		this.m.TurnsLeft = _s1;
		this.m.TurnsLeftMax = _s1;
		this.m.Strength = _s2;
	}
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRswPoisonEffect);
		this.m.Icon = "skills/status_effect_54.png";
		this.m.IconMini = "status_effect_54_mini";
		this.m.Overlay = "status_effect_54";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "This character has poison running through his veins. His vision is blurred, his speech slurred and it takes a great deal of effort for him to move in a coordinated fashion. The effect will slowly wear off over [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
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
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + 1 * this.m.TurnsLeft + "[/color] Action Points"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + 1 * this.m.TurnsLeft + "[/color] Vision"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + 10 * this.m.TurnsLeft + "[/color] Initiative"
			}
		];
	}

	function resetTime()
	{
		this.m.TurnsLeft = this.Math.max(1, this.m.TurnsLeftMax + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasTrait(::Legends.Trait.Ailing))
		{
			++this.m.TurnsLeft;
		}

		this.spawnIcon("status_effect_54", this.getContainer().getActor().getTile());
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.max(1, this.m.TurnsLeftMax + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasTrait(::Legends.Trait.Ailing))
		{
			++this.m.TurnsLeft;
		}
	}

	function onUpdate( _properties )
	{
		_properties.ActionPoints -= this.Math.round(1.0 * this.m.TurnsLeft);
		_properties.Initiative -= this.Math.round(10.0 * (this.m.Strength / 8.0) * this.m.TurnsLeft);
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onCombatFinished()
	{
		this.removeSelf();
	}
});
