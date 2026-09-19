this.legend_debilitate_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDebilitate);
		this.m.Description = "Deliver a biting strike that leaves your opponent weakened.";
		this.m.KilledString = "Cleaved";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/cleave", 3);
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = ::Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = ::Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 50;
		this.m.ChanceDisembowel = 33;
		this.m.ChanceSmash = 0;
	}

	function getTooltip() {
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=%status%]Debilitated[/color] for 2 turns"
		});
		return ret;
	}

	function onAfterUpdate(_properties) {
		this.m.FatigueCostMult = ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile ) {
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectChop);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (_skill == this) {
			local actor = this.getContainer().getActor();
			if (::Legends.S.isEntityNullOrDead(actor, _targetEntity)) {
				return;
			}

			local debilitate = ::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Debilitated);
			if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer && !_targetEntity.getFlags().has("tail")) {
				::Tactical.EventLog.log(debilitate.getLogEntryOnAdded(::Const.UI.getColorizedEntityName(actor), ::Const.UI.getColorizedEntityName(_targetEntity)));
			}
		}
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (_skill == this) {
			_properties.DamageTotalMult *= 0.5;
		}
	}
});
