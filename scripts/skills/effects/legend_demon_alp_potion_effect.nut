this.legend_demon_alp_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendDemonAlpPotion);
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
				icon = "ui/icons/immunity.png",
				text = "Surrounding enemies no longer reduce this character's Defenses"
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
		_properties.IsImmuneToSurrounding = true;
	}

	function onDeath(_fatalityType) {
		if (_fatalityType != ::Const.FatalityType.Unconscious) {
			::World.Statistics.getFlags().set("isDemonAlpPotionAcquired", false);
		}
	}

	function onDismiss() {
		::World.Statistics.getFlags().set("isDemonAlpPotionAcquired", false);
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return ::Legends.S.inlineIcon("immunity") + " to Surrounding";
	}
});
