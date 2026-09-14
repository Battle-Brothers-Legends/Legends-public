this.perk_legend_vala_trance_perspective <- this.inherit("scripts/skills/skill", {
	m = {
		TranceIsActive = false,
		Failures = 0,
		Difficulty = 1.0
	},
	function resetTrance()
	{
		this.m.TranceIsActive = false;
		this.m.Failures = 0;
	}
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendValaTrancePerspective);
		this.m.Icon = "ui/perks/legend_vala_trance_perspective_active.png";
		this.m.IconDisabled = "ui/perks/legend_vala_trance_perspective_active_sw.png";
		this.m.Type = this.Const.SkillType.Active | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 11;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
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
			text = "Enter a trance and bla bla bla."
		});

		if (!::Legends.S.hasItemFlag(actor.getMainhandItem(), "vala_staff"))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Requires the Vala's staff.[/color]"
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

		if (actor.getSkills().hasEffect(::Legends.Effect.LegendValaInTrance) && this.m.TranceIsActive)
		{
			local expertise = actor.getBravery() / this.m.Difficulty;
			expertise += this.m.Failures * 20.0 / this.m.Difficulty;

			local everyone = this.Tactical.Entities.getAllInstances();
			foreach (ever in everyone)
			{
				foreach (e in ever)
				{
					local distance = e.getTile().getDistanceTo(actor.getTile());

					if (distance <= 3 && t.isAlliedWith(actor))
					{
						switch (distance)
						{
							case 1:
								expertise += 2.0 / this.m.Difficulty;
								break;

							case 2:
								expertise += 1.0 / this.m.Difficulty;
								break;

							case 3:
								expertise += 0.5 / this.m.Difficulty;
								break;

							default:
								break
						}
					}
				}
			}

			if (actor.getSkills().hasPerk(::Legends.Perk.LegendValaTranceMastery))
			{
				expertise += 15.0 / this.m.Difficulty;

			}

			local minimumHitChance = ::Legends.Mod.ModSettings.getSetting("MinimumChanceToHit").getValue();
			local maximumHitChance = ::Legends.Mod.ModSettings.getSetting("MaximumChanceToHit").getValue();
			expertise = this.Math.max(minimumHitChance, this.Math.min(maximumHitChance, expertise));

			this.logInfo("INCORPOREAL PERSPECTIVE :: expertise is " + expertise);

			if (this.Math.rand(1, 100) <= expertise)  // TRANCE SUCCESS
			{
				expertise += 10.0;

				local targets = this.Tactical.Entities.getAllInstances();
				foreach (tar in targets)
				{
					foreach (t in tar)
					{
						if (!t.isAlliedWith(actor))
						{
							if (this.Math.rand(1, 100) <= expertise)  // APPLICATION SUCCESS
							{
								::Legends.Effects.grant(t, ::Legends.Effect.LegendValaTrancePerspectiveEffect, function(_effect) {
									_effect.setVala(this);
								}.bindenv(this));
							}
						}
					}
				}

				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " returns to this realm.");
//				this.Sound.play("sounds/combat/legend_vala_perspective.wav");
				::Legends.Effects.remove(actor, ::Legends.Effect.LegendValaInTrance);
			}
			else  // TRANCE FAILURE
			{
				if (this.isAffordableBasedOnFatigue())  //  STAY IN TRANCE AND GAIN A STACKING BONUS SUCCESS CHANCE FOR NEXT TURN
				{
					this.Sound.play("sounds/combat/legend_vala_trance.wav");
					this.m.TranceIsActive = true;
					++this.m.Failures;
					actor.m.ActionPoints = 0;
					actor.setFatigue(actor.getFatigue() + this.getFatigueCost());
				}
				else  //  CANCEL TRANCE BECAUSE OF FATIGUE
				{
					::Legends.Effects.remove(actor, ::Legends.Effect.LegendValaInTrance);
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

		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID())
		{
			return;
		}

		if (actor.getSkills().hasEffect(::Legends.Effect.LegendValaInTrance))
		{
			if (actor.getSkills().hasPerk(::Legends.Perk.LegendValaTranceMastery))
			{
				if (this.Math.rand(1, 100) <= 50)  //  MASTERY GRANTS A 50% CHANCE TO AVOID DROPPING OUT OF TRANCE
				{
					::Legends.Effects.remove(actor, ::Legends.Effect.LegendValaInTrance);
				}
			}
			else
			{
				::Legends.Effects.remove(actor, ::Legends.Effect.LegendValaInTrance);
			}
		}
	}


	function onDeath( _fatalityType )
	{
		local actor =  this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
			return;

		local actor = this.getContainer().getActor();
		local targets = this.Tactical.Entities.getAllInstances();

		foreach (tar in targets)
		{
			foreach (t in tar)
			{
				if (t.getSkills().hasEffect(::Legends.Effect.LegendValaTrancePerspectiveEffect))
				{
					::Legends.Effects.remove(t, ::Legends.Effect.LegendValaTrancePerspectiveEffect);
				}
			}
		}
	}


	function onUse(_user, _targetTile)
	{
		if (this.isUsable())
		{
			local actor = this.getContainer().getActor();

			if (!actor.getSkills().hasEffect(::Legends.Effect.LegendValaInTrance))
			{
				::Legends.Effects.grant(actor, ::Legends.Effect.LegendValaInTrance);
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " trembles and hums as they drift into a trance.");
			this.Sound.play("sounds/combat/legend_vala_trance.wav");
			actor.m.ActionPoints = 0;
			this.m.TranceIsActive = true;
		}
	}
});
