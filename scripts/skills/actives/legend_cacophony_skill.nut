this.legend_cacophony_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendCacophony);
		this.m.Description = "Assault the senses of your target with a wild clamor and noise from your instrument leave them distracted. Does no damage and requires an instrument.";
		this.m.KilledString = "";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/stupefy", 5);
		this.m.SoundOnHit = ["sounds/humans/0/human_fatigue_01.wav"];
		this.m.SoundVolume = 1.25;
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsRanged = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
	}

	function getTooltip() {
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Leave your opponent [color=%effect]Distracted[/color], which will reduce Damage and Initiative [color=%negative%]35%[/color]"
		});

		return ret;
	}

	function getHitchance(_targetEntity) {
		if (!_targetEntity.isAttackable()) {
			return 0;
		}

		local chance = getContainer().getActor().getCurrentProperties().getRangedSkill() - _targetEntity.getCurrentProperties().getRangedDefense();

		if (getContainer().hasPerk(::Legends.Perk.LegendManipulative)) {
			chance *= 2;
		}

		return ::Math.max(0, ::Math.min(100, chance));
	}

	function onUse(_user, _targetTile) {
		local targetEntity = _targetTile.getEntity();
		local roll = ::Math.rand(1, 100);
		local chance = this.getHitchance(targetEntity);

		local logString = ::Const.UI.getColorizedEntityName(_user) + " tries to stupefy " + ::Const.UI.getColorizedEntityName(targetEntity) + " (Chance: " + chance + ", Rolled: " + roll + ")\n";
		if (roll <= chance) {
			this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectBash);
			if (!targetEntity.getCurrentProperties().IsImmuneToStun) {

				if (!::Legends.S.isEntityNullOrDead(targetEntity)) {
					::Legends.Effects.grant(targetEntity, ::Legends.Effect.LegendStupefied);

					if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer) {
						::Tactical.EventLog.log(logString + ::Const.UI.getColorizedEntityName(_user) + " stupefied " + ::Const.UI.getColorizedEntityName(targetEntity));
					}
				}

				return true;
			} else {
				::Tactical.EventLog.log(logString + ::Const.UI.getColorizedEntityName(targetEntity) + " is immune");
				return false;
			}
		} else {
			::Tactical.EventLog.log(logString + ::Const.UI.getColorizedEntityName(_user) + " failed to stupefy " + ::Const.UI.getColorizedEntityName(targetEntity));
			return false;
		}

		return false;
	}

});
