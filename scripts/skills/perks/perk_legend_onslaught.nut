this.perk_legend_onslaught <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendOnslaught);
		this.m.Description = "The only real power comes behind a heavy blade.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/bash", 3);
		this.m.SoundOnHitHitpoints = ::Legends.S.setSounds("sounds/combat/bash_hit", 3);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend(this.getDynamicTooltip());
		return tooltip;
	}

	function isHidden() {
		return this.getBonus() == 0;
	}

	function getBonus(_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
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

	function getDynamicTooltip(_actor = null) {
		return [
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%positive%]+" + this.getBonus(_actor) + "%" + "[/color] Melee Damage dealt"
			}
		];
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.getBonus() + "%[/color] " + ::Legends.S.inlineIcon("damage_dealt") + ", [color=%positive%]50%[/color] to Baffle enemies on hit";
	}
});
