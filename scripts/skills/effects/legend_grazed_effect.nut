this.legend_grazed_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 5,
		Damage = 2,
		LastRoundApplied = 0,
		Actor = null,
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendGrazed);
		this.m.Description = "This character is bleeding slowly from multiple recent deep grazes";
		this.m.KilledString = "Bled to death";
		this.m.Type = ::Const.SkillType.StatusEffect | ::Const.SkillType.DamageOverTime;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%negative%]" + this.m.Damage + "[/color] Hitpoints Damage Received every turn"
			}
		]);
		return tooltip;
	}

	function getDamage() {
		return this.m.Damage;
	}

	function setDamage(_d) {
		this.m.Damage = _d;
	}

	function setActor(_a) {
		this.m.Actor = ::MSU.asWeakTableRef(_a);
	}

	function applyDamage() {
		if (this.m.LastRoundApplied != ::Time.getRound()) {
			this.m.LastRoundApplied = ::Time.getRound();
			local actor = this.getContainer().getActor();
			this.spawnIcon("status_effect_01", actor.getTile());
			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.m.Damage;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			actor.onDamageReceived(this.getEffectOwner(), this, hitInfo);

			if (--this.m.TurnsLeft <= 0) {
				this.removeSelf();
			}
		}
	}

	function onAdded() {
		local actor = this.getContainer().getActor();
		local properties = actor.getCurrentProperties();
		if (properties.IsResistantToAnyStatuses && ::Math.rand(1, 100) <= 50) {
			if (!actor.isHiddenToPlayer()) {
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " had his bleeding wound quickly close thanks to unnatural physiology");
			}

			this.removeSelf();
		} else {
			this.m.TurnsLeft = ::Math.max(3, 5 + properties.NegativeStatusEffectDuration);

			if (this.getContainer().hasTrait(::Legends.Trait.Bleeder)) {
				this.m.TurnsLeft += 2;
			}
		}
	}

	function onTurnEnd() {
		this.applyDamage();
	}

	function onWaitTurn() {
		this.applyDamage();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]" + this.m.Damage * _stacks  + "[/color] " + ::Legends.S.inlineIcon("damage_received") + " every turn";
	}
});
