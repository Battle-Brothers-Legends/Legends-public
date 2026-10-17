this.legend_disintegrating_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2,
		Damage = 10,
		LastRoundApplied = 0,
		Actor = null
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendDisintegrating);
		this.m.Description = "This character is being disintegrated!";
		this.m.KilledString = "Disintegrated";
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
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " is disintegrating.");
			this.getContainer().getActor().onDamageReceived(this.getEffectOwner(), this, hitInfo);

			if (--this.m.TurnsLeft <= 0) {
				this.removeSelf();
			}
		}
	}

	function onAdded() {
		this.m.TurnsLeft = ::Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

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

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]" + this.m.Damage + "[/color] " + ::Legends.S.inlineIcon("damage_received") + " every turn";
	}
});
