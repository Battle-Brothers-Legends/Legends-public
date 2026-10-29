this.perk_legend_rebound <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendRebound);
		this.m.Description = "The Gods' work does not care for exhaustion.";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function isHidden() {
		return this.getBonus() == 0;
	}

	function getBonus() {
		return ::Math.ceil(0.1 * this.getContainer().getActor().getFatigue());
	}

	function onUpdate(_properties) {
		_properties.FatigueRecoveryRate += this.getBonus();
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/fatigue_recovery_up.png",
				text = "[color=%positive%]+" + this.getBonus() + "[/color] Fatigue regenerated every turn"
			}
		]);
		return tooltip;
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.getBonus() + "[/color] " + ::Legends.S.inlineIcon("fatigue_recovery_up");
	}
});
