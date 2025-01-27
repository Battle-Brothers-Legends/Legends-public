this.legend_wake_ally_aoe_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.WakeAllyAoe);
		this.m.Description = "Forcibly wake all adjacent allies from unnatural sleep.";
		this.m.Icon = "skills/active_118.png";
		this.m.IconDisabled = "skills/active_118_sw.png";
		this.m.Overlay = "active_118";
		this.m.SoundOnHit = [
			"sounds/enemies/dlc2/wake_up_01.wav",
			"sounds/enemies/dlc2/wake_up_02.wav",
			"sounds/enemies/dlc2/wake_up_03.wav",
			"sounds/enemies/dlc2/wake_up_04.wav",
			"sounds/enemies/dlc2/wake_up_05.wav",
			"sounds/enemies/dlc2/wake_up_06.wav"
		];
		this.m.SoundVolume = 0.9;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.IsHidden = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Removes the Sleeping and Nightmares status effects"
			}
		];
		return ret;
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();

		if (this.Tactical.isActive() && actor.isPlacedOnMap())
		{
			local hasTarget = false;
			local myTile = actor.getTile();

			for( local i = 0; i < 6; i = ++i )
			{
				if (!myTile.hasNextTile(i))
				{
				}
				else
				{
					local tile = myTile.getNextTile(i);

					if (this.Math.abs(tile.Level - myTile.Level) <= 1 && tile.IsOccupiedByActor && actor.isAlliedWith(tile.getEntity()) && (tile.getEntity().getSkills().hasEffect(::Legends.Effect.Sleeping) || tile.getEntity().getSkills().hasEffect(::Legends.Effect.Nightmare)))
					{
						hasTarget = true;
						break;
					}
				}
			}

			if (hasTarget)
			{
				return false;
			}
		}

		return this.skill.isHidden();
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (!this.m.Container.getActor().isAlliedWith(target))
		{
			return false;
		}

		if (target.getSkills().hasEffect(::Legends.Effect.Sleeping) || target.getSkills().hasEffect(::Legends.Effect.Nightmare))
		{
			return true;
		}

		return false;
	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local human = false;

		for( local i = 0; i < 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = myTile.getNextTile(i);

				if (!tile.IsOccupiedByActor || !this.onVerifyTarget(myTile, tile))
				{
				}
				else
				{
					local target = tile.getEntity();
					this.spawnIcon("status_effect_83", tile);
					::Legends.Effects.remove(target, ::Legends.Effect.Sleeping);
					::Legends.Effects.remove(target, ::Legends.Effect.Nightmare);
					target.setDirty(true);

					if (this.isKindOf(target, "human"))
					{
						human = true;
					}
				}
			}
		}

		if (human && this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill * this.m.SoundVolume, _user.getPos());
		}

		return true;
	}

});

