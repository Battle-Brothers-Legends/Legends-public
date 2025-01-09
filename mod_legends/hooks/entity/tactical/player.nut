::mods_hookExactClass("entity/tactical/player", function(o)
{
	// HiringCost is serialized using Float 32 on 7/5/23 by Luft
	o.m.IsCommander <- false;
	o.m.LifetimeStats.Tags <- null;
	o.m.Formations <- null;
	o.m.VeteranPerks <- 4;
	o.m.CampAssignment <- "camp.rest";
	o.m.LastCampAssignment <- "camp.rest";
	o.m.CampHealing <- 0;
	o.m.LastCampTime <- 0;
	o.m.InReserves <- false;
	o.m.StarWeights <- [50,50,50,50,50,50,50,50];
	// o.m.Alignment <- null,
	o.m.CompanyID <- 0;

	o.getTryoutCost = function ()
	{
		return this.Math.ceil(this.Math.max(10, this.Math.min(this.m.HiringCost - 25, 25 + this.m.HiringCost * this.Const.Tryouts.CostMult) * this.World.Assets.m.TryoutPriceMult));
	}

	o.getDailyCost = function ()
	{
		if (!("State" in this.World)) {
			return 0
		}
		local wageMult = (this.m.CurrentProperties.DailyWageMult * (this.World.State != null ? this.World.Assets.getDailyWageMult() : 1.0)) - (this.World.State != null ? this.World.State.getPlayer().getWageModifier() : 0.0);
		//local costAdj = this.Math.max(0, this.m.CurrentProperties.DailyWageMult * barterMult);
		return this.Math.max(0, this.m.CurrentProperties.DailyWage * wageMult);
	}

	o.getDailyFood = function ()
	{
		local food = this.Math.maxf(0.0, this.m.CurrentProperties.DailyFood);
		if (this.isInReserves() && !this.m.Skills.hasPerk(::Legends.Perk.LegendPeaceful))
		{
			food *= 2;
		}
		food -= this.World.State.getPlayer().getFoodModifier();
		return food;
	}

	o.setCommander <- function ( _f )
	{
		this.m.IsCommander = _f;
	}

	o.setVeteranPerks <- function ( _f )
	{
		this.m.VeteranPerks = _f;
	}

	o.getVeteranPerks <- function ()
	{
		return this.m.VeteranPerks;
	}

	o.isCommander <- function ()
	{
		return this.m.IsCommander;
	}

	o.getCampAssignment <- function ()
	{
		return this.m.CampAssignment;
	}

	o.setCampAssignment <- function ( _id )
	{
		this.m.CampAssignment = _id;
	}

	o.getLastCampAssignment <- function ()
	{
		return this.m.LastCampAssignment;
	}

	o.setLastCampAssignment <- function ( _id )
	{
		this.m.LastCampAssignment = _id;
	}

	o.getHiringTraits = function ()
	{
		local ret = [];

		if (!this.m.IsTryoutDone) return ret;

		foreach( s in this.m.Skills.m.Skills )
		{
			if (s.getType() != ::Const.SkillType.Trait) continue;
			if (s.isHidden()) continue;

			ret.push({
				id = s.getID(),
				icon = s.getIconColored()
			});
		}

		return ret;
	}

	o.getHiringTalents <- function ()
	{
		local ret = [];

		if (!this.m.IsTryoutDone)
		{
			return ret;
		}

		local talents = this.getTalents();

		for( local i = 0; i < this.Const.Attributes.COUNT; i = ++i )
		{
			if (talents[i] > 0)
			{
				local r = {
					talent = "",
					value = talents[i]
				};

				switch(i)
				{
				case 0:
					r.talent = "HP";
					break;

				case 1:
					r.talent = "RES";
					break;

				case 2:
					r.talent = "FAT";
					break;

				case 3:
					r.talent = "INIT";
					break;

				case 4:
					r.talent = "MA";
					break;

				case 5:
					r.talent = "RA";
					break;

				case 6:
					r.talent = "MD";
					break;

				case 7:
					r.talent = "RD";
					break;
				}

				ret.push(r);
			}

		}

		return ret;
	}

	o.getTooltip = function ( _targetedWithSkill = null )
	{
		if (!this.isPlacedOnMap() || !this.isAlive() || this.isDying())
		{
			return [];
		}

		local turnsToGo = this.Tactical.TurnSequenceBar.getTurnsUntilActive(this.getID());
		local tooltip = [
			{
				id = 1,
				type = "title",
				text = this.getName(),
				icon = "ui/tooltips/height_" + this.getTile().Level + ".png"
			}
		];

		if (_targetedWithSkill != null && this.isKindOf(_targetedWithSkill, "skill"))
		{
			local tile = this.getTile();

			if (tile.IsVisibleForEntity && _targetedWithSkill.isUsableOn(this.getTile()))
			{
				tooltip.push({
					id = 3,
					type = "headerText",
					icon = "ui/icons/hitchance.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + _targetedWithSkill.getHitchance(this) + "%[/color] chance to hit",
					children = _targetedWithSkill.getHitFactors(tile)
				});
			}
		}

		tooltip.extend([
			{
				id = 2,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = this.Tactical.TurnSequenceBar.getActiveEntity() == this ? "Acting right now!" : this.m.IsTurnDone || turnsToGo == null ? "Turn done" : "Acts in " + turnsToGo + (turnsToGo > 1 ? " turns" : " turn")
			},
			{
				id = 3,
				type = "progressbar",
				icon = "ui/icons/armor_head.png",
				value = this.getArmor(this.Const.BodyPart.Head),
				valueMax = this.getArmorMax(this.Const.BodyPart.Head),
				text = "" + this.getArmor(this.Const.BodyPart.Head) + " / " + this.getArmorMax(this.Const.BodyPart.Head) + "",
				style = "armor-head-slim"
			},
			{
				id = 4,
				type = "progressbar",
				icon = "ui/icons/armor_body.png",
				value = this.getArmor(this.Const.BodyPart.Body),
				valueMax = this.getArmorMax(this.Const.BodyPart.Body),
				text = "" + this.getArmor(this.Const.BodyPart.Body) + " / " + this.getArmorMax(this.Const.BodyPart.Body) + "",
				style = "armor-body-slim"
			},
			{
				id = 5,
				type = "progressbar",
				icon = "ui/icons/health.png",
				value = this.getHitpoints(),
				valueMax = this.getHitpointsMax(),
				text = "" + this.getHitpoints() + " / " + this.getHitpointsMax() + "",
				style = "hitpoints-slim"
			},
			{
				id = 6,
				type = "progressbar",
				icon = "ui/icons/morale.png",
				value = this.getMoraleState(),
				valueMax = this.Const.MoraleState.COUNT - 1,
				text = this.Const.MoraleStateName[this.getMoraleState()],
				style = "morale-slim"
			},
			{
				id = 7,
				type = "progressbar",
				icon = "ui/icons/fatigue.png",
				value = this.getFatigue(),
				valueMax = this.getFatigueMax(),
				text = "" + this.getFatigue() + " / " + this.getFatigueMax() + "",
				style = "fatigue-slim"
			}
		]);
		local result = [];
		local statusEffects = this.getSkills().query(this.Const.SkillType.StatusEffect | this.Const.SkillType.TemporaryInjury, false, true);

		foreach( i, statusEffect in statusEffects )
		{
			tooltip.push({
				id = 100 + i,
				type = "text",
				icon = statusEffect.getIcon(),
				text = statusEffect.getName()
			});
		}

		return tooltip;
	}

	o.getRosterTooltip = function ()
	{
		local tooltip = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			}
		];
		local time = this.getDaysWithCompany();
		local text;

		if (!this.isGuest())
		{
			if (::Legends.Mod.ModSettings.getSetting("ShowCharacterBackgroundType").getValue())
			{
				tooltip.push({
					id = 2,
					type = "description",
					text = this.m.Background.getBackgroundTypes() + "\n\n"
				});
			}

			if (this.m.Background != null && this.m.Background.getID() == "background.companion")
			{
				text = "With the company from the very beginning.";
			}
			else if (time > 1)
			{
				text = "With the company for " + time + " days.";
			}
			else
			{
				text = "Has just joined the company.";
			}

			if (this.m.LifetimeStats.Battles != 0)
			{
				if (this.m.LifetimeStats.Battles == 1)
				{
					text = text + (" Took part in " + this.m.LifetimeStats.Battles + " battle");
				}
				else
				{
					text = text + (" Took part in " + this.m.LifetimeStats.Battles + " battles");
				}

				if (this.m.LifetimeStats.Kills == 1)
				{
					text = text + (" and has " + this.m.LifetimeStats.Kills + " kill.");
				}
				else if (this.m.LifetimeStats.Kills > 1)
				{
					text = text + (" and has " + this.m.LifetimeStats.Kills + " kills.");
				}
				else
				{
					text = text + ".";
				}

				if (this.m.LifetimeStats.MostPowerfulVanquished != "")
				{
					local vanquishedText = "{" + (" The most powerful opponent %they% vanquished was " + this.m.LifetimeStats.MostPowerfulVanquished + ".") + "}";
					local vars = [];
					this.Const.LegendMod.extendVarsWithPronouns(vars, this.getGender());
					vanquishedText = this.buildTextFromTemplate(vanquishedText, vars);
					text = text + vanquishedText;
				}
			}

			tooltip.push({
				id = 2,
				type = "description",
				text = text
			});
			tooltip.push({
				id = 5,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "Level " + this.m.Level
			});

			if (this.getDailyCost() != 0)
			{
				tooltip.push({
					id = 3,
					type = "text",
					icon = "ui/icons/asset_daily_money.png",
					text = "Paid [img]gfx/ui/tooltips/money.png[/img]" + this.getDailyCost() + " daily"
				});
			}

			tooltip.push({
				id = 4,
				type = "text",
				icon = this.Const.MoodStateIcon[this.getMoodState()],
				text = this.Const.MoodStateName[this.getMoodState()]
			});

			if (!this.isInReserves())
			{
				tooltip.push({
					id = 6,
					type = "hint",
					icon = "ui/icons/stat_screen_dmg_dealt.png",
					text = "In the fighting line"
				});
			}
			else
			{
				tooltip.push({
					id = 6,
					type = "hint",
					icon = "ui/icons/camp.png",
					text = "In reserve"
				});
			}

			tooltip.extend(this.getBackground().getBackgroundDescriptionTooltip(false));
		}

		local injuries = this.getSkills().query(this.Const.SkillType.Injury | this.Const.SkillType.SemiInjury);

		foreach( injury in injuries )
		{
			if (injury.isType(this.Const.SkillType.TemporaryInjury))
			{
				local ht = injury.getHealingTime();

				if (ht.Min != ht.Max)
				{
					tooltip.push({
						id = 90,
						type = "text",
						icon = injury.getIcon(),
						text = injury.getName() + " (" + ht.Min + "-" + ht.Max + " days)"
					});
				}
				else if (ht.Min > 1)
				{
					tooltip.push({
						id = 90,
						type = "text",
						icon = injury.getIcon(),
						text = injury.getName() + " (" + ht.Min + " days)"
					});
				}
				else
				{
					tooltip.push({
						id = 90,
						type = "text",
						icon = injury.getIcon(),
						text = injury.getName() + " (" + ht.Min + " day)"
					});
				}
			}
			else
			{
				tooltip.push({
					id = 90,
					type = "text",
					icon = injury.getIcon(),
					text = injury.getName()
				});
			}
		}

		if (this.getHitpoints() < this.getHitpointsMax())
		{
			local ht = this.Math.ceil((this.getHitpointsMax() - this.getHitpoints()) / (this.Const.World.Assets.HitpointsPerHour * (("State" in this.World) && this.World.State != null ? this.World.Assets.m.HitpointsPerHourMult : 1.0)) / 24.0);

			if (ht > 1)
			{
				tooltip.push({
					id = 133,
					type = "text",
					icon = "ui/icons/days_wounded.png",
					text = "Light Wounds (" + ht + " days)"
				});
			}
			else
			{
				tooltip.push({
					id = 133,
					type = "text",
					icon = "ui/icons/days_wounded.png",
					text = "Light Wounds (" + ht + " day)"
				});
			}
		}

		return tooltip;
	}

	o.isInReserves <- function ()
	{
		return this.m.InReserves;
	}

	o.setInReserves <- function ( _v )
	{
		this.m.InReserves = _v;
	}

	o.isStabled <- function ()
	{
		if (this.getBackground() == null)
		{
			return false;
		}

		return this.getBackground().isBackgroundType(this.Const.BackgroundType.Stabled);
	}

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Formations = this.new("scripts/entity/tactical/formations_container");
		this.m.LifetimeStats.Tags = this.new("scripts/tools/tag_collection")
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.m.Skills.add(this.new("scripts/skills/effects/legend_realm_of_nightmares_effect"));
		this.m.Skills.add(this.new("scripts/skills/special/legend_horserider_skill"));
		this.m.Skills.add(this.new("scripts/skills/effects/legend_veteran_levels_effect"));
	}

	local onHired = o.onHired;
	o.onHired = function()
	{
		// this.m.CompanyID = this.World.State.addNewID(this);

		onHired();

		if (!isStabled() && getSkills().hasSkill("trait.legend_intensive_training_trait") && getLevel() > 1 ) {
			local inTraining = getSkills().getSkillByID("trait.legend_intensive_training_trait");
			local addSkills = ::Math.rand(0, getLevel()+2);
			addSkills = ::Math.min(addSkills, inTraining.getMaxSkillsCanBeAdded() - 1);
			inTraining.addRandomSkills(this, addSkills);
		}

		::World.Assets.getOrigin().onHiredByScenario(this);

		if (::World.State.getBrothersInFrontline() > ::World.Assets.getBrothersMaxInCombat())
			setInReserves(true);

		if (::World.State.getPlayer() != null)
			::World.State.getPlayer().calculateModifiers();
	}

	local isReallyKilled = o.isReallyKilled;
	o.isReallyKilled = function ( _fatalityType )
	{
		if (this.getBackground() == null)
			return true;

		local shouldNotGet = [], original = [];
		original.extend(::Const.Injury.Permanent); // save the original

		foreach (index, injury in ::Const.Injury.Permanent)
		{
			if (::Const.Injury.PermaInjuryToProsthetic.rawin(injury.ID) && getSkills().hasSkill(::Const.Injury.PermaInjuryToProsthetic[injury.ID]))
				shouldNotGet.push(index);
		}

		for (local i = shouldNotGet.len() - 1; i >= 0; --i)
		{
		    ::Const.Injury.Permanent.remove(i);
		}

		if (!this.getSkills().hasSkill("injury.legend_burned_injury")) {
			foreach (burn in ::Const.Injury.Burning)
			{
				if (this.getSkills().hasSkill(burn.ID)) {
					::Const.Injury.Permanent.push({
						ID = "injury.legend_burned_injury",
						Script = "injury_permanent/legend_burned_injury",
						Threshold = 0.5,
					});
					break
				}
			}
		}
		// call the original
		local result = isReallyKilled(_fatalityType);
		// return this array back to normal
		::Const.Injury.Permanent = original;

		if (this.getCurrentProperties().SurvivesAsUndead // i'm back as undead baby
			&& !this.isStabled() // isn't donkey
			&& !this.getFlags().has("undead") // isn't undead already
			&& !::Tactical.State.isScenarioMode() // not real run
			&& !::Tactical.State.isAutoRetreat() // left behind
			&& !this.isGuest() // not player
		) {
			this.getFlags().add("undead");
			this.getFlags().add("zombie_minion");
			this.getFlags().add("PlayerZombie");
			this.improveMood(1.0, "Reborned to live again");
			this.setMoraleState(::Const.MoraleState.Ignore);
			this.getSkills().add(::new("scripts/skills/traits/legend_rotten_flesh_trait"));

			::Legends.Perks.grant(this, ::Legends.Perk.LegendZombieBite, function (perk) {
				perk.IsRefundable = false;
			});

			local has9L = this.getSkills().hasPerk(::Legends.Perk.NineLives);
			::Legends.Perks.grant(this, ::Legends.Perk.NineLives, function (perk) {
				if (has9L && perk.IsRefundable) {
					this.m.PerkPoints += 1;
					this.m.PerkPointsSpent -= 1;
				}
				perk.IsRefundable = false;
			});

			if (result) {
				this.m.IsDying = false;
				::updateAchievement("ScarsForLife", 1, 1);
				::Tactical.getSurvivorRoster().add(this);
			}

			return false;
		}

		return result;
	}

	o.finalizeFallen <- function(_fallen)
	{
		_fallen.level <- this.getLevel();
		_fallen.traits <- this.getDeadTraits();
		_fallen.talents <- this.getTalents();
		_fallen.stats <- [
			this.getBaseProperties().Hitpoints,
			this.getBaseProperties().Stamina,
			this.getBaseProperties().Bravery,
			this.getBaseProperties().Initiative,
			this.getBaseProperties().MeleeSkill,
			this.getBaseProperties().RangedSkill,
			this.getBaseProperties().MeleeDefense,
			this.getBaseProperties().RangedDefense
		];
		return _fallen;
	}

	local onDeath = o.onDeath;
	o.onDeath = function ( _killer, _skill, _tile, _fatalityType )
	{
		local bro = this;
		local originalAddFallen = ::World.Statistics.addFallen;
		::World.Statistics.addFallen = function (_fallen) {
			originalAddFallen(bro.finalizeFallen(_fallen));
		}
		onDeath(_killer, _skill, _tile, _fatalityType);
		::World.Statistics.addFallen = originalAddFallen;
	}

	local onActorKilled = o.onActorKilled;
	o.onActorKilled = function ( _actor, _tile, _skill )
	{
		onActorKilled( _actor, _tile, _skill );
		local XPgroup = _actor.getXPValue() * (1.0 - this.Const.XP.XPForKillerPct);
		local brothers = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			if (bro.isInReserves() && bro.getSkills().hasPerk(::Legends.Perk.LegendPacifist))
			{
				bro.addXP(this.Math.max(1, this.Math.floor(XPgroup / brothers.len())));
			}
		}
	}

	o.checkMorale = function ( _change, _difficulty, _type = this.Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		if (_change > 0 && this.m.MoraleState == this.Const.MoraleState.Steady && this.m.Skills.hasSkill("trait.insecure"))
		{
			return false;
		}

		if (_change > 0 && this.m.MoraleState == this.Const.MoraleState.Steady && ("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin().getID() == "scenario.anatomists")
		{
			return false;
		}

		if (_change < 0 && this.m.MoraleState == this.Const.MoraleState.Breaking && this.m.Skills.hasSkill("effects.ancient_priest_potion"))
		{
			return false;
		}

		if (_change < 0 && this.m.MoraleState == this.Const.MoraleState.Breaking && this.m.Skills.hasSkill("trait.oath_of_valor"))
		{
			return false;
		}

		if (_change > 0 && this.m.Skills.hasSkill("trait.optimist"))
		{
			_difficulty = _difficulty + 5;
		}
		else if (_change < 0 && this.m.Skills.hasSkill("trait.pessimist"))
		{
			_difficulty = _difficulty - 5;
		}
		else if (this.m.Skills.hasSkill("trait.legend_haunted_01"))
		{
			_difficulty = _difficulty + (this.Math.rand(0, 1) == 0 ? 6 : -6);
		}
		else if (this.m.Skills.hasSkill("trait.irrational"))
		{
			_difficulty = _difficulty + (this.Math.rand(0, 1) == 0 ? 10 : -10);
		}
		else if (this.m.Skills.hasSkill("trait.mad"))
		{
			_difficulty = _difficulty + (this.Math.rand(0, 1) == 0 ? 15 : -15);
		}
		if (_change < 0 && _type == this.Const.MoraleCheckType.MentalAttack && this.m.Skills.hasSkill("trait.legend_haunted_02"))
		{
			_difficulty = _difficulty - 6;
		}
		if (_change < 0 && _type == this.Const.MoraleCheckType.MentalAttack && this.m.Skills.hasSkill("trait.superstitious"))
		{
			_difficulty = _difficulty - 10;
		}

		return this.actor.checkMorale(_change, _difficulty, _type, _showIconBeforeMoraleIcon, _noNewLine);
	}

	// hooked only for the comments, seems to be entirely legends changes
	// o.addXP = function ( _xp, _scale = true )
	// {
	// 	local isScenarioMode = !(("State" in this.World) && this.World.State != null);

	// 	if (this.m.Level >= this.Const.LevelXP.len() || this.isGuest() || !isScenarioMode && this.World.Assets.getOrigin().getID() == "scenario.manhunters" && this.m.Level >= 7 && this.getBackground().getID() == "background.slave")
	// 	{
	// 		return;
	// 	}

	// 	if (_scale)
	// 	{
	// 		_xp = _xp * this.Const.Combat.GlobalXPMult;
	// 	}

	// 	if (_scale && !isScenarioMode)
	// 	{
	// 		_xp = _xp * this.Const.Difficulty.XPMult[this.World.Assets.getDifficulty()];
	// 	}

	// 	if (this.m.Level >= 11)
	// 	{
	// 		_xp = _xp * this.Const.Combat.GlobalXPVeteranLevelMult;
	// 	}

	// 	// if (this.getFlags().has("PlayerSkeleton")) //Disabled 27/1/23 - these are overiding the xp modifiers elsewhere including submods. therefore I have disabled them here so they may be changed in traits, events, etc. as all other stat varibles are for these types of units. - Luft
	// 	// {
	// 	// 	_xp = _xp * 0.33;
	// 	// }

	// 	// if (this.getFlags().has("PlayerZombie")) //Disabled 27/1/23 - these are overiding the xp modifiers elsewhere including submods. therefore I have disabled them here so they may be changed in traits, events, etc. as all other stat varibles are for these types of units. - Luft
	// 	// {
	// 	// 	_xp = _xp * 0.25;
	// 	// }

	// 	if (!isScenarioMode)
	// 	{
	// 		if (_scale)
	// 		{
	// 			_xp = _xp * this.World.Assets.m.XPMult;

	// 			if (this.World.Retinue.hasFollower("follower.drill_sergeant"))
	// 			{
	// 				_xp = _xp * this.Math.maxf(1.0, 1.2 - 0.02 * (this.m.Level - 1));
	// 			}
	// 		}

	// 		if (this.World.getPlayerRoster().getSize() < 3)
	// 		{
	// 			_xp = _xp * (1.0 - (3 - this.World.getPlayerRoster().getSize()) * 0.15);
	// 		}
	// 	}

	// 	//	if (("State" in this.World) && this.World.State != null && this.World.getPlayerRoster().getSize() < 3)
	// 	//	{
	// 	//		_xp = _xp * (1.0 - (3 - this.World.getPlayerRoster().getSize()) * 0.15);
	// 	//	}

	// 	if (this.m.XP + _xp * this.m.CurrentProperties.XPGainMult >= this.Const.LevelXP[this.Const.LevelXP.len() - 1])
	// 	{
	// 		this.m.CombatStats.XPGained += this.Const.LevelXP[this.Const.LevelXP.len() - 1] - this.m.XP;
	// 		this.m.XP = this.Const.LevelXP[this.Const.LevelXP.len() - 1];
	// 		return;
	// 	}
	// 	else if (!isScenarioMode && this.World.Assets.getOrigin().getID() == "scenario.manhunters" && this.m.XP + _xp * this.m.CurrentProperties.XPGainMult >= this.Const.LevelXP[6] && this.getBackground().getID() == "background.slave")
	// 	{
	// 		this.m.CombatStats.XPGained += this.Const.LevelXP[6] - this.m.XP;
	// 		this.m.XP = this.Const.LevelXP[6];
	// 		return;
	// 	}

	// 	this.m.XP += this.Math.floor(_xp * this.m.CurrentProperties.XPGainMult);
	// 	this.m.CombatStats.XPGained += this.Math.floor(_xp * this.m.CurrentProperties.XPGainMult);
	// }

	o.unlockPerk = function ( _id )
	{
		if (this.hasPerk(_id))
		{
			return true;
		}

		local perk = this.getBackground().getPerk(_id);

		if (perk == null)
		{
			return false;
		}

		if (this.m.PerkPoints > 0)
		{
			--this.m.PerkPoints;
		}

		++this.m.PerkPointsSpent;
		local p = this.new(perk.Script);
		this.m.Skills.add(p);
		p.onUnlocked();
		this.m.Skills.update();

		if (this.m.Level >= 12 && _id == ::Legends.Perks.getID(::Legends.Perk.Student))
		{
			++this.m.PerkPoints;
		}

		if (("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin() != null)
		{
			this.World.Assets.getOrigin().onUnlockPerk(this, _id);
		}
		//++this.m.PerkPoints //// DEBUG, UNCOMMENT FOR UNLIMITED UNLOCKS

		return true;
	}

	o.updateLevel = function() {
		while (this.m.Level < this.Const.LevelXP.len() && this.m.XP >= this.Const.LevelXP[this.m.Level])
		{
			++this.m.Level;
			++this.m.LevelUps;

			if (this.m.Level <= this.Const.XP.MaxLevelWithPerkpoints)
			{
				++this.m.PerkPoints;
			}

			if (this.m.Level == 12 && this.m.Skills.hasPerk(::Legends.Perk.Student))
			{
				++this.m.PerkPoints;
			}

			if (("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin() != null)
			{
				this.World.Assets.getOrigin().onUpdateLevel(this);
			}

			if (this.m.Level == 12)
			{
				this.updateAchievement("OldAndWise", 1, 1);
			}

			if (this.m.Level == 12 && this.m.Skills.hasSkill("trait.player"))
			{
				this.updateAchievement("TooStubbornToDie", 1, 1);
			}
		}
	}

	o.isPerkUnlockable = function ( _id )
	{
		if (this.m.PerkPoints == 0 || this.hasPerk(_id))
		{
			return false;
		}

		local perk = this.getBackground().getPerk(_id);
		if (perk == null)
		{
			return false;
		}

		if (this.m.PerkPointsSpent >= perk.Unlocks)
		{
			return true;
		}

		return false;
	}

	o.isPerkTierUnlocked = function ( _category, _tier )
	{
		local numPerks = 0;

		for( local j = 0; j < this.m.PerksUnlocked[_category].len(); j = ++j )
		{
			numPerks = numPerks + this.m.PerksUnlocked[_category][j];

		}

		if (numPerks < this.Const.Perks.UnlockRequirementsPerTier[_tier])
		{
			return false;
		}

		return true;
	}

	o.assignRandomMeleeEquipment = function()
	{

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "padded_surcoat"],
			[1, "mail_shirt"],
			[1, "coat_of_plates"],
			[1, "gambeson"],
			[1, "leather_tunic"],
			[1, "lamellar_harness"],
			[1, "sackcloth"],
			[1, "heavy_lamellar_armor"],
			[1, "basic_mail_shirt"],
			[1, "scale_armor"],
			[1, "coat_of_scales"],
			[1, "linen_tunic"],
			[1, "tattered_sackcloth"],
			[1, "heraldic_mail"],
			[1, "named/black_leather_armor"],
			[1, "named/golden_scale_armor"],
			[1, "named/blue_studded_mail_armor"],
			[1, "named/brown_coat_of_plates_armor"],
			[1, "named/green_coat_of_plates_armor"],
			[1, "reinforced_mail_hauberk"],
			[1, "mail_hauberk"],
			[1, "leather_lamellar"],
		]));

		local item = this.Const.World.Common.pickHelmet([
			[6, ""],
			[1, "hood"],
			[1, "mail_coif"],
			[1, "closed_mail_coif"],
			[1, "reinforced_mail_coif"],
			[1, "kettle_hat"],
			[1, "nasal_helmet"],
			[1, "padded_nasal_helmet"],
			[1, "nasal_helmet_with_mail"],
			[1, "full_helm"],
			[1, "flat_top_helmet"],
			[1, "padded_flat_top_helmet"],
			[1, "flat_top_with_mail"],
			[1, "kettle_hat_with_mail"],
			[1, "kettle_hat_with_closed_mail"],
			[1, "closed_flat_top_with_neckguard"],
			[1, "closed_flat_top_helmet"],
			[1, "closed_flat_top_with_mail"],
			[1, "witchhunter_hat"],
			[1, "named/golden_feathers_helmet"],
			[1, "named/heraldic_mail_helmet"],
			[1, "named/nasal_feather_helmet"],
			[1, "named/norse_helmet"],
			[1, "named/sallet_green_helmet"],
			[1, "named/wolf_helmet"]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}

		local r = this.Math.rand(1, 17);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/noble_sword"));
			this.m.Items.equip(this.new("scripts/items/shields/heater_shield"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greatsword"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/winged_mace"));
			this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/winged_mace"));
		}
		else if (r == 7)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
		}
		else if (r == 8)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
		}
		else if (r == 9)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/fighting_axe"));
		}
		else if (r == 10)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 11)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/billhook"));
		}
		else if (r == 12)
		{
			this.m.Items.equip(this.new("scripts/items/shields/heater_shield"));
			this.m.Items.equip(this.new("scripts/items/weapons/warhammer"));
		}
		else if (r == 13)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/military_cleaver"));
		}
		else if (r == 14)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/flail"));
		}
		else if (r == 15)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/pike"));
		}
		else if (r == 16)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/two_handed_hammer"));
		}
		else if (r == 17)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
		}
	}

	o.assignRandomRangedEquipment = function()
	{
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "padded_surcoat"],
			[1, "mail_shirt"],
			[1, "padded_leather"],
			[1, "gambeson"],
			[1, "leather_tunic"],
			[1, "sackcloth"],
			[1, "linen_tunic"],
			[1, "tattered_sackcloth"],
			[1, "ragged_surcoat"],
			[1, "thick_tunic"],
		]));

		local item = this.Const.World.Common.pickHelmet([
			[2, ""],
			[1, "hood"],
			[1, "aketon_cap"],
			[1, "full_aketon_cap"],
			[1, "open_leather_cap"],
			[1, "full_leather_cap"]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}


		local r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/short_bow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/light_crossbow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}
	}

	o.assignRandomThrowingEquipment = function()
	{
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "padded_surcoat"],
			[1, "mail_shirt"],
			[1, "padded_leather"],
			[1, "gambeson"],
			[1, "leather_tunic"],
			[1, "sackcloth"],
			[1, "linen_tunic"],
			[1, "tattered_sackcloth"],
		]));

		local item = this.Const.World.Common.pickHelmet([
			[1, ""],
			[1, "hood"],
			[1, "aketon_cap"],
			[1, "full_aketon_cap"]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}

		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/throwing_axe"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/javelin"));
		}
	}

	o.setScenarioValues = function ()
	{
		local b = this.m.BaseProperties;
		b.ActionPoints = 9;
		b.Hitpoints = 60;
		b.Bravery = this.Math.rand(45, 55);
		b.Stamina = 120;
		b.MeleeSkill = 65;
		b.RangedSkill = 65;
		b.MeleeDefense = 10;
		b.RangedDefense = 10;
		b.Initiative = 115;
		this.setName(this.Const.Tactical.Common.getRandomPlayerName());
		local background = this.new("scripts/skills/backgrounds/" + this.Const.CharacterFemaleBackgrounds[this.Math.rand(0, this.Const.CharacterFemaleBackgrounds.len() - 1)]);
		background.addBackgroundType(this.Const.BackgroundType.Scenario);
		this.m.Skills.add(background);
		background.buildDescription();
		background.setAppearance();
		local c = this.m.CurrentProperties;
		this.m.ActionPoints = c.ActionPoints;
		this.m.Hitpoints = c.Hitpoints;
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);
		this.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
	}

	o.pickTraits <- function ( _backgrounds, _maxTraits )
	{
		if(_maxTraits <= 0) {return;}

		local available_traits = [];
		foreach(trait in this.Const.CharacterTraits)
		{
			local available = 1;
			foreach(bg in _backgrounds)
			{
				if(bg.getID() == trait[0] || bg.isExcluded(trait[0]))
				{
					available = 0;
					break;
				}
			}
			if(available == 1) {available_traits.push(trait);}
		}
		local picked_traits = [];
		while(_maxTraits > 0 && available_traits.len() > 0)
		{
			local pick = this.Math.rand(0, available_traits.len() - 1);
			local picked = available_traits[pick];
			available_traits.remove(pick);
			local accept = 1;
			if(picked_traits.len() > 0)
			{
				foreach(trait in picked_traits)
				{
					if(trait.getID() == picked[0] || trait.isExcluded(picked[0]))
					{
						accept = 0;
						break;
					}
				}
			}
			if(accept == 1)
			{
				picked_traits.push(this.new(picked[1]));
				_maxTraits -= 1;
			}
		}
		_backgrounds.extend(picked_traits);
	}

	o.setStartValuesEx = function ( _backgrounds, _addTraits = true, _gender = -1, _addEquipment = true )
	{
		if (this.isSomethingToSee() && this.World.getTime().Days >= 7)
		{
			_backgrounds = this.Const.CharacterPiracyBackgrounds;
		}

		local background = this.new("scripts/skills/backgrounds/" + _backgrounds[this.Math.rand(0, _backgrounds.len() - 1)]);

		if (::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled")
		{
			background.setGender(_gender);
		}
		this.m.Skills.add(background);

		/*Skill onAdded sets these values
		this.m.Background = background;
		this.m.Ethnicity = this.m.Background.getEthnicity();
		background.buildAttributes();
		*/
		background.buildDescription();

		if (background.isBackgroundType(this.Const.BackgroundType.Female))
		{
			this.setGender(1);
		}
		else
		{
			this.setGender(0);  //Making sure that m.Gender is set properly for the player class, preventing genderbending
		}

		local attributes = background.buildPerkTree();
		local maxTraits = 0;

		if (this.getFlags().has("PlayerZombie"))
		{
			this.m.StarWeights = background.buildAttributes("zombie", attributes);
		}
		else if (this.getFlags().has("PlayerSkeleton"))
		{
			this.m.StarWeights = background.buildAttributes("skeleton", attributes);
		}
		else
		{
			this.m.StarWeights = background.buildAttributes(null, attributes);
		}

		background.buildDescription();
		local inTraining = this.new("scripts/skills/traits/legend_intensive_training_trait");

		if (!this.getSkills().hasSkill("trait.legend_intensive_training_trait"))
		{
			this.m.Skills.add(inTraining);
		}

		if (_addTraits)
		{
			local maxTraits = 2;
			local traits = [
				background
			];

			if (background.m.IsGuaranteed.len() > 0)
			{
				maxTraits = maxTraits - background.m.IsGuaranteed.len();
				foreach(trait in background.m.IsGuaranteed)
				{
					traits.push(this.new("scripts/skills/traits/" + trait));
				}
			}

			pickTraits( traits, maxTraits );

			for( local i = 1; i < traits.len(); i = ++i )
			{
				this.m.Skills.add(traits[i]);

				if (traits[i].getContainer() != null)
				{
					traits[i].addTitle();
				}
			}
		}

		if (_addEquipment)
		{
			background.addEquipment();
		}

		if (this.getFlags().has("PlayerZombie"))
		{
			background.setAppearance("zombie");
		}
		else if (this.getFlags().has("PlayerSkeleton"))
		{
			background.setAppearance("skeleton");
		}
		else
		{
			background.setAppearance();
		}

		background.buildDescription(true);
		this.m.Skills.update();
		local p = this.m.CurrentProperties;
		this.m.Hitpoints = p.Hitpoints;

		if (_addTraits)
		{
			this.fillTalentValues(3);
			this.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
		}
	}

	o.getAlignment <- function()
	{
		return this.m.Alignment;
	}

	// o.getCompanyID <- function()
	// {
	//	 return this.m.CompanyID;
	// }

	// o.setCompanyID <- function( _num )
	// {
	// 	this.m.CompanyID = _num;
	// }

	o.fillTalentValues = function ( _num, _force = false )
	{
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);

		if (this.getBackground() != null && this.getBackground().isBackgroundType(this.Const.BackgroundType.Untalented) && !_force)
		{
			return;
		}

		local attributes = [];
		local weights = [];
		local totalWeight = 0;

		for (local i = 0; i < this.m.StarWeights.len(); i = ++i)
		{
			if (this.m.Talents[i] != 0 )
			{
				continue;
			}

			if (this.getBackground() != null && this.getBackground().getExcludedTalents().find(i) != null)
			{
				continue;
			}

			if (this.getFlags().has("PlayerZombie") && (i == this.Const.Attributes.Bravery || i == this.Const.Attributes.Fatigue || i == this.Const.Attributes.Initiative))
			{
				continue;
			}
			else if (this.getFlags().has("PlayerSkeleton") && (i == this.Const.Attributes.Bravery || i == this.Const.Attributes.Fatigue || i == this.Const.Attributes.Hitpoints))
			{
				continue;
			}
			attributes.push(i);
			weights.push(this.m.StarWeights[i]);
			totalWeight += this.m.StarWeights[i];
		}

		for( local done = 0; done < _num; done = ++done )
		{
			local weight = this.Math.rand(1, totalWeight);
			local totalhere = 0;

			for( local i = 0; i < attributes.len(); i = ++i )
			{
				if (weight > totalhere && weight <= totalhere + weights[i])
				{
					local r = this.Math.rand(1, 100);
					local j = attributes[i];

					if (r <= 60)
					{
						this.m.Talents[j] = 1;
					}
					else if (r <= 90)
					{
						this.m.Talents[j] = 2;
					}
					else
					{
						this.m.Talents[j] = 3;
					}

					attributes.remove(i);
					totalWeight = totalWeight - weights[i];
					weights.remove(i);
					break;
				}
				else
				{
					totalhere = totalhere + weights[i];
				}

			}

		}
	}

	o.fillAttributeLevelUpValues = function ( _amount, _maxOnly = false, _minOnly = false )
	{
		if (this.m.Attributes.len() == 0)
		{
			this.m.Attributes.resize(this.Const.Attributes.COUNT);

			for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
			{
				this.m.Attributes[i] = [];

			}
		}

		for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
		{
			for( local j = 0; j < _amount; j = ++j )
			{
				if (_minOnly)
				{
					this.m.Attributes[i].insert(0, 1);
				}
				else if (_maxOnly)
				{
					this.m.Attributes[i].insert(0, this.Const.AttributesLevelUp[i].Max);
				}
				else
				{
					this.m.Attributes[i].insert(0, this.Math.rand(this.Const.AttributesLevelUp[i].Min + (this.m.Talents[i] == 3 ? 2 : this.m.Talents[i]), this.Const.AttributesLevelUp[i].Max + (this.m.Talents[i] == 3 ? 1 : 0)));
				}

			}

		}
	}

	o.getAttributeLevelUpValues = function ()
	{
		local b = this.getBaseProperties();

		if (this.m.Attributes.len() == 0)
		{
			this.m.Attributes.resize(this.Const.Attributes.COUNT);
			for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
			{
				this.m.Attributes[i] = [];
			}
		}

		for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
		{
			if (this.m.Attributes[i].len() == 0) {
				this.m.Attributes[i].push(1);
			}
		}

		local ret = {
			hitpoints = b.Hitpoints,
			hitpointsMax = 150,
			hitpointsIncrease = this.m.Attributes[this.Const.Attributes.Hitpoints][0],
			bravery = b.Bravery,
			braveryMax = 150,
			braveryIncrease = this.m.Attributes[this.Const.Attributes.Bravery][0],
			fatigue = b.Stamina,
			fatigueMax = 150,
			fatigueIncrease = this.m.Attributes[this.Const.Attributes.Fatigue][0],
			initiative = b.Initiative,
			initiativeMax = 200,
			initiativeIncrease = this.m.Attributes[this.Const.Attributes.Initiative][0],
			meleeSkill = b.MeleeSkill,
			meleeSkillMax = 120,
			meleeSkillIncrease = this.m.Attributes[this.Const.Attributes.MeleeSkill][0],
			rangeSkill = b.RangedSkill,
			rangeSkillMax = 120,
			rangeSkillIncrease = this.m.Attributes[this.Const.Attributes.RangedSkill][0],
			meleeDefense = b.MeleeDefense,
			meleeDefenseMax = 100,
			meleeDefenseIncrease = this.m.Attributes[this.Const.Attributes.MeleeDefense][0],
			rangeDefense = b.RangedDefense,
			rangeDefenseMax = 100,
			rangeDefenseIncrease = this.m.Attributes[this.Const.Attributes.RangedDefense][0]
		};
		return ret;
	}

	o.setAttributeLevelUpValues = function ( _v )
	{
		local b = this.getBaseProperties();
		b.Hitpoints += _v.hitpointsIncrease;
		this.m.Hitpoints += _v.hitpointsIncrease;
		b.Stamina += _v.maxFatigueIncrease;
		b.Bravery += _v.braveryIncrease;
		b.MeleeSkill += _v.meleeSkillIncrease;
		b.RangedSkill += _v.rangeSkillIncrease;
		b.MeleeDefense += _v.meleeDefenseIncrease;
		b.RangedDefense += _v.rangeDefenseIncrease;
		b.Initiative += _v.initiativeIncrease;
		this.m.LevelUps = this.Math.max(0, this.m.LevelUps - 1);

		for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
		{
			this.m.Attributes[i].remove(0);

		}

		this.getSkills().update();
		this.setDirty(true);

		if (b.MeleeSkill >= 90)
		{
			this.updateAchievement("Swordmaster", 1, 1);
		}

		if (b.RangedSkill >= 90)
		{
			this.updateAchievement("Deadeye", 1, 1);
		}
	}

	o.copyFormation <- function ( _from, _to )
	{
		this.m.Formations.copy(_from, _to);
	}

	o.saveFormation <- function ()
	{
		this.m.Formations.savePosition(this.m.PlaceInFormation);
		this.m.Formations.saveItems(this.getItems());
	}

	o.setFormation <- function ( _i, _stash )
	{
		if (_i == this.m.Formations.getCurrentIndex())
		{
			return [[], []];
		}

		this.m.Formations.setFormation(_i);
		this.setPlaceInFormation(this.m.Formations.getPosition());
		local items = this.m.Formations.getItems();
		local eTransfer = [];
		local bTransfer = [];

		foreach( itemId in items )
		{
			local item = _stash.remove(itemId);

			if (item == null)
			{
				this.logInfo("setFormation::Items; could not find item for " + itemId);
				continue;
			}
			eTransfer.push(item);

			//this.m.Items.equip(item);
		}

		local bags = this.m.Formations.getBags();

		foreach( itemId in bags )
		{
			local item = _stash.remove(itemId);

			if (item == null)
			{
				this.logInfo("setFormation::Bags; could not find item for " + itemId);
				continue;
			}

			bTransfer.push(item);
		}
		return [eTransfer, bTransfer];
	}

	o.getStashModifier <- function ()
	{
		local broStash = this.getBackground().getModifiers().Stash;
		local item = this.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

		if (item != null)
		{
			broStash = broStash + item.getStashModifier();
		}

		local skills = [
			::Legends.Perk.LegendSkillfulStacking,
			::Legends.Perk.LegendEfficientPacking
		];
		foreach( s in skills )
		{
			local skill = ::Legends.Perks.get(this, s);
			if (skill != null)
			{
				broStash += skill.getModifier();
			}
		}

		return broStash;
	}

	o.getAmmoModifier <- function ()
	{
		local mod = this.getBackground().getModifiers().Ammo;
		local skills = [
			::Legends.Perk.LegendAmmoBundles,
			::Legends.Perk.LegendAmmoBinding
		];

		foreach( s in skills )
		{
			local skill = ::Legends.Perks.get(this, s);
			if (skill != null)
			{
				mod = mod + skill.getModifier();
			}
		}

		return mod;
	}

	o.getArmorPartsModifier <- function ()
	{
		local mod = this.getBackground().getModifiers().ArmorParts;
		local skills = [
			::Legends.Perk.LegendToolsSpares,
			::Legends.Perk.LegendToolsDrawers
		];

		foreach( s in skills )
		{
			local skill = ::Legends.Perks.get(this, s);
			if (skill != null)
			{
				mod += skill.getModifier();
			}
		}

		return mod;
	}

	o.getMedsModifier <- function ()
	{
		local mod = this.getBackground().getModifiers().Meds;
		local skills = [
			::Legends.Perk.LegendMedPackages,
			::Legends.Perk.LegendMedIngredients
		];

		foreach( s in skills )
		{
			local skill = ::Legends.Perks.get(this, s);
			if (skill != null)
			{
				mod = mod + skill.getModifier();
			}
		}

		return mod;
	}

	o.getBarterModifier <- function ()
	{
		local bg = this.getBackground();
		if (bg == null)
		{
			return 0;
		}
		local mod = this.getBackground().getModifiers().Barter;
		local skills = [
			::Legends.Perk.LegendBarterTrustworthy,
			::Legends.Perk.LegendBarterConvincing,
			::Legends.Perk.LegendOffBookDeal
		];

		foreach( s in skills )
		{
			local skill = ::Legends.Perks.get(this, s);
			if (skill != null)
			{
				mod += skill.getModifier();
			}
		}
		local skill = this.getSkills().getSkillByID("trait.legend_seductive");
		if (skill != null) {
			mod += skill.getModifier();
		}
		return mod;
	}

	o.getCampHealing <- function ()
	{
		return this.m.CampHealing;
	}

	o.setCampHealing <- function ( _v )
	{
		this.m.CampHealing = _v;
	}

	o.getLastCampTime <- function ()
	{
		return this.m.LastCampTime;
	}

	o.setLastCampTime <- function ( _t )
	{
		this.m.LastCampTime = _t;
	}

	o.getDeadTraits <- function ()
	{
		local skills = this.getSkills().query(this.Const.SkillType.Trait, false, true);
		local list = [];

		foreach( i, s in skills )
		{
			if (s.isType(this.Const.SkillType.StatusEffect) || s.isType(this.Const.SkillType.Active) || s.isType(this.Const.SkillType.Racial) || s.isType(this.Const.SkillType.Special) || s.isType(this.Const.SkillType.Perk) || s.isType(this.Const.SkillType.Terrain) || s.isType(this.Const.SkillType.Injury) || s.isType(this.Const.SkillType.PermanentInjury) || s.isType(this.Const.SkillType.SemiInjury) || s.isType(this.Const.SkillType.DrugEffect) || s.isType(this.Const.SkillType.DamageOverTime))
			{
				continue;
			}

			list.append(s.getIcon());
		}

		for( local i = list.len(); i < 4; i++ )
		{
			list.append("");
		}

		return list;
	}

	o.playSound <- function ( _type, _volume, _pitch = 1.0 )
	{
		if (this.m.Sound[_type].len() == 0)
		{
			return;
		}

		local volume = 1.0;

		if (this.getBackground() != null && this.getBackground().isBackgroundType(this.Const.BackgroundType.Female))
		{
			if (this.m.VoiceSet > this.Const.WomanSounds.len() - 1)
			{
				this.m.VoiceSet = this.Math.rand(0, this.Const.WomanSounds.len() - 1);
			}
			volume *= this.Const.WomanSounds[this.m.VoiceSet].Volume;
		}
		else
		{
			volume *= this.Const.HumanSounds[this.m.VoiceSet].Volume;
		}

		this.Sound.play(this.m.Sound[_type][this.Math.rand(0, this.m.Sound[_type].len() - 1)], volume, this.getPos(), _pitch);
	}

	o.getRemoveLayerTooltip <- function (_slot, _layer)
	{
		local armor = this.getItems().getItemAtSlot(_slot);
		local title = "";

		switch(_layer)
		{
		case 0:
			title = _slot == this.Const.ItemSlot.Body ? "Chain Mail Layer" : "Helmet Layer";
			break;

		case 1:
			title = _slot == this.Const.ItemSlot.Body ? "Plate Layer" : "Top Layer";
			break;

		case 2:
			title = _slot == this.Const.ItemSlot.Body ? "Tabard Layer" : "Vanity Layer";
			break;

		case 3:
			title = _slot == this.Const.ItemSlot.Body ? "Cloak Layer" : "Aesthetic Vanity Layer";
			break;

		case 4:
			title = _slot == this.Const.ItemSlot.Body ? "Upgrade Attachment Layer" : "Rune Layer";
			break;

		case 5:
			title = "Rune Layer";
			break;
		}

		local tt = [
			{
				id = 1,
				type = "title",
				text = title
			}
		];

		if (armor == null)
		{
			tt.push({
				id = 2,
				type = "description",
				text = _slot == this.Const.ItemSlot.Body ? "A base piece of armor, such as a tunic or surcoat, needs to be worn in order to attach a layer" : "A base piece of helmet, such as a hood or scarf, needs to be worn in order to attach a layer"
			});
			return tt;
		}

		if (armor.upgradeIsBlocked(_layer))
		{
			tt.push({
				id = 2,
				type = "description",
				text = _slot == this.Const.ItemSlot.Body ? "The layer can not be attached to this piece of armor." : "The layer can not be attached to this helmet"
			});
			return tt;
		}

		local upgrade = armor.getUpgrade(_layer);

		if (upgrade == null)
		{
			tt.push({
				id = 2,
				type = "description",
				text = "This layer is vacant. Right-click or drag a layer piece from the stash to attach it to this armor"
			});
			return tt;
		}

		tt.extend(upgrade.getTooltip());
		tt.push({
			id = 1,
			type = "hint",
			icon = "ui/icons/mouse_left_button.png",
			text = "UnEquip layer"
		});

		foreach( t in tt )
		{
			if (t.id != 65)
			{
				continue;
			}

			t.text = "Click this button to remove the attached layer and return it to the stash.";
			break;
		}

		return tt;
	}


	// todo delete it - chopeks
	o.TherianthropeInfection <- function (_killer)
	{
//		if (!this.LegendsMod.Configs().LegendTherianthropyEnabled())
//		{
			return;
//		}

		if (_killer.getSkills().hasSkill("injury.legend_aperthropy") && !this.getSkills().hasSkill("injury.legend_aperthropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_aperthropy_injury"));
			this.getBackground().addPerkGroup(this.Const.Perks.TherianthropyTree.Tree);
			this.logDebug(this.getName() + " gained aperthropy");
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this) + " is infected with aperthropy ");
		}

		if (_killer.getSkills().hasSkill("injury.legend_arborthropy") && !this.getSkills().hasSkill("injury.legend_arborthropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_arborthropy_injury"));
			this.getBackground().addPerkGroup(this.Const.Perks.TherianthropyTree.Tree);
			this.logDebug(this.getName() + " gained arborthropy");
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this) + " is infected with arborthropy ");
		}

		if (_killer.getSkills().hasSkill("injury.legend_lycanthropy") && !this.getSkills().hasSkill("injury.legend_lycanthropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_lycanthropy_injury"));
			this.getBackground().addPerkGroup(this.Const.Perks.TherianthropyTree.Tree);
			this.logDebug(this.getName() + " gained lycanthropy");
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this) + " is infected with lycanthropy ");
		}

		if (_killer.getSkills().hasSkill("injury.legend_ursathropy") && !this.getSkills().hasSkill("injury.legend_ursathropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_ursathropy_injury"));
			this.getBackground().addPerkGroup(this.Const.Perks.TherianthropyTree.Tree);
			this.logDebug(this.getName() + " gained ursathropy");
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this) + " is infected with ursathropy ");
		}
		if (_killer.getSkills().hasSkill("injury.legend_vermesthropy") && !this.getSkills().hasSkill("injury.legend_vermesthropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_vermesthropy_injury"));
			this.getBackground().addPerkGroup(this.Const.Perks.TherianthropyTree.Tree);
			this.logDebug(this.getName() + " gained vermesthropy");
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this) + " is infected with vermesthropy ");
		}
	}

	// todo delete it - chopeks
	o.TherianthropeInfectionRandom <- function ()
	{

//		if (!this.LegendsMod.Configs().LegendTherianthropyEnabled())
//		{
			return;
//		}

		local r = this.Math.rand(1,99);

		if (r <= 60 && !this.getSkills().hasSkill("injury.legend_lycanthropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_lycanthropy_injury"));
			this.getBackground().addPerkGroup(this.Const.Perks.TherianthropyTree.Tree);
			this.logDebug(this.getName() + " gained lycanthropy");
		}

		if (r > 50 && r <= 80 && !this.getSkills().hasSkill("injury.legend_aperthropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_aperthropy_injury"));
			this.getBackground().addPerkGroup(this.Const.Perks.TherianthropyTree.Tree);
			this.logDebug(this.getName() + " gained aperthropy");
		}

		if (r > 80 && r <= 95 && !this.getSkills().hasSkill("injury.legend_ursathropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_ursathropy_injury"));
			this.getBackground().addPerkGroup(this.Const.Perks.TherianthropyTree.Tree);
			this.logDebug(this.getName() + " gained ursathropy");
		}

		if (r == 95 && !this.getSkills().hasSkill("injury.legend_vermesthropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_vermesthropy_injury"));
			this.getBackground().addPerkGroup(this.Const.Perks.TherianthropyTree.Tree);
			this.logDebug(this.getName() + " gained vermesthropy");
		}
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function ( _out )
	{
		onSerialize( _out );
		_out.writeF32(this.m.HiringCost);
		this.m.LifetimeStats.Tags.onSerialize(_out);
		this.m.Formations.onSerialize(_out);
		_out.writeU8(this.m.VeteranPerks);
		_out.writeBool(this.m.IsCommander);
		_out.writeString(this.m.CampAssignment);
		_out.writeF32(this.m.LastCampTime);
		_out.writeBool(this.m.InReserves);
		_out.writeU8(this.m.CompanyID);
	}

	// copied entirely because adjustHiringCostBasedOnEquipment is commented out
	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		onDeserialize(_in);
		if (this.m.Background != null && this.m.Background.isBackgroundType(this.Const.BackgroundType.Female))
		{
			this.m.Gender = 1;
			this.m.VoiceSet = this.Math.rand(0, this.Const.WomanSounds.len() - 1);
		}
		this.m.HiringCost = _in.readF32();
		this.m.LifetimeStats.Tags.onDeserialize(_in);
		this.m.Formations.onDeserialize(_in);
		this.m.VeteranPerks = ::Math.min(_in.readU8(), 4);
		this.m.IsCommander = _in.readBool();
		this.m.CampAssignment = _in.readString();
		this.m.LastCampTime = _in.readF32();
		this.m.InReserves = _in.readBool();
		this.m.CompanyID = _in.readU8();
	}
});
