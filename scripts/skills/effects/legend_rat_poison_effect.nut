this.legend_rat_poison_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 5
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRatPoison);
		this.m.Icon = "skills/status_effect_54.png";
		this.m.IconMini = "status_effect_54_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has a verminous infection running through their veins. Vision is blurred, speech is slurred, and it takes a great deal of effort to move in a coordinated fashion. The effect will slowly get worse over [color=%negative%]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function getTooltip()
	{
		local remaining = (10 - this.m.TurnsLeft);

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
				text = "[color=%negative%]-" + 1 * remaining + "[/color] Action Points"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=%negative%]-" + 1 * remaining + "[/color] Vision"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-" + 10 * remaining + "[/color] Initiative"
			}
		];
	}

	function resetTime()
	{
		this.m.TurnsLeft = this.Math.max(1, 10 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasTrait(::Legends.Trait.Ailing))
		{
			++this.m.TurnsLeft;
		}
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.max(1, 10 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasTrait(::Legends.Trait.Ailing))
		{
			++this.m.TurnsLeft;
		}
	}

	function onUpdate( _properties )
	{
		local AP = this.Math.min(1, 1 * (5 - this.m.TurnsLeft));
		local Init = this.Math.min(1, 5 * (5 - this.m.TurnsLeft));
		local Vis = this.Math.min(1, 1 * (5 - this.m.TurnsLeft));
		_properties.ActionPoints -= AP;
		_properties.Initiative -= Init;
		_properties.Vision -= Vis;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});
