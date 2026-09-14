this.legend_stollwurm_move_tail_skill <- this.inherit("scripts/skills/actives/move_tail_skill", {
	m = {},
	function create() {
		this.move_tail_skill.onCreate();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendStollwurmMoveTail);
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/digging", 3);
		this.m.SoundOnHit = ::Legends.S.setSounds("sounds/enemies/digging", 3);
		this.m.SoundVolume = 1.1;
	}

	function onUse( _user, _targetTile ) {
		local tag = {
			Skill = this,
			User = _user,
			TargetTile = _targetTile,
			OnDone = this.onTeleportDone,
			OnTeleportStart = this.onTeleportStart,
			NoAnimations = false
		};

		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " burrows its tail");
		}

		if (_user.getTile().IsVisibleForPlayer) {
			_user.sinkIntoGround(0.75);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 800, this.onTeleportStart, tag);
		}
		else if (_targetTile.IsVisibleForPlayer) {
			this.onTeleportStart(tag);
		}
		else {
			this.onTeleportStart(tag);
		}

		_user.setActionPoints(this.Math.max(0, _user.getActionPoints() - this.Math.max(0, _user.m.Body.m.MovementAPSpent - this.m.ActionPointCost)));
		_user.m.Body.m.MovementAPSpent = 0;
		return true;
	}

	function onTeleportStart( _tag ) {
		_tag.User.storeSpriteColors();
		_tag.User.fadeTo(this.createColor("ffffff00"), 0);

		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, _tag.OnDone, _tag, false, 1000.0);
	}

	function onTeleportDone( _entity, _tag ) {
		_entity.restoreSpriteColors();

		if (!_entity.isHiddenToPlayer()) {
			_entity.riseFromGround(0.75);
		}

		if (_tag.Skill.m.SoundOnHit.len() > 0) {
			this.Sound.play(_tag.Skill.m.SoundOnHit[this.Math.rand(0, _tag.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _entity.getPos());
		}
	}

});

