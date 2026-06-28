this.perk_legend_smackdown <- this.inherit("scripts/skills/skill", {
	m = {
		TilesUsed = []
	},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSmackdown);
		this.m.SoundOnUse = [
			"sounds/combat/shatter_01.wav",
			"sounds/combat/shatter_02.wav",
			"sounds/combat/shatter_03.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/shatter_hit_01.wav",
			"sounds/combat/shatter_hit_02.wav",
			"sounds/combat/shatter_hit_03.wav"
		];
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.LegendWindUp)) {
			::Legends.Actives.grant(this, ::Legends.Active.LegendWindUp);
		}
	}

	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.LegendWindUp);
	}

	function findTileToKnockBackTo(_userTile, _targetTile) {

		if (_targetTile == null) {
			return null;
		}

		if (_userTile == null) {
			return null;
		}

		local dir = _userTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir)) {
			local knockToTile = _targetTile.getNextTile(dir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1 && this.m.TilesUsed.find(knockToTile.ID) == null) {
				return knockToTile;
			}
		}

		local altdir = dir - 1 >= 0 ? dir - 1 : 5;

		if (_targetTile.hasNextTile(altdir)) {
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1 && this.m.TilesUsed.find(knockToTile.ID) == null) {
				return knockToTile;
			}
		}

		altdir = dir + 1 <= 5 ? dir + 1 : 0;

		if (_targetTile.hasNextTile(altdir)) {
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1 && this.m.TilesUsed.find(knockToTile.ID) == null) {
				return knockToTile;
			}
		}

		return null;
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		this.m.TilesUsed = [];
		if (_skill.isRanged()) return;

		if (::Legends.S.skillEntityAliveCheck(_targetEntity)) return;

		if (_targetEntity.isNonCombatant()) return;

		local user = _skill.getContainer().getActor();

		if (!user.getSkills().hasEffect(::Legends.Effect.LegendKnockbackPrepared)) return;

		if (_targetEntity.getCurrentProperties().IsRooted || _targetEntity.getCurrentProperties().IsImmuneToKnockBackAndGrab)
			return;

		local targetTile = _targetEntity.getTile();

		local knockToTile = this.findTileToKnockBackTo(user.getTile(), targetTile);

		if (knockToTile == null) return;

		this.m.TilesUsed.push(knockToTile.ID);

		if (!user.isHiddenToPlayer() && (targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer)) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " has knocked back " + this.Const.UI.getColorizedEntityName(_targetEntity));
		}

		this.Tactical.State.handleInvoluntaryMovement(_targetEntity, user, targetTile, knockToTile, this, this.onKnockedDown, null);
		this.m.TilesUsed = [];
		return true;
	}

	function onKnockedDown(_entity, _tag) {
		if (_tag.Skill.m.SoundOnHit.len() != 0)
			this.Sound.play(_tag.Skill.m.SoundOnHit[this.Math.rand(0, _tag.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _entity.getPos());
	}

	function onUpdate(_properties) {
		_properties.DamageArmorMult *= 1.30;
	}
});

