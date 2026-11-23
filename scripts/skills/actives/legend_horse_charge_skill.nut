this.legend_horse_charge_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendHorseCharge);
		this.m.Description = "Push your mount forward with speed, ending in an impact that stuns an enemy.";
		this.m.Icon = "skills/horse_charge.png";
		this.m.IconDisabled = "skills/horse_charge_bw.png";
		this.m.Overlay = "horse_charge";
		this.m.SoundOnUse = [
			"sounds/combat/gallop.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/knockback_hit_01.wav",
			"sounds/combat/knockback_hit_02.wav",
			"sounds/combat/knockback_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
	}

	function findTileToKnockBackTo(_userTile, _targetTile) {
		local dir = _userTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir)) {
			local knockToTile = _targetTile.getNextTile(dir);

			if (knockToTile.IsEmpty && this.Math.abs(knockToTile.Level - _userTile.Level) <= 1) {
				return knockToTile;
			}
		}

		local altdir = dir - 1 >= 0 ? dir - 1 : 5;

		if (_targetTile.hasNextTile(altdir)) {
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && this.Math.abs(knockToTile.Level - _userTile.Level) <= 1) {
				return knockToTile;
			}
		}

		altdir = dir + 1 <= 5 ? dir + 1 : 0;

		if (_targetTile.hasNextTile(altdir)) {
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && this.Math.abs(knockToTile.Level - _userTile.Level) <= 1) {
				return knockToTile;
			}
		}

		return null;
	}

	function onVerifyTarget(_originTile, _targetTile) {
		return this.skill.onVerifyTarget(_originTile, _targetTile) && !_targetTile.getEntity().getCurrentProperties().IsRooted && this.findTileToKnockBackTo(_originTile, _targetTile) != null;
	}

	function onUse(_user, _targetTile) {
		local target = _targetTile.getEntity();

		if (this.m.SoundOnUse.len() != 0) {
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);

		if (knockToTile == null) {
			return false;
		}

		this.applyFatigueDamage(target, 10);

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab) {
			return false;
		}

		if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer)) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " pushes through " + this.Const.UI.getColorizedEntityName(target));
		}

		if (this.m.SoundOnHit.len() != 0) {
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		this.Tactical.State.handleInvoluntaryMovement(target, _user, _targetTile, knockToTile, this, null, this.onFollow);
		return true;
	}

	function onFollow(_tag) {
		if (_tag.TargetTile.IsEmpty) {
			_tag.Actor.setCurrentMovementType(this.Const.Tactical.MovementType.Default);
			this.Tactical.getNavigator().teleport(_tag.Actor, _tag.TargetTile, null, null, false);
		}
	}
});

