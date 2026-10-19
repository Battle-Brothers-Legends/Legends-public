this.legend_marked_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendMarked);
		this.m.Description = "Marked for death by a skilled opponent.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-10[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-10[/color] Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "[color=%positive%]" + getBonus() * 100 + "%[/color] Damage Received from all sources"
			}
		]);
		return tooltip;
	}

	function getBonus() {
		return 1.0 + ::Math.min(0.2, this.getContainer().getActor().getHitpointsMax() * 0.01);
	}

	function onUpdate(_properties) {
		_properties.RangedDefense -= 10;
		_properties.MeleeDefense -= 10;
		_properties.DamageReceivedTotalMult *= this.getBonus();
	}

	function onTurnEnd() {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]-10[/color] " + ::Legends.S.inlineIcon(["melee_defense", "ranged_defense"]) + ", [color=%positive%]+" + ((this.getBonus() - 1) * 100) + "%[/color] " + ::Legends.S.inlineIcon("damage_received");
	}
});
