this.legend_redback_spider_poison_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3,
		TurnsApplied = 0, // kinda sloppy but works
		Damage = 10,
		LastRoundApplied = 0,
		Actor = null
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRedbackSpiderPoison);
		this.m.Description = "A vicious poison is running through %their% veins. It takes hold a little more every turn: first it leaves %them% Baffled, then Dazed, and finally Stunned.";
		this.m.KilledString = "Died from redback poison";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/dlc2/giant_spider_poison", 2);
		this.m.Type = ::Const.SkillType.StatusEffect | ::Const.SkillType.DamageOverTime;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		local param = [
			["_damage", this.getDamage()],
			["_stage", this.getStage().Name],
			["_turnsLeft", this.m.TurnsLeft]
		];
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%negative%]%_damage%[/color] Hitpoints Damage Received every turn",
				param = param
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will leave this character [color=%status%]%_stage%[/color] at the start of their next turn",
				param = param
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "Wears off in [color=%negative%]%turnsLeft%[/color] turn(s)",
				param = param
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
		this.m.Actor = ::WeakTableRef(_a);
	}

	function getDuration() {
		local turns = ::Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasTrait(::Legends.Trait.Ailing)) {
			++turns;
		}

		return turns;
	}

	function resetTime() {
		this.m.TurnsLeft = this.getDuration();
	}

	// What the poison does at the start of the next turn: Baffled on the first turn of being poisoned, Dazed on the second, Stunned from the third
	function getStage() {
		local stages = [
			{ Name = "Baffled", Effect = ::Legends.Effect.Baffled, IsImmune = @(_p) _p.IsImmuneToDaze },
			{ Name = "Dazed", Effect = ::Legends.Effect.Dazed, IsImmune = @(_p) _p.IsImmuneToDaze },
			{ Name = "Stunned", Effect = ::Legends.Effect.Stunned, IsImmune = @(_p) _p.IsImmuneToStun }
		];
		local stage = this.m.TurnsApplied;

		if (this.getContainer().hasTrait(::Legends.Trait.Ailing)) {
			++stage;
		}

		if (this.getContainer().hasPerk(::Legends.Perk.HoldOut)) {
			stage = 0;
		}

		return stages[::Math.min(stage, stages.len() - 1)];
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
			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.getDamage();
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			actor.onDamageReceived(this.getEffectOwner(), this, hitInfo);
		}
	}

	function onAdded() {
		this.m.TurnsLeft = this.getDuration();
	}

	function onTurnStart() {
		local actor = this.getContainer().getActor();
		local stage = this.getStage();

		if (actor.getCurrentProperties().IsImmuneToPoison || stage.IsImmune(actor.getCurrentProperties())) {
			return;
		}

		::Legends.Effects.grant(this.getContainer(), stage.Effect);

		if (!actor.isHiddenToPlayer()) {
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " is " + stage.Name.tolower() + " by redback poison");
		}
	}

	function onTurnEnd() {
		this.applyDamage();
		++this.m.TurnsApplied;

		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function onWaitTurn() {
		this.applyDamage();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]" + this.getDamage() * _stacks + "[/color] " + ::Legends.Text.inlineIcons("damage_received") + " every turn";
	}
});
