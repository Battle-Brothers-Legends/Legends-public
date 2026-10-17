this.legend_compromised_armor_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendCompromisedArmor);
		this.m.Description = "%Their% armor is compromised from a recent strike.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
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
				icon = "ui/icons/direct_damage.png",
				text = "[color=%positive%]+20%[/color] Direct Damage Received"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "[color=%positive%]+20%[/color] Armor Damage Received"
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.DamageReceivedDirectMult *= 1.2;
		_properties.DamageReceivedArmorMult *= 1.2;
	}

	function onTurnEnd() {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function onWaitTurn() {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+20%[/color] " + ::Legends.S.inlineIcon("direct_damage") + ::Legends.S.inlineIcon("armor_damage");
	}
});
