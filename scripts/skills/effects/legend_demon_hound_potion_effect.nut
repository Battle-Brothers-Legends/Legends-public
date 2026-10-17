this.legend_demon_hound_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendDemonHoundPotion);
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function getDescription() {
		return "tbd";
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
				icon = "ui/icons/fatigue_recovery_up.png",
				text = "[color=%positive%]+3[/color] Fatigue Recovery per turn"
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
		_properties.FatigueRecoveryRate += 3;
	}

	function onDeath(_fatalityType) {
		if (_fatalityType != ::Const.FatalityType.Unconscious) {
			::World.Statistics.getFlags().set("isDemonHoundPotionAcquired", false);
		}
	}

	function onDismiss() {
		::World.Statistics.getFlags().set("isDemonHoundPotionAcquired", false);
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+3[/color] " + ::Legends.S.inlineIcon("fatigue_recovery_up");
	}
});
