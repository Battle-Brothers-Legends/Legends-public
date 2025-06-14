this.legend_magic_sleep_skill <- this.inherit("scripts/skills/actives/legend_magic_skill", {
	m = {
	},

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMagicSleep);
		this.m.Description = "Use soothing vapours to lull an enemy to sleep. The chance of success is determined by the resolves of the user and target.";
		this.m.KilledString = "Slept";
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
		this.m.IsTargetingActor = false;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;

		this.m.MinRange = 0;
		this.m.MaxRange = 5;

		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 70;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Chance to apply to all enemies within 1 range of target tile."
		});
		return ret;
	}

	// Return true if _target actor would be put to sleep.
	function makeSleepCheck(_target)
	{
		local targetResolve = _target.getCurrentProperties().getBravery();
		local chance = this.Math.round(40 + (this.getCurrentResolve() - targetResolve)/5);
		if (chance > 100)
		{
			chance = 100;
		}
		if (chance < 0)
		{
			chance = 0;
		}
		local roll = this.Math.rand(1, 100);
		local ret = {
			Roll = roll,
			Chance = chance,
			Result = (roll <= chance)
		}
		return ret;
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

	function canBeSlept(_user, _actor)
	{
		if (_user.isAlliedWith(_actor))
		{
			return false;
		}
		if (_actor.getFlags().has("undead"))
		{
			return false;
		}
		return true;
	}

	function canBeSleptTile(_user, _targetTile)
	{
		if (_targetTile.IsOccupiedByActor)
		{
			local entity = _targetTile.getEntity();
			if (!entity.isNonCombatant())
			{
				if (this.canBeSlept(_user, entity))
				{
					return true;
				}
			}
		}
		return false;
	}

	function onDelayedEffect(_tag)
	{
		local targets = [];
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;

		if (this.canBeSleptTile(_user, _targetTile))
		{
			targets.push(_targetTile.getEntity());
		}

		for (local i = 0; i < 6; i++)
		{
			if (_targetTile.hasNextTile(i))
			{
				local nextTile = _targetTile.getNextTile(i);
				if (this.canBeSleptTile(_user, nextTile))
				{
					targets.push(nextTile.getEntity());
				}
			}
		}

		local myTile = _user.getTile();

		foreach( target in targets )
		{
			local ret = this.makeSleepCheck(target);
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " tries to put " + this.Const.UI.getColorizedEntityName(target) + " to sleep (Chance: " + ret.Chance + ", Rolled: " + ret.Roll +")");

			if (ret.Result)
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists the urge to sleep thanks to his resolve.");
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
