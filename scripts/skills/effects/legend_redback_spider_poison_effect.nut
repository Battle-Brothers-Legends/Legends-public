this.legend_redback_spider_poison_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 10,
		Damage = 1,
		LastRoundApplied = 0,
		Actor = null
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRedbackSpiderPoison);
		this.m.Description = "A vicious poison is running through %their% veins";
		this.m.KilledString = "Died from redback poison";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/dlc2/giant_spider_poison", 2);
		this.m.Type = ::Const.SkillType.StatusEffect | ::Const.SkillType.DamageOverTime;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		local timeDamage = (this.m.Damage * this.m.TurnsLeft);
		if (::Legends.isLegendaryDifficulty() && !this.getEffectOwner().isPlayerControlled()) {
			timeDamage *= 2;
		}
		tooltip.extend([ // fix this after rework, currently lies
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%negative%]" + timeDamage + "[/color] Hitpoints Damage Received every turn"
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

	function resetTime() {
		this.m.TurnsLeft = ::Math.max(1, 10 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasTrait(::Legends.Trait.Ailing)) {
			++this.m.TurnsLeft;
		}
	}

	function applyDamage() {
		if (this.m.LastRoundApplied != ::Time.getRound()) {
			local actor = this.getContainer().getActor();
			this.m.LastRoundApplied = ::Time.getRound();
			this.spawnIcon("status_effect_54", this.getContainer().getActor().getTile());

			if (actor.getCurrentProperties().IsImmuneToPoison) {
				return;
			}

			if (this.m.SoundOnUse.len() != 0) {
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.0, actor.getPos());
			}
			local timeDamage = (this.m.Damage * this.m.TurnsLeft);
			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = timeDamage;

			if (::Legends.isLegendaryDifficulty() && !this.getEffectOwner().isPlayerControlled()) {
				local timeDamage = (this.m.Damage * this.m.TurnsLeft);
				hitInfo.DamageRegular = 2 * timeDamage;
			}

			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			actor.onDamageReceived(this.getEffectOwner(), this, hitInfo);
		}
	}

	function onAdded() {
		this.m.TurnsLeft = ::Math.max(1, 10 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasTrait(::Legends.Trait.Ailing)) {
			++this.m.TurnsLeft;
		}
	}

	function onTurnEnd() {
		this.applyDamage();

		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function onWaitTurn() {
		this.applyDamage();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		// fix this after rework, currently lies
		local timeDamage = (this.m.Damage * this.m.TurnsLeft);
		if (::Legends.isLegendaryDifficulty() && !this.getEffectOwner().isPlayerControlled()) {
			timeDamage *= 2;
		}
		return "[color=%negative%]" + timeDamage * _stacks + "[/color] " + ::Legends.S.inlineIcon("damage_received") + " every turn";
	}
});
