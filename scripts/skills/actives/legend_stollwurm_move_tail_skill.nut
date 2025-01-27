this.legend_stollwurm_move_tail_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendStollwurmMoveTail);
		this.m.Description = "";
		this.m.Icon = "skills/active_109.png";
		this.m.IconDisabled = "skills/active_109.png";
		this.m.Overlay = "active_109";
		this.m.SoundOnUse = [
			"sounds/enemies/digging_01.wav",
			"sounds/enemies/digging_02.wav",
			"sounds/enemies/digging_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/enemies/digging_01.wav",
			"sounds/enemies/digging_02.wav",
			"sounds/enemies/digging_03.wav"
		];
		this.m.SoundVolume = 1.1;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 99;
		this.m.MaxLevelDifference = 4;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsEmpty)
		{
			return false;
		}

		local body = this.getContainer().getActor().getBody();

		if (body == null || body.isNull() || !body.isAlive() || _targetTile.getDistanceTo(body.getTile()) > 1)
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local tag = {
			Skill = this,
			User = _user,
			TargetTile = _targetTile,
			OnDone = this.onTeleportDone,
			OnTeleportStart = this.onTeleportStart,
			NoAnimations = false
		};

		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " burrows its tail");
		}

		if (_user.getTile().IsVisibleForPlayer)
		{
			_user.sinkIntoGround(0.75);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 800, this.onTeleportStart, tag);
		}
		else if (_targetTile.IsVisibleForPlayer)
		{
			this.onTeleportStart(tag);
		}
		else
		{
			this.onTeleportStart(tag);
		}

		return true;
	}

	function onTeleportStart( _tag )
	{

			_tag.User.storeSpriteColors();
			_tag.User.fadeTo(this.createColor("ffffff00"), 0);

		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, _tag.OnDone, _tag, false, 1000.0);

	}

	function onTeleportDone( _entity, _tag )
	{
			_entity.restoreSpriteColors();

		if (!_entity.isHiddenToPlayer())
		{
			_entity.riseFromGround(0.75);
		}

		if (_tag.Skill.m.SoundOnHit.len() > 0)
		{
			this.Sound.play(_tag.Skill.m.SoundOnHit[this.Math.rand(0, _tag.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _entity.getPos());
		}
	}

});

