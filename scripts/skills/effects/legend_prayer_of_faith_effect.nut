this.legend_prayer_of_faith_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1,
		Resolve = 0
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPrayerOfFaith);
		this.m.Description = "This character is being protected by a stern proclamation of faith.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getBonus() {
		return ::Math.floor(this.m.Resolve * 0.2);
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+" + this.getBonus() + "[/color] Melee Defense "
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+" + this.getBonus() + "[/color] Ranged Defense"
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += bonus;
	}

	function onTurnEnd() {
		this.removeSelf();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]+" + this.getBonus() + "[/color] " + ::Legends.S.inlineIcon(["melee_defense", "ranged_defense"]);
	}
});
