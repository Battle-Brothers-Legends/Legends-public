this.legend_rsw_bleeding_bleed_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2,
		Damage = 5,
		LastRoundApplied = 0,
		Actor = null
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRswBleedingBleed);
		this.m.KilledString = "Bled to death";
		this.m.Type = ::Const.SkillType.StatusEffect | ::Const.SkillType.DamageOverTime;
		this.m.IsActive = false;
		this.m.IsStacking = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%negative%]" + this.getDamage() + "[/color] Hitpoints Damage Received every turn"
			}
		]);
		return tooltip;
	}

	function setStats(_s1, _s2) {
		this.m.Damage = _s1;
		this.m.TurnsLeft = _s2;
	}
	function getDamage() {
		return this.m.Damage;
	}

	function setActor(_a) {
		this.m.Actor = ::MSU.asWeakTableRef(_a);
	}

	function getDescription() {
		return "This character is bleeding profusely from a recently received wound.";
	}

	function applyDamage() {
		if (this.m.LastRoundApplied != ::Time.getRound()) {
			this.m.LastRoundApplied = ::Time.getRound();
			this.spawnIcon("status_effect_01", this.getContainer().getActor().getTile());
			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.m.Damage;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			this.getContainer().getActor().onDamageReceived(this.getEffectOwner(), this, hitInfo);

			if (--this.m.TurnsLeft <= 0) {
				this.removeSelf();
			}
		}
	}

	function onAdded() {
		this.m.TurnsLeft = ::Math.max(1, this.m.TurnsLeft + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasTrait(::Legends.Trait.Bleeder)) {
			++this.m.TurnsLeft;
		}
	}

	function onUpdate(_properties) {}

	function onTurnEnd() {
		this.applyDamage();
	}

	function onWaitTurn() {
		this.applyDamage();
	}

	function onCombatFinished() {
		this.removeSelf();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]" + (this.getDamage() * _stacks) + "[/color] " + ::Legends.S.inlineIcon("damage_received") + " every turn";
	}
});
