this.legend_taste_the_pain_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendTasteThePain);
		this.m.Description = "This character is invigorated by pain.";
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "Gain [color=%positive%]" + (4 * this.m.Stacks) + "[/color] Resolve."
		});
		return tooltip;
	}

	function onUpdate(_properties) {
		this.m.IsHidden = this.m.Stacks == 0;
		_properties.IsAffectedByLosingHitpoints = false;
		_properties.Bravery += this.m.Stacks * 4;
	}

	function onDamageReceived(_attacker, _damageHitpoints, _damageArmor) {
		if (_attacker == null || _attacker.isAlliedWith(this.getContainer().getActor())) {
			return;
		}

		if (::Tactical.TurnSequenceBar.getActiveEntity() == null && ::Tactical.TurnSequenceBar.getActiveEntity().getID() != _attacker.getID()) {
			return;
		}

		this.m.Stacks++;
	}

	function onCombatFinished() {
		this.m.Stacks = 0;
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+4[/color] " + ::Legends.S.inlineIcon("bravery") + "when receiving Damage instead of triggering a Morale Check";
	}
});
