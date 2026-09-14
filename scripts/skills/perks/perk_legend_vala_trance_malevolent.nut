this.perk_legend_vala_trance_malevolent <- this.inherit("scripts/skills/skill", {
	m = {
		TranceIsActive = false,
		Failures = 0,
		Difficulty = 1.25
	},
	function resetTrance()
	{
		this.m.TranceIsActive = false;
		this.m.Failures = 0;
	}

	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendValaTranceMalevolent);
		this.m.Icon = "ui/perks/legend_vala_trance_malevolent_active.png";
		this.m.IconDisabled = "ui/perks/legend_vala_trance_malevolent_active_sw.png";
		this.m.Type = this.Const.SkillType.Active | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted + 11;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 30;
		this.m.MinRange = 2;
		this.m.MaxRange = 7;
		this.m.MaxLevelDifference = 4;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();

		if (!this.Tactical.isActive())
			return false;

		if (actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions()))
			return false;

		if (!this.skill.isUsable())
			return false;

		if (this.m.TranceIsActive)
			return false;

		if (actor.getSkills().hasEffect(::Legends.Effect.LegendValaCurrentlyChanting) || actor.getSkills().hasEffect(::Legends.Effect.LegendValaInTrance))
			return false;

		if (!::Legends.S.hasItemFlag(actor.getMainhandItem(), "vala_staff"))
			return false;

		return true;
	}

	function getCostString()
	{
		return "[i]Costs [b][color=%negative%]all (at least 6) AP[/color][/b] to use and builds up " + (this.isAffordableBasedOnFatiguePreview() ? "[b][color=%positive%]" + this.getFatigueCost() : "[b][color=%negative%]" + this.getFatigueCost()) + " Fatigue[/color][/b][/i]\n";
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "If the Vala is successful in her dealings with these harmful spirits, they will haunt and weaken her opponents. Lowers damage, lowers maximum fatigue, increases fatigue cost for skills."
		});

		if (!::Legends.S.hasItemFlag(actor.getMainhandItem(), "vala_staff"))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Requires the Vala\'s staff.[/color]"
			});
		}

		if (actor.getSkills().hasEffect(::Legends.Effect.LegendValaCurrentlyChanting))
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Cannot enter a trance while chanting.[/color]"
			});
		}

		if (this.Tactical.isActive() && actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions()))
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Cannot enter a trance while engaged in melee.[/color]"
			});
		}

		return ret;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local targets = this.Tactical.Entities.getAllInstances();

		if (actor.getSkills().hasEffect(::Legends.Effect.LegendValaInTrance) && this.m.TranceIsActive)
		{
			local TotalVictims = 0;

			foreach( tar in targets )
			{
				foreach( t in tar )
				{
					if (t.getFlags().get("IsSpiritVictim"))
					{
						TotalVictims = 1;
						break;
					}
				}
			}

			if (TotalVictims == 0)
			{
				::Legends.Effects.remove(actor, ::Legends.Effect.LegendValaInTrance);
				this.logInfo("MALEVOLENT SPIRITS :: onTurnStart victim is dead or dying");
				return;
			}

			local expertise = actor.getBravery() / this.m.Difficulty;
			expertise = expertise + this.m.Failures * 20.0 / this.m.Difficulty;

			foreach( tar in targets )
			{
				foreach( t in tar )
				{
					local distance = t.getTile().getDistanceTo(actor.getTile());

					if (distance <= 3 && t.isAlliedWith(actor))
					{
						switch(distance)
						{
						case 1:
							expertise = expertise + 2.0 / this.m.Difficulty;
							break;

						case 2:
							expertise = expertise + 1.0 / this.m.Difficulty;
							break;

						case 3:
							expertise = expertise + 0.5 / this.m.Difficulty;
							break;

						default:
							break;
						}
					}
				}
			}

			if (actor.getSkills().hasPerk(::Legends.Perk.LegendValaTranceMastery))
			{
				expertise = expertise + 15.0 / this.m.Difficulty;
			}

			local minimumHitChance = ::Legends.Mod.ModSettings.getSetting("MinimumChanceToHit").getValue();
			local maximumHitChance = ::Legends.Mod.ModSettings.getSetting("MaximumChanceToHit").getValue();
			expertise = this.Math.max(minimumHitChance, this.Math.min(maximumHitChance, expertise));

			this.logInfo("MALEVOLENT SPIRITS :: expertise is " + expertise);

			if (this.Math.rand(1, 100) <= expertise)
			{
				foreach( tar in targets )
				{
					foreach( t in tar )
					{
						if (!t.getSkills().hasEffect(::Legends.Effect.LegendValaTranceMalevolentEffect) && t.getFlags().get("IsSpiritVictim"))
						{
							::Legends.Effects.grant(t, ::Legends.Effect.LegendValaTranceMalevolentEffect, function(_effect) {
								_effect.setPower(this.getContainer().getActor().getBravery());
							}.bindenv(this));
							t.getFlags().set("IsSpiritVictim", false);
						}

						if (t.getSkills().hasEffect(::Legends.Effect.LegendValaTranceMalevolentEffect) && t.getFlags().get("IsSpiritVictim"))
						{
							::Legends.Effects.grant(t, ::Legends.Effect.LegendValaTranceMalevolentEffect, function(_effect) {
								_effect.setPower(this.getContainer().getActor().getBravery());
							}.bindenv(this));
							t.getFlags().set("IsSpiritVictim", false);
						}
					}
				}

				this.Sound.play("sounds/combat/legend_vala_malevolent.wav");
				::Legends.Effects.remove(actor, ::Legends.Effect.LegendValaInTrance);
			}
			else if (this.isAffordableBasedOnFatigue())
			{
				this.Sound.play("sounds/combat/legend_vala_trance.wav");
				this.m.TranceIsActive = true;
				++this.m.Failures;
				actor.m.ActionPoints = 0;
				actor.setFatigue(actor.getFatigue() + this.getFatigueCost());
			}
			else
			{
				::Legends.Effects.remove(actor, ::Legends.Effect.LegendValaInTrance);

				foreach( tar in targets )
				{
					foreach( t in tar )
					{
						if (t.getFlags().get("IsSpiritVictim"))
						{
							t.getFlags().set("IsSpiritVictim", false);
						}
					}
				}
			}
		}
	}

	function onCombatFinished()
	{
		local actor = this.getContainer().getActor();

		if (actor.getSkills().hasEffect(::Legends.Effect.LegendValaInTrance))
		{
			::Legends.Effects.remove(actor, ::Legends.Effect.LegendValaInTrance);
		}

		this.resetTrance();
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (actor.getSkills().hasPerk(::Legends.Perk.LegendValaTranceMastery))
		{
			this.m.FatigueCostMult = 0.75;
		}
		else
		{
			this.m.FatigueCostMult = 1.0;
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		local actor = this.getContainer().getActor();
		local targets = this.Tactical.Entities.getAllInstances();

		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID())
		{
			return;
		}

		if (actor.getSkills().hasEffect(::Legends.Effect.LegendValaInTrance))
		{
			if (actor.getSkills().hasPerk(::Legends.Perk.LegendValaTranceMastery))
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					::Legends.Effects.remove(actor, ::Legends.Effect.LegendValaInTrance);

					foreach( tar in targets )
					{
						foreach( t in tar )
						{
							if (t.getFlags().get("IsSpiritVictim"))
							{
								t.getFlags().set("IsSpiritVictim", false);
							}
						}
					}
				}
			}
			else
			{
				::Legends.Effects.remove(actor, ::Legends.Effect.LegendValaInTrance);

				foreach( tar in targets )
				{
					foreach( t in tar )
					{
						if (t.getFlags().get("IsSpiritVictim"))
						{
							t.getFlags().set("IsSpiritVictim", false);
						}
					}
				}
			}
		}
	}

	function onDeath( _fatalityType )
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
			return;

		local actor = this.getContainer().getActor();
		local targets = this.Tactical.Entities.getAllInstances();

		foreach( tar in targets )
		{
			foreach( t in tar )
			{
				if (t.getSkills().hasEffect(::Legends.Effect.LegendValaTranceMalevolentEffect))
				{
					::Legends.Effects.remove(t, ::Legends.Effect.LegendValaTranceMalevolentEffect);
				}

				if (t.getFlags().get("IsSpiritVictim"))
				{
					t.getFlags().set("IsSpiritVictim", false);
				}
			}
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsOccupiedByActor)
		{
			return false;
		}

		if (!_targetTile.getEntity().isAlive() || _targetTile.getEntity().isDying())
		{
			return false;
		}

		if (_targetTile.IsEmpty)
		{
			return false;
		}

		if (_targetTile.getEntity().isAlliedWith(this.getContainer().getActor()))
		{
			return false;
		}

		return this.skill.onVerifyTarget(_originTile, _targetTile);
	}

	function onUse( _user, _targetTile )
	{
		if (this.isUsable())
		{
			local actor = this.getContainer().getActor();

			if (!actor.getSkills().hasEffect(::Legends.Effect.LegendValaInTrance))
			{
				::Legends.Effects.grant(actor, ::Legends.Effect.LegendValaInTrance);
			}

			_targetTile.getEntity().getFlags().set("IsSpiritVictim", true);
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " trembles and hums as they drift into a trance.");
			this.Sound.play("sounds/combat/legend_vala_trance.wav");
			actor.m.ActionPoints = 0;
			this.m.TranceIsActive = true;
		}
	}

});

