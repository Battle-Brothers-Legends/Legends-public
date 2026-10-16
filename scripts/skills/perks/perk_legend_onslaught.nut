this.perk_legend_onslaught <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendOnslaught);
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/bash", 3);
		this.m.SoundOnHitHitpoints = ::Legends.S.setSounds("sounds/combat/bash_hit", 3);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Current melee damage bonus is [color=%positive%]+" + getBonus() + "%" + "[/color]"
		});
		return tooltip;
	}

	function isHidden() {
		this.getBonus() == 0;
	}

	function getBonus() {
		local actor = this.getContainer().getActor();
		return 0.02 * (actor.getArmor(::Const.BodyPart.Head) + actor.getArmor(::Const.BodyPart.Body));
	}

	function onUpdate(_properties) {
		_properties.MeleeDamageMult *= 1 + this.getBonus() * 0.01;
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (::Legends.S.isEntityNullOrDead(_targetEntity) || _targetEntity.isNonCombatant()) {
			return false;
		}

		local user = this.getContainer().getActor();
		if (user.getInitiative() <= _targetEntity.getInitiative() || ::Math.rand(1, 100) > 50) {
			return false;
		}

		if (!_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendBaffled)) {
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendBaffled);

			if (!user.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer) {
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(user) + " battered " + ::Const.UI.getColorizedEntityName(_targetEntity) + " leaving them baffled");
			}
		}

		return true;
	}
});
