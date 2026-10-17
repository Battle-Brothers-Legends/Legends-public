this.legend_lightning_reflexes_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendLightningReflexes);
		this.m.Description = "Rely on your reflexes to only ever get grazed in combat with slower opponents.";
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Gain hit point damage reduction proportional to the difference between your current Initiative and your attacker\'s, up to 80% for 100 initiative."
		});
		return tooltip;
	}

	function getBonus(_attacker, _defender) {
		local initDiff = _defender.getInitiative() - _attacker.getInitiative();
		if (::Legends.S.isEntityNullOrDead(_attacker, _defender) || initDiff <= 0) {
			return 1;
		}
		return 1 - 0.8 * ::Math.minf(1, ::Math.pow(initDiff / 100.0, 0.4));
	}

	function onBeforeDamageReceived(_attacker, _skill, _hitInfo, _properties) {
		if (_attacker != null && _attacker.getID() != this.getContainer().getActor().getID() && _skill != null && _skill.isAttack() && _skill.isUsingHitchance()) {
			_properties.DamageReceivedRegularMult *= this.getBonus(_attacker, this.getContainer().getActor());
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		if (!::Legends.S.isEntityNullOrDead(_activeEntity) && _activeEntity.isPlayerControlled()) {
			local bonus = ::Math.round((1 - this.getBonus(_activeEntity, this.getContainer().getActor())) * 100);
			if (bonus > 0) {
				return "Receive [color=%positive%]" + bonus + "%[/color] less damage through superior Initiative";
			}
		}
		return null;
	}
});
