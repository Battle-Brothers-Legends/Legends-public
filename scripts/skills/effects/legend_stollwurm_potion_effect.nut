this.legend_stollwurm_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendStollwurmPotion);
		this.m.Icon = "skills/status_effect_140.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_140";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "This character\'s blood is highly pressurized and burns upon prolonged exposure to air. Attackers who break skin will find themselves unpleasantly surprised by the resultant spray.";
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
				text = "Is immune to Stun"
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
		_properties.IsImmuneToStun = true;
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != ::Const.FatalityType.Unconscious)
		{
			::World.Statistics.getFlags().set("isStollwurmPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		::World.Statistics.getFlags().set("isStollwurmPotionAcquired", false);
	}

});

