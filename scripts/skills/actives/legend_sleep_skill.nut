this.legend_sleep_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendSleep);
		this.m.Description = "";
		this.m.Icon = "skills/active_116.png";
		this.m.IconDisabled = "skills/active_116_bw.png";
		this.m.Overlay = "active_116";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/alp_sleep_01.wav",
			"sounds/enemies/dlc2/alp_sleep_02.wav",
			"sounds/enemies/dlc2/alp_sleep_03.wav",
			"sounds/enemies/dlc2/alp_sleep_04.wav",
			"sounds/enemies/dlc2/alp_sleep_05.wav",
			"sounds/enemies/dlc2/alp_sleep_06.wav",
			"sounds/enemies/dlc2/alp_sleep_07.wav",
			"sounds/enemies/dlc2/alp_sleep_08.wav",
			"sounds/enemies/dlc2/alp_sleep_09.wav",
			"sounds/enemies/dlc2/alp_sleep_10.wav",
			"sounds/enemies/dlc2/alp_sleep_11.wav",
			"sounds/enemies/dlc2/alp_sleep_12.wav"
		];
		this.m.IsUsingActorPitch = true;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 600;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.MaxLevelDifference = 4;
	}

	function onVerifyTarget( _userTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_userTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().getCurrentProperties().IsStunned)
		{
			return false;
		}

		if (_targetTile.getEntity().isNonCombatant())
		{
			return false;
		}

		local EntityType = _targetTile.getEntity().getType();
		if (EntityType == this.Const.EntityType.LegendBanshee || EntityType == this.Const.EntityType.Ghost || EntityType == this.Const.EntityType.LegendDemonHound)
		{
			return false
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local tag = {
			User = _user,
			TargetTile = _targetTile
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 600, this.onDelayedEffect.bindenv(this), tag);
		return true;
	}

	function onDelayedEffect( _tag )
	{
		local targets = [];
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;

		if (_targetTile.IsOccupiedByActor)
		{
			local entity = _targetTile.getEntity();
			targets.push(entity);
		}

		local myTile = _user.getTile();

		foreach( target in targets )
		{
			local bonus = this.m.MaxRange + 1 - myTile.getDistanceTo(target.getTile());

			if (target.checkMorale(0, -25 * bonus, this.Const.MoraleCheckType.MentalAttack))
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists the urge to sleep thanks to his resolve");
				}

				continue;
			}

			::Legends.Effects.grant(target, ::Legends.Effect.Sleeping);

			if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " falls to sleep");
			}
		}
	}

});

