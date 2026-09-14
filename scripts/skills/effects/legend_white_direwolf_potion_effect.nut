this.legend_white_direwolf_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendConquerorPotion);
		this.m.Icon = "skills/status_effect_139.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_139";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "This character\'s muscles have mutated and respond differently to movement impulses. It is much less fatiguing to interrupt or stop mid-motion as a consequence, making it much easier to recover from errant or blocked attacks.";
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
				text = "Is immune to Overwhelmed"
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
		_properties.IsImmuneToOverwhelm = true;
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isWhiteDirewolfPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isWhiteDirewolfPotionAcquired", false);
	}

});

