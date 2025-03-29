this.legend_nightmare_aoe_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendNightmareAoe);
		this.m.Description = "";
		this.m.Icon = "skills/active_117.png";
		this.m.IconDisabled = "skills/active_117_sw.png";
		this.m.Overlay = "active_117";
		this.m.SoundOnUse = [
			"sounds/enemies/horror_spell_01.wav",
			"sounds/enemies/horror_spell_02.wav",
			"sounds/enemies/horror_spell_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
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
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 12;
		this.m.MaxLevelDifference = 4;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}

		local actor = this.getContainer().getActor();
		local opponents = actor.getAIAgent().getKnownOpponents();
		local nightmares = 0;

		foreach( o in opponents )
		{
			if (o.Actor.getSkills().hasEffect(::Legends.Effect.Nightmare))
			{
				nightmares = ++nightmares;
			}
		}

		if (opponents.len() > 1 && opponents.len() - nightmares <= 1)
		{
			return false;
		}

		return true;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().isAlliedWith(this.getContainer().getActor()))
		{
			return false;
		}

		local sleeping = ::Legends.Effects.get(_targetTile.getEntity(), ::Legends.Effect.Sleeping);

		if (sleeping == null || sleeping.getTurnApplied() == this.Time.getRound())
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local targets = [];
		local stacks = 0;

		if (_targetTile.IsOccupiedByActor)
		{
			local entity = _targetTile.getEntity();

			if (this.onVerifyTarget(myTile, _targetTile))
			{
				targets.push(entity);
			}
		}

		for( local i = 0; i < 6; i = ++i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local adjacent = _targetTile.getNextTile(i);

				if (adjacent.IsOccupiedByActor)
				{
					local entity = adjacent.getEntity();

					if (this.onVerifyTarget(myTile, adjacent))
					{
						targets.push(entity);
					}
				}
			}
		}

		foreach( target in targets )
		{
			target.checkMorale(-1, -25, this.Const.MoraleCheckType.MentalAttack);
			stacks = ++stacks;
			::Legends.Effects.remove(target, ::Legends.Effect.Sleeping);
			::Legends.Effects.grant(target, ::Legends.Effect.Nightmare);

			if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " enters a world of nightmares");
			}
		}

		if ("addStacks" in _user)
		{
			_user.addStacks(stacks * 5);
		}
		return true;
	}

});

