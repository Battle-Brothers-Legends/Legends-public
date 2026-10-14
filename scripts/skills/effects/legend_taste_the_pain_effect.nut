this.legend_taste_the_pain_effect <- this.inherit("scripts/skills/skill", {
	m = {
		StackCount = 0
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendTasteThePain);
		this.m.Description = "This character is invigorated by pain.";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "Gain [color=%positive%]" + (4 * this.m.StackCount) + "[/color] Resolve."
		});
		return tooltip;
	}

	function onUpdate(_properties) {
		this.m.IsHidden = this.m.StackCount == 0;
		_properties.IsAffectedByLosingHitpoints = false;
		_properties.Bravery += this.m.StackCount * 4;
	}

	function onDamageReceived(_attacker, _damageHitpoints, _damageArmor) {
		if (_attacker == null || _attacker.isAlliedWith(this.getContainer().getActor())) {
			return;
		}

		if (::Tactical.TurnSequenceBar.getActiveEntity() == null && ::Tactical.TurnSequenceBar.getActiveEntity().getID() != _attacker.getID()) {
			return;
		}

		this.m.StackCount++;
	}

	function onCombatFinished() {
		this.m.StackCount = 0;
	}

	function getActorHoverTooltip(_activeEntity) {
		return "Receiving damage increases Resolve instead of triggering a Morale Check";
	}
});
