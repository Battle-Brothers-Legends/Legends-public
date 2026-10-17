this.legend_hexe_leader_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendHexeLeaderPotion);
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
				icon = "ui/icons/bravery.png",
				text = "Re-roll every failed morale check for a second chance"
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
		_properties.RerollMoraleChance = 100;
	}

	function onDeath(_fatalityType) {
		if (_fatalityType != ::Const.FatalityType.Unconscious) {
			::World.Statistics.getFlags().set("isHexeLeaderPotionAcquired", false);
		}
	}

	function onDismiss() {
		::World.Statistics.getFlags().set("isHexeLeaderPotionAcquired", false);
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "Reroll failed morale checks once";
	}
});
