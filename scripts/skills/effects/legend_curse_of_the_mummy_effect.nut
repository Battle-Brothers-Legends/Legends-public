this.legend_curse_of_the_mummy_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendCurseOfTheMummy);
		this.m.Description = "Cursed by the death of a mummy.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getName() {
		return this.m.Stacks > 1 ? this.m.Name + " (x" + this.m.Stacks + ")" : this.m.Name;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();

		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%negative%]+" + this.getBonus() + "%[/color] Damage Received from any source"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Enemies are more likely to target this character"
			}
		]);

		return tooltip;
	}

	function getBonus() {
		return 25 * this.m.Stacks;
	}

	function onUpdate(_properties) {
		local bonus = this.getBonus() * 0.01;
		_properties.DamageReceivedTotalMult *= 1.0 + bonus;
		_properties.TargetAttractionMult *= 1.0 + bonus;
	}

	function onRefresh() {
		this.m.Stacks++;
		this.spawnIcon("mummy_curse", this.getContainer().getActor().getTile());
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + (25 * this.m.Stacks) + "%[/color] " + ::Legends.S.inlineIcon("damage_received");
	}
});
