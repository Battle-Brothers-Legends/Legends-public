this.legend_chain_thresh_skill <- this.inherit("scripts/skills/skill", {
	m = {
		StunChance = 20
	},
	function create()
	{
		this.m.ID = "actives.legend_chain_thresh";
		this.m.Name = "Chain Thresh";
		this.m.Description = "Threshing all the targets around you, foe and friend alike, with a reckless round swing. Not hard to evade because it is not aimed at anything. Has a chance to daze targets hit for one turn. Be careful around your own men unless you want to relieve your payroll!";
		this.m.KilledString = "Threshed";
		this.m.Icon = "skills/active_46.png";
		this.m.IconDisabled = "skills/active_46_sw.png";
		this.m.Overlay = "active_46";
		this.m.SoundOnUse = [
			"sounds/combat/thresh_01.wav",
			"sounds/combat/thresh_02.wav",
			"sounds/combat/thresh_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/thresh_hit_01.wav",
			"sounds/combat/thresh_hit_02.wav",
			"sounds/combat/thresh_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAOE = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.HitChanceBonus = -15;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 35;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 10;
		this.m.ChanceSmash = 33;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local hitchanceBonus = this.m.HitChanceBonus;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
		{
			hitchanceBonus = hitchanceBonus + 5;
		}

		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]" + hitchanceBonus + "%[/color] chance to hit"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StunChance + "%[/color] chance to daze on a hit"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Can hit up to 6 targets"
			}
		]);
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInFlails ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local ret = false;
		local ownTile = this.m.Container.getActor().getTile();
		local soundBackup = [];
		this.spawnAttackEffect(ownTile, this.Const.Tactical.AttackEffectThresh);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!ownTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = ownTile.getNextTile(i);

				if (!tile.IsEmpty && tile.getEntity().isAttackable() && this.Math.abs(tile.Level - ownTile.Level) <= 1)
				{
					if (ret && soundBackup.len() == 0)
					{
						soundBackup = this.m.SoundOnHit;
						this.m.SoundOnHit = [];
					}

					local success = this.attackEntity(_user, tile.getEntity());
					ret = success || ret;

					if (_user.isAlive() && !_user.isDying())
					{
						if (success && tile.IsOccupiedByActor && this.Math.rand(1, 100) <= this.m.StunChance && !tile.getEntity().getCurrentProperties().IsImmuneToBleeding && !tile.getEntity().getSkills().hasSkill("effects.legend_grazed_effect"))
						{
							tile.getEntity().getSkills().add(this.new("scripts/skills/effects/legend_grazed_effect"));

							if (!_user.isHiddenToPlayer() && tile.IsVisibleForPlayer)
							{
								this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has grazed " + this.Const.UI.getColorizedEntityName(tile.getEntity()));
							}
						}
					}
				}
			}
		}

		if (ret && this.m.SoundOnHit.len() == 0)
		{
			this.m.SoundOnHit = soundBackup;
		}

		return ret;
	}

	function onTargetSelected( _targetTile )
	{
		local ownTile = this.m.Container.getActor().getTile();

		for( local i = 0; i != 6; i = ++i )
		{
			if (!ownTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = ownTile.getNextTile(i);

				if (!tile.IsEmpty && tile.getEntity().isAttackable() && this.Math.abs(tile.Level - ownTile.Level) <= 1)
				{
					this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, tile, tile.Pos.X, tile.Pos.Y);
				}
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
			{
				_properties.MeleeSkill -= 10;
			}
			else
			{
				_properties.MeleeSkill -= 15;
			}
		}
	}

});

