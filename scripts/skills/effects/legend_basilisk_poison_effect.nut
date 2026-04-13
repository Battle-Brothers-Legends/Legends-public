this.legend_basilisk_poison_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBasiliskPoison);
		this.m.Icon = "skills/status_effect_54.png";
		this.m.IconMini = "status_effect_54_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has received a venomous bite. Their veins are black and bloated, tears swell in their eyes, and their breathing is shallow. This effect will slowly wear off over [color=%negative%]" + this.m.TurnsLeft + "[/color] more turn(s).";
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
				icon = "ui/icons/bravery.png",
				text = "[color=%negative%]-" + 20 * this.m.TurnsLeft + "[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]-" + 20 * this.m.TurnsLeft + "[/color]% Max Fatigue"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=%negative%]-" + 3 * this.m.TurnsLeft + "[/color] Fatigue Recovery"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-" + 25 * this.m.TurnsLeft + "[/color]% Initiative"
			}
		];
	}

	function resetTime()
	{
		this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasTrait(::Legends.Trait.Ailing))
		{
			++this.m.TurnsLeft;
		}
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasTrait(::Legends.Trait.Ailing))
		{
			++this.m.TurnsLeft;
		}
	}

	function onUpdate( _properties )
	{
		_properties.Bravery -= 20 * this.m.TurnsLeft;
		_properties.StaminaMult *= 1.0 - 0.20 * this.m.TurnsLeft;
		_properties.FatigueRecoveryRate -= 3 * this.m.TurnsLeft;
		_properties.InitiativeMult *= 1.0 - 0.20 * this.m.TurnsLeft;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

