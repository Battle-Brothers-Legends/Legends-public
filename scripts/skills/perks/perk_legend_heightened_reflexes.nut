this.perk_legend_heightened_reflexes <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHeightenedReflexes);
		this.m.Description = "Everyone makes mistakes if you are quick enough.";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function getBonus(_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		return ::Math.floor(actor.getInitiative() * 0.15) * 0.01;
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		_properties.DamageTotalMult += this.getBonus();
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend(this.getDynamicTooltip());
		return tooltip;
	}

	function getDynamicTooltip(_actor = null) {
		return [
			{
				id = 6,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%positive%]+" + (this.getBonus(_actor) *100) + "%[/color] Damage dealt"
			}
		];
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + (this.getBonus() * 100) + "%[/color] " + ::Legends.S.inlineIcon("damage_dealt");
	}
});
