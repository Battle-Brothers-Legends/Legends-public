this.legend_rock_unhold_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRockUnholdPotion);
		this.m.Description = "tbd";
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "[color=%positive%]+15%[/color] total Body armor"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/armor_head.png",
				text = "[color=%positive%]+15%[/color] total Head armor"
			},
			{
				id = 13,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations will cause a longer period of sickness"
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.ArmorMult[::Const.BodyPart.Head] *= 1.15;
		_properties.ArmorMult[::Const.BodyPart.Body] *= 1.15;
	}

	function onDeath(_fatalityType) {
		if (_fatalityType != ::Const.FatalityType.Unconscious) {
			::World.Statistics.getFlags().set("isRockUnholdPotionAcquired", false);
		}
	}

	function onDismiss() {
		::World.Statistics.getFlags().set("isRockUnholdPotionAcquired", false);
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+15%[/color] total " + ::Legends.S.inlineIcon(["armor_body", "armor_head"]);
	}
});
