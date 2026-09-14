this.legend_necrosavant_lord_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendNecrosavantLordPotion);
		this.m.Icon = "skills/status_effect_133.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_133";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/vampire_life_drain", 3);
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "This character\'s body has the incredible ability to incorporate different blood types - or indeed, blood from entirely different creatures - into itself. This grants them remarkable healing via absorption of blood through skin pores (or more dramatically by drinking it directly).";
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
				icon = "ui/icons/special.png",
				text = "Ignore Zone of Control(ZOC) if hitpoints are below [color=" + this.Const.UI.Color.NegativeValue + "]50%[/color]"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations will cause a longer period of sickness"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (actor.getHitpoints() < actor.getHitpointsMax() / 2)
		{
			_properties.IsImmuneToZoneOfControl = true;
		}
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isNecrosavantLorePotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isNecrosavantLorePotionAcquired", false);
	}

});

