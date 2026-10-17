this.legend_orc_elite_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendOrcElitePotion);
		this.m.Description = "tbd";
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function getTooltip() {
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
				text = "The penalty to Maximum Fatigue and Initiative from equipped items in your head, body, mainhand and offhand slots is reduced by [color=%positive%]20%[/color]"
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

	function onUpdate(_properties) {
		local actor = this.getContainer().getActor();
		local fat = actor.getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);

		local mainhand = actor.getMainhandItem();
		if (mainhand != null) {
			fat += mainhand.getStaminaModifier();
		}

		local offhand = actor.getOffhandItem();
		if (offhand != null) {
			fat += offhand.getStaminaModifier();
		}

		_properties.Stamina -= fat * 0.2;
		_properties.Initiative -= fat * 0.2; // should this be in actor's getInitiative like brawny?
	}

	function onDeath(_fatalityType) {
		if (_fatalityType != ::Const.FatalityType.Unconscious) {
			::World.Statistics.getFlags().set("isOrcElitePotionAcquired", false);
		}
	}

	function onDismiss() {
		::World.Statistics.getFlags().set("isOrcElitePotionAcquired", false);
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "Reduces " + ::Legends.S.inlineIcon("fatigue") + ::Legends.S.inlineIcon("initiative") + " of your equipped head, armor and weapons by [color=%positive%]20%[/color]";
	}
});
