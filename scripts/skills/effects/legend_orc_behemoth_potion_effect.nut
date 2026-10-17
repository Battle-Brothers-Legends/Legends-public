this.legend_orc_behemoth_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendOrcBehemothPotion);
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
				text = "The Fatigue cost of the Adrenaline skill is reduced by [color=%positive%]60%[/color]"
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

	function onDeath(_fatalityType) {
		if (_fatalityType != ::Const.FatalityType.Unconscious) {
			::World.Statistics.getFlags().set("isOrcBehemothPotionAcquired", false);
		}
	}

	function onDismiss() {
		::World.Statistics.getFlags().set("isOrcBehemothPotionAcquired", false);
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return ::Legends.S.inlineIcon("fatigue") + " cost of Adrenaline reduced by [color=%positive%]60%[/color]";
	}
});
