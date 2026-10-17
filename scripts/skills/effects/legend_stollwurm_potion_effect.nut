this.legend_stollwurm_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendStollwurmPotion);
		this.m.Description = "tbd";
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/immunity.png",
				text = "Immune to Stun"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations will cause a longer period of sickness"
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.IsImmuneToStun = true;
	}

	function onDeath(_fatalityType) {
		if (_fatalityType != ::Const.FatalityType.Unconscious) {
			::World.Statistics.getFlags().set("isStollwurmPotionAcquired", false);
		}
	}

	function onDismiss() {
		::World.Statistics.getFlags().set("isStollwurmPotionAcquired", false);
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return ::Legends.S.inlineIcon("immunity") + " to Stun";
	}
});
