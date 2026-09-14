this.legend_orc_elite_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendOrcElitePotion);
		this.m.Icon = "skills/status_effect_130.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_130";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "This character\'s limbic system has been altered with an additional substance that allows them to sustain particularly strenuous anaerobic activity for longer. Their skin seems vaguely greener than you remember, too, but you\'re sure that\'s a coincidence.";
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
				icon = "ui/icons/fatigue.png",
				text = "The penalty to Maximum Fatigue and Initiative from equipped items in your head, body, mainhand and offhand slots is reduced by [color=" + this.Const.UI.Color.PositiveValue + "]20%[/color]"
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

	function onUpdate(_properties)
	{
		local actor = this.getContainer().getActor();
		local fat = actor.getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);

		local mainhand = actor.getMainhandItem();
		if (mainhand != null)
		{
			fat += mainhand.getStaminaModifier();
		}

		local offhand = actor.getOffhandItem();
		if (offhand != null)
		{
			fat += offhand.getStaminaModifier();
		}

		_properties.Stamina -= fat * 20 * 0.01;
		_properties.Initiative -= fat * 20 * 0.01;		
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isOrcElitePotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isOrcElitePotionAcquired", false);
	}

});

