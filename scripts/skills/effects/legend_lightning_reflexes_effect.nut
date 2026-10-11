this.legend_lightning_reflexes_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendLightningReflexes);
		this.m.Description = "Rely on your reflexes to only ever get grazed in combat with slower opponents.";
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
			icon = "ui/icons/special.png",
			text = "Gain hit point damage reduction proportional to the difference between your current Initiative and your attacker\'s, up to 80% for 100 initiative."
		});
		return tooltip;
	}

	function getBonus(_attacker, _defender) {
		return (::Legends.S.isEntityNullOrDead(_attacker, _defender) ? 1 : (1 - ::Math.minf(1, ::Math.maxf(0.0, ::Math.pow((_defender.getInitiative() - _attacker.getInitiative()) / 100.0, 0.4))) * 0.8));
	}

	function onBeforeDamageReceived(_attacker, _skill, _hitInfo, _properties) {
		if (_attacker != null && _attacker.getID() != this.getContainer().getActor().getID() && _skill != null && _skill.isAttack() && _skill.isUsingHitchance()) {
			_properties.DamageReceivedRegularMult *= this.getBonus(_attacker, this.getContainer().getActor());
		}
	}

	function getActorHoverTooltip(_activeEntity) {
		if (!::Legends.S.isEntityNullOrDead(_activeEntity) && _activeEntity.isPlayerControlled()) {
			local bonus = ::Math.round((1 - this.getBonus(_activeEntity, this.getContainer().getActor())) * 100);
			if (bonus > 0) {
				return  "Receive [color=%positive%]" + bonus + "%[/color] less damage through superior Initiative";
			}
		}
		return null;
	}
});
