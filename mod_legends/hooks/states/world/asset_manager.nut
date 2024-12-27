::mods_hookExactClass("states/world/asset_manager", function(o)
{
	o.m.FounderNames <- [];
	o.m.BusinessReputationMax <- 0;
	o.m.BrothersMax <- 27;
	o.m.BrothersMaxInCombat <- 27;
	o.m.BrothersScaleMax <- 27;
	o.m.BrothersScaleMin <- 1;
	o.m.LastDayResourcesUpdated <- 0;
	o.m.FormationIndex <- 0;
	o.m.FormationNames <- [];
	o.m.LastRosterSize <- 0;

	o.getArmorPartsF <- function()
	{
		return this.m.ArmorParts;
	}

	o.getMaxAmmo <- function()
	{
		local ammo = this.Const.LegendMod.MaxResources[this.m.EconomicDifficulty].Ammo;
		//this.Const.Difficulty.MaxResources[this.m.EconomicDifficulty].Ammo + this.m.AmmoMaxAdditional
		ammo += this.m.AmmoMaxAdditional
		ammo += this.World.State.getPlayer().getAmmoModifier();
		return ammo;
	}

	o.getMaxArmorParts <- function()
	{
		local parts = this.Const.LegendMod.MaxResources[this.m.EconomicDifficulty].ArmorParts;
		parts += this.m.ArmorPartsMaxAdditional; //this.Const.Difficulty.MaxResources[this.m.EconomicDifficulty].ArmorParts + this.m.MedicineMaxAdditional
		parts += this.World.State.getPlayer().getArmorPartsModifier();
		return parts;
	}

	o.getMaxMedicine <- function()
	{
		local meds = this.Const.LegendMod.MaxResources[this.m.EconomicDifficulty].Medicine;
		//this.Const.Difficulty.MaxResources[this.m.EconomicDifficulty].Ammo
		meds += this.m.MedicineMaxAdditional;
		meds += this.World.State.getPlayer().getMedsModifier();
		return meds;
	}

	o.getBusinessReputationMax <- function()
	{
		return this.m.BusinessReputationMax;
	}

	o.getBrothersMax = function ()
	{
		return this.Const.Roster.getSizeForTier(this.World.Assets.getOrigin().getRosterTier());
	}

	o.getBrothersMaxInCombat = function ()
	{
		return this.Const.Roster.getInCombatSizeForTier(this.World.Assets.getOrigin().getRosterTierCombat());
	}

	o.getBrothersScaleMax = function ()
	{
		return this.Math.min(25, this.m.BrothersScaleMax);
	}

	o.getFounderNames <- function ()
	{
		return this.m.FounderNames;
	}
	o.getFormationIndex <- function ()
	{
		return this.m.FormationIndex;
	}

	o.getFormationName <- function ()
	{
		return this.m.FormationNames[this.m.FormationIndex];
	}

	o.isCamping = function()
	{
		return this.World.Camp.isCamping();
	}

	o.setCamping = function( _c )
	{
		::World.Camp.onCamp();
	}

	o.setAmmo = function( _f )
	{
		this.m.Ammo = this.Math.min(this.Math.max(0, _f), this.getMaxAmmo());
		this.refillAmmo();
	}

	o.setArmorParts = function( _f )
	{
		this.m.ArmorParts = this.Math.min(this.Math.max(0, _f), this.getMaxArmorParts());
	}

	o.setMedicine = function( _f )
	{
		this.m.Medicine = this.Math.min(this.Math.max(0, _f), this.getMaxMedicine());
	}

	o.addAmmo = function( _f )
	{
		this.m.Ammo = this.Math.min(this.Math.max(0, this.m.Ammo + _f), this.getMaxAmmo());
	}

	o.addArmorParts = function( _f )
	{
		this.m.ArmorParts = this.Math.min(this.Math.max(0, this.m.ArmorParts + _f), this.getMaxArmorParts());
	}

	o.addArmorPartsF <- function( _f )
	{
		this.m.ArmorParts = this.Math.minf(this.Math.maxf(0, this.m.ArmorParts + _f), this.getMaxArmorParts());
	}

	o.addMedicine = function( _f )
	{
		this.m.Medicine = this.Math.min(this.Math.max(0, this.m.Medicine + _f), this.getMaxMedicine());
	}

	o.addBusinessReputation = function ( _f )
	{
		if (_f < 0) {
			if (this.m.BusinessReputation < 250)
			{
				_f = 0;
			}
			if (this.m.BusinessReputation >= 250 && this.m.BusinessReputation < 500)
			{
				_f *= 0.5;
			}
		}
		this.m.BusinessReputation += this.Math.ceil(_f * this.m.BusinessReputationRate);
		this.m.BusinessReputationMax = this.Math.max(this.m.BusinessReputation, this.m.BusinessReputationMax);

		if (this.m.BusinessReputation >= 1000)
		{
			this.updateAchievement("MakingAName", 1, 1);
		}

		if (this.m.BusinessReputation >= 3000)
		{
			this.updateAchievement("ManOfRenown", 1, 1);
		}

		if (this.m.BusinessReputation >= 8000)
		{
			this.updateAchievement("StuffOfLegends", 1, 1);
		}
	}

	// overwriting due to certain options
	o.setCampaignSettings = function ( _settings )
	{
		this.m.CampaignID = this.Math.max(0, this.Math.rand());
		this.m.Name = this.removeFromBeginningOfText("The ", this.removeFromBeginningOfText("the ", _settings.Name));
		this.m.Banner = _settings.Banner;
		this.m.BannerID = _settings.Banner.slice(_settings.Banner.find("_") + 1).tointeger();
		this.m.CombatDifficulty = _settings.Difficulty;
		this.m.EconomicDifficulty = _settings.EconomicDifficulty;
		this.m.IsIronman = _settings.Ironman;
		this.m.IsPermanentDestruction = _settings.PermanentDestruction;
		this.m.Origin = _settings.StartingScenario;
		this.m.BusinessReputation = 0;
		this.m.SeedString = _settings.Seed;
		this.World.FactionManager.getGreaterEvil().Type = _settings.GreaterEvil;
		this.m.Stash.resize( this.Const.LegendMod.MaxResources[_settings.EconomicDifficulty].Stash);
		this.m.Money = this.Const.LegendMod.StartResources[_settings.BudgetDifficulty].Money;
		this.m.Ammo = this.Const.LegendMod.StartResources[_settings.BudgetDifficulty].Ammo;
		this.m.ArmorParts = this.Const.LegendMod.StartResources[_settings.BudgetDifficulty].ArmorParts;
		this.m.Medicine = this.Const.LegendMod.StartResources[_settings.BudgetDifficulty].Medicine;


		this.m.Stash.clear();
		this.m.Origin.onSpawnAssets();
		local bros = this.World.getPlayerRoster().getAll();

		foreach( bro in bros )
		{
			// local val = this.World.State.addNewID(bro);
			// bro.m.CompanyID = val;
			bro.getBackground().buildDescription(true);
			bro.m.XP = this.Const.LevelXP[bro.m.Level - 1];
			bro.m.Attributes = [];
			bro.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
			bro.getSkills().update();
		}

		this.updateFormation();

		foreach( item in this.Const.World.Assets.NewCampaignEquipment )
		{
			this.m.Stash.add(this.new(item));
		}
		this.m.Stash.add(this.new("scripts/items/accessory/legend_pack_small"));
		// this.m.Stash.add(this.new("scripts/items/trade/cloth_rolls_item"))
		// this.m.Stash.add(this.new("scripts/items/misc/spider_silk_item"))


		this.updateFood();
		this.m.LastRosterSize = this.World.getPlayerRoster().getSize();
	}

	o.getHealingRequired = function ()
	{
		local ret = {
			MedicineMin = 0,
			MedicineMax = 0,
			DaysMin = 0,
			DaysMax = 0,
			Modifier = 0,
			Modifiers = [],
			Injuries = []
		};
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local injuries = bro.getSkills().query(this.Const.SkillType.TemporaryInjury);

			local ht;
			if (bro.getSkills().hasSkill("injury.sickness"))
			{
				injuries.push(bro.getSkills().getSkillByID("injury.sickness"));
			}

			foreach( inj in injuries )
			{
				ht = inj.getHealingTime();
				ret.MedicineMin += ht.Min * this.Const.World.Assets.MedicinePerInjuryDay;
				ret.MedicineMax += ht.Max * this.Const.World.Assets.MedicinePerInjuryDay;

				if (ht.Min > ret.DaysMin)
				{
					ret.DaysMin = ht.Min;
				}

				if (ht.Max > ret.DaysMax)
				{
					ret.DaysMax = ht.Max;
				}
			}

			if (ht)
			{
				ret.Injuries.push([ht.Min, ht.Max, bro.getName()]);
			}

			local rm = bro.getBackground().getModifiers().Healing * 100.0;
			if (rm > 0)
			{
				ret.Modifiers.push([rm, bro.getName(), bro.getBackground().getNameOnly()]);
			}
			ret.Modifier += rm;
		}

		ret.MedicineMin = this.Math.ceil(ret.MedicineMin);
		ret.MedicineMax = this.Math.ceil(ret.MedicineMax);
		ret.DaysMin = this.Math.ceil(ret.DaysMin);
		ret.DaysMax = this.Math.ceil(ret.DaysMax);
		return ret;
	}

	o.getDailyWageMult <- function ()
	{
		local modifier = ::World.Retinue.hasFollower("follower.paymaster") ? ::World.Retinue.getFollower("follower.paymaster").getMultiplier() : 1.0;
		return this.m.DailyWageMult * modifier;
	}

	local resetToDefaults = o.resetToDefaults;
	o.resetToDefaults = function ()
	{
		resetToDefaults();
		this.m.BrothersMax = 27;
		this.m.BrothersMaxInCombat = 27;
		this.m.BrothersScaleMax = 27;
		this.m.BrothersScaleMin = 1;
	}

	local create = o.create;
	o.create = function ()
	{
		create();
		for( local i = 0; i < this.Const.LegendMod.Formations.Count; i = ++i )
		{
			local name = "NULL"
			if (i == 0)
			{
				name = "Formation 1"
			}
			this.m.FormationNames.push(name);
		}
	}

	o.consumeFood = function ()
	{
		local items = this.m.Stash.getItems();
		local food = [];

		foreach(bro in this.World.getPlayerRoster().getAll())
		{
			foreach(item in bro.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag))
			{
				if (item != null && item.isItemType(this.Const.Items.ItemType.Food) && this.Time.getVirtualTimeF() >= item.getBestBeforeTime())
				{
					item.removeSelf();
				}
			}
		}

		foreach( i, item in items )
		{
			if (item != null && item.isItemType(this.Const.Items.ItemType.Food))
			{
				if (this.Time.getVirtualTimeF() >= item.getBestBeforeTime())
				{
					items[i] = null;
				}
				else
				{
					food.push(item);
				}
			}
		}

		if (!this.m.IsUsingProvisions)
		{
			this.m.LastFoodConsumed = this.Time.getVirtualTimeF();
			return;
		}

		food.sort(this.sortFoodByFreshness);
		local d = this.Math.maxf(0.0, this.Time.getVirtualTimeF() - this.m.LastFoodConsumed);
		this.m.LastFoodConsumed = this.Time.getVirtualTimeF();
		local eaten = d * this.getDailyFoodCost() * this.Const.World.TerrainFoodConsumption[this.World.State.getPlayer().getTile().Type] * this.m.FoodConsumptionMult * this.Const.World.Assets.FoodConsumptionMult;

		for( local i = 0; i < food.len();  )
		{
			local foodLeft = food[i].getAmount() - eaten;

			if (foodLeft <= 0)
			{
				eaten = eaten - food[i].getAmount();

				foreach( j, item in items )
				{
					if (item == food[i])
					{
						items[j] = null;
						break;
					}
				}

				food.remove(i);
			}
			else
			{
				food[i].setAmount(foodLeft);
				break;
			}
		}

		this.updateFood();
	}

	o.update = function ( _worldState )
	{
		if (isCamping())
			::World.State.m.Camp.update(_worldState);

		if (this.World.Flags.getAsInt("MandatoryShopRefreshDayMark") + 50 <= this.World.getTime().Days)
		{
			this.World.Flags.set("MandatoryShopRefreshDayMark", this.World.getTime().Days);
			foreach( t in this.World.EntityManager.getSettlements() )
			{
				t.updateShop();
			}
		}

		if (this.World.getTime().Days > this.m.LastDayPaid && this.World.getTime().Hours > 8 && this.m.IsConsumingAssets)
		{
			this.m.LastDayPaid = this.World.getTime().Days;

			if (this.m.BusinessReputation > 0)
			{
				this.m.BusinessReputation = this.Math.max(0, this.m.BusinessReputation + this.Const.World.Assets.ReputationDaily);
			}

			this.World.Retinue.onNewDay();

			if (this.World.Flags.get("IsGoldenGoose") == true)
			{
				this.addMoney(50);
			}

			local roster = this.World.getPlayerRoster().getAll();
			local mood = 0;
			local slaves = 0;
			local nonSlaves = 0;

			if (this.m.Origin.getID() == "scenario.manhunters")
			{
				foreach( bro in roster )
				{
					if (bro.getBackground().getID() == "background.slave")
					{
						slaves = ++slaves;
					}
					else
					{
						nonSlaves = ++nonSlaves;
					}
				}
			}

			local items = this.World.Assets.getStash().getItems();
			foreach( item in items )
			{
				if (item == null)
				{
					continue;
				}

				item.onNewDay();
			}

			local companyRep = this.World.Assets.getMoralReputation() / 10;

			foreach( bro in roster )
			{
				bro.getSkills().onNewDay();
				bro.updateInjuryVisuals();

				if (this.World.Assets.getOrigin().getID() == "scenario.legends_troupe")
				{
					this.addMoney(10);
				}


				if (bro.getDailyCost() > 0 && this.m.Money < bro.getDailyCost())
				{
					if (bro.getSkills().hasSkill("trait.greedy"))
					{
						bro.worsenMood(this.Const.MoodChange.NotPaidGreedy, "Did not get paid");
					}
					else
					{
						bro.worsenMood(this.Const.MoodChange.NotPaid, "Did not get paid");
					}
				}

				// if (bro.getSkills().hasSkill("perk.legend_pacifist"))
				// {
					// local hireTime = bro.getHireTime();
					// local currentTime =  this.World.getTime().Time;
					// local servedTime = currentTime - hireTime;
					// local servedDays = servedTime / this.World.getTime().SecondsPerDay;
					// if ((servedDays * 7) < bro.getLifetimeStats().Kills)
					// 	{
					// 		bro.worsenMood(this.Const.MoodChange.BattleWithoutMe, "Remembers being forced to kill against their wishes");
					// 	}
					// if (bro.getLifetimeStats().Battles > bro.getLifetimeStats().BattlesWithoutMe)
					// {
					// 	bro.worsenMood(this.Const.MoodChange.BattleWithoutMe, "Took part in too many battles");
					// }
				// }

				if (this.m.IsUsingProvisions && this.m.Food < bro.getDailyFood())
				{
					if (bro.getSkills().hasSkill("trait.spartan"))
					{
						bro.worsenMood(this.Const.MoodChange.NotEatenSpartan, "Went hungry");
					}
					else if (bro.getSkills().hasSkill("trait.gluttonous"))
					{
						bro.worsenMood(this.Const.MoodChange.NotEatenGluttonous, "Went hungry");
					}
					else
					{
						bro.worsenMood(this.Const.MoodChange.NotEaten, "Went hungry");
					}
				}

				if (this.m.Origin.getID() == "scenario.manhunters" && slaves <= nonSlaves)
				{
					if (bro.getBackground().getID() != "background.slave")
					{
						bro.worsenMood(this.Const.MoodChange.TooFewSlaves, "Too few indebted in the company");
					}
				}

				this.m.Money -= bro.getDailyCost();
				mood = mood + bro.getMoodState();
			}

			local settlements = ::World.EntityManager.getSettlements();
			foreach( settlement in settlements )
			{
				settlement.onNewDay();
			}

			this.Sound.play(this.Const.Sound.MoneyTransaction[this.Math.rand(0, this.Const.Sound.MoneyTransaction.len() - 1)], this.Const.Sound.Volume.Inventory);
			this.m.AverageMoodState = this.Math.round(mood / roster.len());
			_worldState.updateTopbarAssets();

			if (this.m.EconomicDifficulty >= 1 && this.m.CombatDifficulty >= 1)
			{
				if (this.World.getTime().Days >= 365)
				{
					this.updateAchievement("Anniversary", 1, 1);
				}
				else if (this.World.getTime().Days >= 100)
				{
					this.updateAchievement("Campaigner", 1, 1);
				}
				else if (this.World.getTime().Days >= 10)
				{
					this.updateAchievement("Survivor", 1, 1);
				}
			}
		}

		if (this.World.getTime().Hours != this.m.LastHourUpdated && this.m.IsConsumingAssets)
		{
			this.m.LastHourUpdated = this.World.getTime().Hours;
			this.consumeFood();
			local roster = this.World.getPlayerRoster().getAll();
			local campMultiplier = this.isCamping() ? this.m.CampingMult : 1.0;

			foreach( bro in roster )
			 {
			 	local d = bro.getHitpointsMax() - bro.getHitpoints();

			 	if (bro.getHitpoints() < bro.getHitpointsMax() )
			 	{
					 if (bro.getFlags().has("undead"))
			 		{
			 			bro.setHitpoints(this.Math.minf(bro.getHitpointsMax(), bro.getHitpoints() + (this.Const.World.Assets.HitpointsPerHour / 5) * this.Const.Difficulty.HealMult[this.World.Assets.getEconomicDifficulty()] * this.m.HitpointsPerHourMult));
					}
					else
					{
			 			bro.setHitpoints(this.Math.minf(bro.getHitpointsMax(), bro.getHitpoints() + this.Const.World.Assets.HitpointsPerHour * this.Const.Difficulty.HealMult[this.World.Assets.getEconomicDifficulty()] * this.m.HitpointsPerHourMult ));
					}
			 	}

			 }

			 //local perkMod = 1;

			 foreach( bro in roster )
			 {
				local perkMod = 1.0; // should be here, not outside foreach, otherwise it works like inconsistent mess
				if (this.m.ArmorParts == 0)
				{
					break;
				}
				if (this.isCamping()) //disable in camp, otherwise mess
			 	{
			 		break;
			 	}
			 	local items = bro.getItems().getAllItems();
			 	local updateBro = false;

				local skills =
				[
					"perk.legend_tools_spares",
					"perk.legend_tools_drawers"
				];
				foreach (s in skills)
				{
					local skill = bro.getSkills().getSkillByID(s);
					if (skill != null)
					{
						perkMod = perkMod * (1 - skill.getModifier() * 0.01); // /100 won't work in Squirrel, also should probably be buffed since it only works on the bro's own equipment and only outside of camp
					}
				}

			 	foreach( item in items )
			 	{
			 		if (item.getRepair() < item.getRepairMax())
			 		{
						local d = this.Math.ceil(this.Math.minf(this.Const.World.Assets.ArmorPerHour * this.Const.Difficulty.RepairMult[this.World.Assets.getEconomicDifficulty()] * this.m.RepairSpeedMult, item.getRepairMax() - item.getRepair())); //rounding is crucial because otherwise it repairs nothing but eats tools if below 1, and in any case repair value has to be a round value
						item.onRepair(item.getRepair() + d);
						this.m.ArmorParts = this.Math.maxf(0, this.m.ArmorParts - d * this.m.ArmorPartsPerArmor * perkMod); // * this.Const.Difficulty.RepairMult[this.World.Assets.getEconomicDifficulty()] - doesn't make sense here, it was already used when calculating d
						updateBro = true;
			 		}

			 		if (item.getRepair() >= item.getRepairMax())
			 		{
			 			item.setToBeRepaired(false, 0);
			 		}

			 		if (this.m.ArmorParts == 0)
			 		{
			 			break;
			 		}

					if (updateBro)
					{
						break; //so each bro only repairs 1 item at a time, otherwise too good, makes camp redundant
					}
			 	}

			 	if (updateBro)
			 	{
			 		bro.getSkills().update();
			 	}
			 }

			 local items = this.m.Stash.getItems();
			 local stashmaxrepairpotential = this.Math.ceil(roster.len() * this.Const.Difficulty.RepairMult[this.World.Assets.getEconomicDifficulty()] * this.m.RepairSpeedMult * this.Const.World.Assets.ArmorPerHour); //otherwise fixed version will be too good
			 foreach( item in items )
			 {
				if (this.isCamping()) //disable in camp, otherwise mess
				{
					break;
				}
			 	if (this.m.ArmorParts == 0)
			 	{
			 		break;
			 	}
				if (stashmaxrepairpotential <= 0)
				{
					break;
				}
			 	if (item == null)
			 	{
			 		continue;
			 	}

			 	if (item.isToBeRepaired())
			 	{
			 		if (item.getRepair() < item.getRepairMax())
			 		{
						local d = this.Math.ceil(this.Math.minf(stashmaxrepairpotential, item.getRepairMax() - item.getRepair()));
						item.onRepair(item.getRepair() + d);
						this.m.ArmorParts = this.Math.maxf(0, this.m.ArmorParts - d * this.m.ArmorPartsPerArmor); // * this.Const.Difficulty.RepairMult[this.World.Assets.getEconomicDifficulty()]
						stashmaxrepairpotential = stashmaxrepairpotential - d;
			 		}

			 		if (item.getRepair() >= item.getRepairMax())
			 		{
			 			item.setToBeRepaired(false, 0);
			 		}
			 	}
			 }

			if (this.World.getTime().Hours % 4 == 0)
			{
				this.checkDesertion();
				local towns = this.World.EntityManager.getSettlements();
				local playerTile = this.World.State.getPlayer().getTile();
				local town;

				foreach( t in towns )
				{
					if (t.getSize() >= 2 && !t.isMilitary() && t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
					{
						town = t;
						break;
					}
				}

				foreach( bro in roster )
				{
					bro.recoverMood();

					if (town != null && bro.getMoodState() <= this.Const.MoodState.Neutral)
					{
						bro.improveMood(this.Const.MoodChange.NearCity, "Has enjoyed the visit to " + town.getName());
					}
				}
			}

			_worldState.updateTopbarAssets();
		}

		if (this.World.getTime().Days > this.m.LastDayResourcesUpdated + 7)
		{
			this.m.LastDayResourcesUpdated = this.World.getTime().Days;
			::Legends.Mod.Debug.printLog(format("Day %s: adding resources to each settlement",::World.getTime().Days.tostring()), ::Const.LegendMod.Debug.Flags.WorldEconomy);
			foreach( t in this.World.EntityManager.getSettlements() )
			{
				t.addNewResources();
			}
		}

		// Adds Taro's Turn it in Mod
		local excluded_contracts =
		[
			"contract.patrol",
			"contract.escort_envoy"
		]
		local activeContract = this.World.Contracts.getActiveContract();
		if (activeContract && this.World.FactionManager.getFaction(activeContract.getFaction()).m.Type == this.Const.FactionType.NobleHouse && excluded_contracts.find(activeContract.m.Type) == null &&
		(activeContract.getActiveState().ID == "Return" || (activeContract.m.Type == "contract.big_game_hunt" && activeContract.getActiveState().Flags.get("HeadsCollected") != 0)))
		{
			local contract_faction = this.World.FactionManager.getFaction(activeContract.getFaction());
			local towns = contract_faction.getSettlements();
			if (!activeContract.m.Flags.get("UpdatedBulletpoints"))
			{
				activeContract.m.BulletpointsObjectives.pop();
				if (activeContract.m.Type == "contract.big_game_hunt"){
					activeContract.m.BulletpointsObjectives.push("Return to any town of " + contract_faction.getName() + " to get paid")
				}
				else{
					activeContract.m.BulletpointsObjectives.push("Return to any town of " + contract_faction.getName())
				}
				activeContract.m.Flags.set("UpdatedBulletpoints", true);
				foreach (town in towns)
				{
					town.getSprite("selection").Visible = true;
				}
				this.World.State.getWorldScreen().updateContract(activeContract);
			}
			foreach (town in towns)
			{
				if (activeContract.isPlayerAt(town))
				{
					activeContract.m.Home = this.WeakTableRef(town);
					break
				}
			}
		}
	}

	o.getFormation = function ()
	{
		local ret = [];
		ret.resize(27, null);
		local roster = this.World.getPlayerRoster().getAll();

		foreach( b in roster )
		{
			if (b.getPlaceInFormation() == 255)
			{
				this.logError("Bro has invalid place in formation! :: " + b.m.Name);
				continue;
			}

			ret[b.getPlaceInFormation()] = b;
		}

		return ret;
	}

	o.changeFormation <- function ( _index )
	{

		if (_index == this.m.FormationIndex)
		{
			return;
		}

		if (_index == null) {
			_index = 0;
		}

		local lastIndex = this.m.FormationIndex;
		this.m.FormationIndex = _index;
		local roster = this.World.getPlayerRoster().getAll();

		//Temporarily set Stash to be resizeable -- this is to prevent fully loaded bros stripping gear into a
		//full stash and losing the gear
		//this.World.Assets.getStash().setResizable(true);
		//Save current loadout and strip all gear into stash if moving into a saved formation
		local toTransfer = [];
		foreach (b in roster)
		{
			b.saveFormation();
			b.getItems().transferToList(toTransfer);
		}

		local stash = this.World.Assets.getStash();
		stash.setResizable(true);
		foreach (item in toTransfer)
		{
			stash.add(item);
		}
		stash.setResizable(false);
		//stash.sort()


		//Check if the next Formation has been set, if not, use the previous formation
		if (this.getFormationName() == "NULL")
		{
			this.setFormationName(_index, "Formation " + (_index + 1));
			foreach (b in roster)
			{
				b.copyFormation(lastIndex, _index);
			}
		}

		//All gear now in stash, set new formation and build up the next loadout
		local toTransfer = [];
		foreach (b in roster)
		{
			local transfers = b.setFormation(_index, stash);
			toTransfer.push([b, transfers]);
		}

		foreach (t in toTransfer)
		{
			local bro = t[0];
			foreach( e in t[1][0])
			{
				bro.equipItem(e);
			}

			foreach (b in t[1][1])
			{
				bro.bagItem(b);
			}
		}

		stash.sort();
		this.updateFormation();
	}

	o.clearFormation <- function ()
	{
		local roster = this.World.getPlayerRoster().getAll();

		local toTransfer = [];
		foreach (b in roster)
		{
			b.getItems().transferToList(toTransfer);
			b.saveFormation();
		}

		local stash = this.World.Assets.getStash();
		//Temporarily set Stash to be resizeable -- this is to prevent fully loaded bros stripping gear into a
		//full stash and losing the gear
		stash.setResizable(true);
		foreach (item in toTransfer)
		{
			stash.add(item);
		}
		stash.setResizable(false);
		stash.sort();
		this.updateFormation();
	}

	o.setFormationName <- function (_index, _name)
	{
		if (_name == "")
		{
			return;
		}
		this.m.FormationNames[_index] = _name;
	}

	o.changeFormationName <- function ( _name )
	{
		this.setFormationName(this.m.FormationIndex, _name);
	}

	o.saveEquipment = function ()
	{
		this.m.RestoreEquipment = [];
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			if (bro.getPlaceInFormation() > 27)
			{
				continue;
			}

			local store = {
				ID = bro.getID(),
				Slots = []
			};

			for( local i = this.Const.ItemSlot.Mainhand; i <= this.Const.ItemSlot.Ammo; i = ++i )
			{
				local item = bro.getItems().getItemAtSlot(i);

				if (item != null && item != "-1")
				{
					store.Slots.push({
						Item = item,
						Slot = i
					});
				}
			}

			for( local i = 0; i < bro.getItems().getUnlockedBagSlots(); i = ++i )
			{
				local item = bro.getItems().getItemAtBagSlot(i);

				if (item != null && item != "-1")
				{
					store.Slots.push({
						Item = item,
						Slot = this.Const.ItemSlot.Bag
					});
				}
			}

			this.m.RestoreEquipment.push(store);
		}
	}

	o.restoreEquipment = function ()
	{
		this.World.State.m.AppropriateTimeToRecalc = 0;	//Leonion's fix
		foreach( s in this.m.RestoreEquipment )
		{
			local bro = this.Tactical.getEntityByID(s.ID);

			if (bro == null || !bro.isAlive())
			{
				continue;
			}

			local currentItems = [];
			local itemsHandled = [];
			local overflowItems = [];

			for( local i = this.Const.ItemSlot.Mainhand; i <= this.Const.ItemSlot.Ammo; i = ++i )
			{
				local item = bro.getItems().getItemAtSlot(i);

				if (item != null && item != "-1")
				{
					currentItems.push({
						Item = item,
						Slot = i
					});
					bro.getItems().unequip(item);
				}
			}

			for( local i = 0; i < bro.getItems().getUnlockedBagSlots(); i = ++i )
			{
				local item = bro.getItems().getItemAtBagSlot(i);

				if (item != null && item != "-1")
				{
					currentItems.push({
						Item = item,
						Slot = this.Const.ItemSlot.Bag
					});
					bro.getItems().removeFromBag(item);
				}
			}

			foreach( item in s.Slots )
			{
				local itemExists = false;

				foreach( current in currentItems )
				{
					if (current.Item.getInstanceID() == item.Item.getInstanceID())
					{
						itemExists = true;
						break;
					}
				}

				if (!itemExists)
				{
					continue;
				}

				if (item.Slot == this.Const.ItemSlot.Bag)
				{
					if (!bro.getItems().addToBag(item.Item))
					{
						overflowItems.push(item.Item);
					}

					itemsHandled.push(item.Item.getInstanceID());
				}
				else
				{
					if (!bro.getItems().equip(item.Item))
					{
						overflowItems.push(item.Item);
					}

					itemsHandled.push(item.Item.getInstanceID());
				}
			}

			foreach( item in currentItems )
			{
				if (itemsHandled.find(item.Item.getInstanceID()) != null)
				{
					continue;
				}

				if (item.Item.getCurrentSlotType() == this.Const.ItemSlot.Bag)
				{
					if (!bro.getItems().addToBag(item.Item))
					{
						overflowItems.push(item.Item);
					}
				}
				else if (!bro.getItems().equip(item.Item))
				{
					overflowItems.push(item.Item);
				}
			}

			foreach( item in overflowItems )
			{
				if (itemsHandled.find(item.getInstanceID()) != null)
				{
					continue;
				}

				if (this.m.Stash.add(item) == null)
				{
					bro.getItems().addToBag(item);
				}
			}
		}

		this.m.RestoreEquipment = [];
		this.World.State.m.AppropriateTimeToRecalc = 1;	//Leonion's fix
		this.World.State.getPlayer().calculateModifiers();	//Leonion's fix
	}

	o.getGameFinishData = function ( _gameWon )
	{
		if (this.isIronman())
		{
			this.PersistenceManager.deleteStorage(this.getName() + "_" + this.getCampaignID());
			this.m.IsIronman = false;
		}

		local data = {
			Image = "",
			Text = "",
			Score = "" + this.getScore() + " Points"
		};
		local brothers = this.World.getPlayerRoster().getAll();
		local excludedBackgrounds = [];

		if (!_gameWon || brothers.len() == 0)
		{
			data.Image = "ui/screens/game_lost.jpg";
			data.Text = "{And so it ends.\n\nCrows circle above as the men of the company lie dead or dying, finally having found their match.\n\nThe %companyname% will soon be forgotten, but with no shortage of work for hired swords in this world, there is always the next mercenary band to take their place... | Crows cycle above the corpses of the %companyname%, waiting for looters to clear out so they can finally land and feast. It may have fought hard, but the company will be soon forgotten, washed out in a sea of similar violent venture companies to come. | The company has been slain to the last man. Only crows and worms will be in its future. But with no shortage of work for hired swords in this world, there is always the next mercenary band to take their place... | The %companyname% has been slain to its final man. You and the men gave a spirited effort, but that doesn\'t matter much when you\'re dead. Perhaps a spirited retreat would have been more suitable? | How lucky you\'ve made the worms who now feast upon your failures as mercenary captain of the %companyname%. The men who died here will soon be forgotten, but with no shortage of work for hired swords in this world, there is always the next mercenary band to take their place... | You stare up at a sky of crows, the light in your world slowly dimming away, your dying body an offering so good that creatures gifted the miracle of flight will set it aside to come down and feast on your corpse. | You were supposed to lead the %companyname% to gold and glory. And perhaps some was found, but of what use is it now that you lie dead? | The %companyname% trusted you to bring them glory, riches, and women. Now they\'re all dead on the ground, yourself in their company. They\'ll soon be forgotten by everyone, but with no shortage of work for hired swords in this world, there is always the next mercenary band to take their place... | Crows begin to crowd the skies, blackening it with their shapes, filling it with their sickening squawks. Men come to loot the bodies of you and your men, and so your weapons and gear will continue on, doing biddings beyond your beckoning, beyond your call. | It\'s difficult to say where you had gone wrong. Was it in the last moments, choosing to stand your ground when you should have run? Was it when you took up the sword for the very first time, feeling it swing comfortably in your grip? Of what use was any of it?\n\nThe %companyname% lies dead, but with no shortage of work for hired swords in this world, there is always the next mercenary band to take their place... | A crow lands on your foot, perched there, seeing you through to death with a sexton\'s stare. The rest of the company is laid out across the earth, looters already picking through them for goods to take. | You fought a good fight, at least that\'s what you tell yourself as the light of the world slowly slips away.\n\nThe company\'s name will soon fade from history, but with no shortage of work for hired swords in this world, there is always the next mercenary band to take their place... | You thought death would be like sleeping, but you never remember falling asleep. It just happens. This isn\'t just happening. All you feel is pain. You wish hard for it to stop, and then it does. | The %companyname% has met its match. It isn\'t the first time but, in the past, you respected the facts of the situation. Now you did not and all the men beneath your command have paid for the mistake with their lives. | The %companyname% is dead to the last man. A scribe will hear of its passing and make a note in a gloomy candlelit room. And that note will be lost in a flood and all the ink of the %companyname% will disappear with it. | The blood of the %companyname%\'s men will be transferred into a scribe\'s ink, and all its struggles and sufferings relegated to a footnote to be lost in the dark depths of an archive. | Was this the only way? Surely you could have done something differently. You spend your final moments desperately trying to relive a past in which you are not where you are, seeking a solemn remedy to the cruel finality you are about to experience. | Bodies of the %companyname% litter the field, soon to be fed to the worms and crows, all the armor for naught. The men who died here will soon be forgotten, but with no shortage of work for hired swords in this world, there is always the next mercenary band to take their place... |  What a gift you are, having spent all this time and gold collecting arms and armor for your men, just to give it all away to a bunch of looters. Your bodily donations to the crows and worms will also be well received. Congratulations. | The history of the %companyname% will be forgotten a few years from now. In that moment, a barkeep will be asked about mercenaries and he\'ll pause, thinking it over, and then your face will fade from his memory and your name will pass with it. He will shrug and pour another drink. | As the light leaves your world, you hope that perhaps the name of the %companyname% will live on and that people will remember what they did. They won\'t. | As the pain seizes your body, you simply let the corporeal world go, retreating into your own mind, barricading yourself there, desperately seeking any good reason for why you chose this life, because it seems readily obvious now that the life you chose also chose your death. | The %companyname% is dead to the last man, your corpse amongst the bodies, no rank or order to be followed now. Was it fated? In your death, will others rise? Or will the world be as it always has been? | The cruel finality you have doled out upon others has returned in totality, claiming the lives of the entirety of the %companyname%. Few will speak of you, and certainly no more than the crows who squawk out claims to your corpses. With no shortage of work for hired swords in this world, there is always the next mercenary band to take their place... | The %companyname% has been annihilated to the last brother. Looters now pick through the bodies, calling out what they find with excited surprise. You\'ve made their day, a shame it had to happen in your last.}";
		}
		else if (this.m.BusinessReputation >= 6000 && this.World.Statistics.getFlags().get("GreaterEvilsDefeated") >= 2)
		{
			this.Music.setTrackList(this.Const.Music.Retirement4Tracks, this.Const.Music.CrossFadeTime);
			this.updateAchievement("LeavingALegacy", 1, 1);
			data.Image = "ui/screens/retirement_04.jpg";
			data.Text = "{Your dreams are more realistic than the life you\'ve led! Under your command, not only did the %companyname% reach enormous heights of wealth, honor, and renown, you helped defeat a multitude of evils, invasions, and wars that nearly wrecked the entire realm! | The %companyname% is a name known throughout the land. Not only has it amassed wealth, power, and renown, it has been critical in defeating a number of crises that plagued the land. Scribes and historians will speak of the company so that even thousands of years from now people shall know the %companyname%! | After retiring, a scribe came to you with an artist at his side. They drew a figure of you and wrote down your words onto a very, very long scroll. It appears, having defeated multiple crises and amassed incredible wealth, people many years from now will know the name of the %companyname%. | Leaving the %companyname% wasn\'t easy, but you knew in your heart that it was the right choice. And it couldn\'t have been made at a better time: the company was renowned throughout the land, it had helped defeat a series of crises, and, most crucial of all, had attained unheard of levels of wealth. | Behind your leadership, the %companyname% acquired great fame around the land, not to mention considerable thanks for helping end a series of crises that threatened the entire realm! Mercenaries don\'t often make it into the history books, but you\'ve no doubt that the scribes and scholars will run out of ink writing about the %companyname%!}";
			this.removeSuccessor(brothers);
			data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
			data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
			data.Text += "\n\n{The other day, a hermit came up to your cabin asking if you knew of the %companyname%. You shook your head and feigned interest. The wildman says it is the greatest company in all the land. You asked him if he was totally sure about that. The hermit shrank back as if you\'d insulted him personally.%SPEECH_ON%Am I sure? Mister, you\'d best sit down. Let me tell you all about the %companyname%. First off, they say the man who ran it was seven-feet tall and made of all muscle. Went by the name of...%SPEECH_OFF% | It wasn\'t the easiest move to leave the company behind, but there\'s a room in your keep that lets you swim around in gold crowns so it\'s not too bad. | Now you spend your days not even sure what to do with all your gold. A lot of people come by the keep. Wenches of all shapes and sizes... strange men with even stranger, gold-sucking ideas... and a great deal of cloaked noble princes humbling themselves by asking for advice on warfare. Some days, while chopping away in your garden, you think about getting back into the field. Boredom, as it turns out, is the most sickly and nasty of beasts you\'ve faced yet. | A man came by your keep the other day. He wanted help on starting a mercenary band, obviously taking inspiration from your own feats. You asked how many other successful sellswords he\'d talked to. He shrugged.%SPEECH_ON%You\'re the only one so far.%SPEECH_OFF%You nodded back.%SPEECH_ON%That\'s right. I\'m the only one despite hundreds of men like me having been out there. Maybe it\'s cause I\'m that good, but I think the truth is that I\'m just that lucky. So if you want my advice on starting a mercenary company, don\'t. That\'s all. One of my servants will show you the door. Good day now.%SPEECH_OFF% | While tending to your garden, you find a mouse nibbling on one of your tomatoes. It\'s so buzzed on the flavors you easily capture the rodent and hold it in both hands. Despondent defeatism spreads across its face as you stare at it, half its maw still gnawing away on a bit of tomato. A servant rushes over.%SPEECH_ON%I can rid you of that, my lord.%SPEECH_OFF%You stare at the servant and then back at the mouse.%SPEECH_ON%No, no I think I\'ll keep it. I could use a friend.%SPEECH_OFF%The servant looks down. You slap him on the shoulder.%SPEECH_ON%Cheer up now. You\'re my friend, too!%SPEECH_OFF%The servant smiles.%SPEECH_ON%Thank you, my lord.%SPEECH_OFF%}";
		}
		else if (this.World.Statistics.getFlags().get("GreaterEvilsDefeated") >= 1)
		{
			this.Music.setTrackList(this.Const.Music.Retirement3Tracks, this.Const.Music.CrossFadeTime);
			this.updateAchievement("LeavingAMark", 1, 1);
			data.Image = "ui/screens/retirement_03.jpg";
			this.removeSuccessor(brothers);

			if (this.World.FactionManager.getGreaterEvil().LastType == this.Const.World.GreaterEvilType.CivilWar)
			{
				data.Text = "{Taking over the %companyname%, you had a vision for the company and its men, a vision that ended with you sitting on a king\'s throne and the world\'s most expensive wine sloshing around a golden goblet. That part didn\'t come true, but you did manage to lead the company to great heights in the civil war amongst the nobles.\n\n Such struggles are inevitable amongst the highborn and you took great advantage of the conflict to earn the %companyname% renown and riches. Of course, the brutality of the fighting also taught you that life was short and fickle for a fighting man. Once things settled down, you realized that, to the nobility, it didn\'t matter in the least who you were and what part you played in the conflict. You were just a cog, and you would always be just a cog. Taking that moment of reflection seriously, you decided to retire, leaving the company in about as good of a state as you could. | When you took over the %companyname%, you truly believed you could lead it to greatness. Those goals were probably a bit too lofty, but you did manage to at the very least build a company of incredible renown. As the nobles inevitably slid toward war, it didn\'t surprise you in the least to see that the company\'s services were the most popular in the land. The war proved itself as brutal and horrific as any you\'d ever seen, but at least this time you walked away with more coin than you knew what to do with.\n\n Retiring with your pile of gold, you left the company in the command of the bravest mercenary still alive to take the job. The band continues its success to this day.}";
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += "\n\n{It\'s very rare for a mercenary to leave the life behind with his body intact, but you managed to do just that. While being of sound body and mind are important, you most appreciate the pile of crowns you spend your nights sleeping on. Last you heard, the nobles were squabbling their way into another war and you could not care less. | With good mind and health, you continue to live out the rest of your days in moderate peace. The most awful thing to happen to you in months was when a hermit ventured out of the wilderness to steal your firewood. That\'s the sort of life you always wanted and you could not be happier having it.}";
			}
			else if (this.World.FactionManager.getGreaterEvil().LastType == this.Const.World.GreaterEvilType.Greenskins)
			{
				data.Text = "{When you took over the %companyname%, you did not foresee history rising up to repeat itself in the worst way possible. \'The Battle of Many Names\' was just something you\'d heard about, but to see the impetuous behind it - a great invasion of greenskins - repeat itself in your own lifetime was quite the sight. And you were ready to meet it.\n\n Though the company is unlikely to see very many mentions in the histories of the world, you\'ve no doubt that it proved crucial in defeating the green savages. If not, then why else do you have an enormous pile of gold to speak for?\n\n And it was upon that pile of coin you decided to retire, leaving the outfit in the best hands available. | The Battle of Many Names, that\'s what the scribes called the great clash between all of mankind and the vast hordes of greenskins. You thought those stories were of a bygone age, but the horde of savages pouring over the eastern horizons proved otherwise. This time, the orcs and goblins learned to invade all across the land instead of in one place. Despite their new strategy, the world of man had a new weapon: the %companyname%.\n\n Perhaps it is just your own pride speaking, but you truly believe your company\'s admittedly greedy ventures proved crucial in turning the tides of green back. And with the greenskins defeated, you found yourself with a pile of gold to retire on, leaving the command of the company in the hands of its best and brightest.}";
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += "\n\n{Some nights you wake up, sweat on your head, a berserker\'s growl fading into the stillborn memories of a dream rendered incomplete. These nightmares won\'t leave you alone, proving themselves the ultimate price for your newfound treasures. While the %companyname% is doing well, you sometimes wonder if it\'d be best that you were leading it again. In the \'peace\' of your retirement you\'ve learned that the horrors that you can grab and kill are a world\'s difference from those which lurk amongst your worst fears. | Your days are now spent tending to a garden and slaying the rabbits which venture into your newfound domain. Every so often you\'ll get wind of the %companyname%\'s doings, stories about its successes and, unfortunately, the occasional news that one of the brothers has fallen. These tales are a welcomed respite from days upon days of chasing rabbits out of your garden. You spent so much time fighting, you never realized what wars were waged between men of harvest and these goddam nibbling monsters.}";
			}
			else if (this.World.FactionManager.getGreaterEvil().LastType == this.Const.World.GreaterEvilType.Undead)
			{
				data.Text = "{You thought you understood the cruelties of the world. When you took over the %companyname%, you believed that you could always be sure in leading the company to riches and renown. Dead men coming up out of their graves has a way of defeating this sort of naivety. But you were quick to adapt, earnestly seeking out contracts that would pay the most to deal with this bizarre and surreal threat. The undead hordes were eventually beaten back to whence they came.\n\n Crowns, honor, prestige, they had all been earned. You decided to retire, leaving the company in the trust of its best men. | When you took over the %companyname% you could not have possibly foresaw the future in which it was pivotal in defeating hordes of undead invaders. Unusual bounties on the dead proved incredibly profitable, however, and with a pile of gold made in the wake of the great evil\'s passing, you took the moment to retire. The %companyname% was left in the care of the members you trusted most.}";
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += "\n\n{Nowadays, you spend a good deal of time wondering if you should add a second story to your cabin, or whether that\'s too much work. You could always pay someone else to help, but it just feels strange contracting someone else to the task. And, as far as the %companyname% is concerned, you\'ve heard that it is doing splendidly well to this day. | You spend your days flirting with the neighbor. She\'s married, but that\'s what makes it more fun. The constable came by to speak to you about your newfound proclivities. This is about the height of the drama in your life now. It isn\'t dodging orcs or putting undead souls back into the grave, but it has its own unique sense of fun. You don\'t miss the old life at all. Instead, you can happily sit back and hear of the %companyname%\'s successes.}";
			}
			else if (this.World.FactionManager.getGreaterEvil().LastType == this.Const.World.GreaterEvilType.HolyWar)
			{
				data.Text = "{Commanding the %companyname%, you thought it might play the part of sellsword with a dash of brigandage. Little did you realize that the whole world would be embroiled in religious turmoil. When the north and south turned on each other with their holy furies, you captained the company to opulent ends. If the old gods\' followers asked for your sword, you brought the might and main of the northern mountains. If the Gilded asked for light, you brought the sun. | It is said that the godlier the man, the more human the god. When the religious shatterbelt between north and south exploded, all manner of religious chiselers washed across the holy transom. The sacred sort deified their own spirits, sharpening the utility of war as if it were the gods themselves which commanded it. Perhaps they did, but ultimately all you were concerned about was that the %companyname% serve itself. Gilder? Old gods? All you cared about were your own pockets and by the end of all that holy nonsense they were quite full indeed.}";
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += "\n\n{Few sellsword bands survive, and even fewer yet arrive in the annals of history. You believe that the %companyname%, through action in the holy war, very well may have earned itself a proper footnote. The thought amuses you, for how much can one or two sentences really say about all that you have done and experienced? | With retirement from the %companyname%, you actually find yourself with proper time to mull over these old gods and the Gilder. Maybe there is some truth to one or the other? Perhaps they are both correct. Or, and you weigh these thoughts gingerly, perhaps neither is right. But these faiths are not alone it seems. Religious uprisings are springing up everywhere, cast out in the debris of the religious wars no doubt, and just the other day, a third major entrant arrived, one you\'ve come to be all too knowledgeable about: a Disciple of Davkul. As he professed his thoughts on the dark and the arcane, you shut the door on his face. Maybe another time. You\'ve wood to chop and a sock drawer to organize.}";
			}
		}
		else if (this.m.BusinessReputation >= 1100 && this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			this.Music.setTrackList(this.Const.Music.Retirement2Tracks, this.Const.Music.CrossFadeTime);
			this.updateAchievement("ABitterEnd", 1, 1);
			data.Image = "ui/screens/retirement_02.jpg";

			if (this.Math.rand(1, 100) <= 25)
			{
				data.Text = "You rebuilt well the %companyname%. You worked hard to bolster its ranks with fresh bodies, and you worked even harder to make sure that the name meant something again across the land. When you finally retired, you left %highestbravery_bro% in command of the company and wished him well.\n\nUnder his leadership, the %companyname% did well enough, working wherever there was coin to be made for crossing swords.\n\nThen, several months after your leave, a feud between noble houses escalated. %highestbravery_bro% didn\'t hesistate to seize this opportunity to fill the company\'s coffers with spoils of war, but others chose to seek a different path.";
				this.removeSuccessor(brothers);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, false);
				data.Text += "\n\nNobles play their own dangerous game, and %highestbravery_bro% didn\'t see what was coming. A few successful skirmishes into the war, the %companyname% found themselves pitted against superior numbers with no way out and no reinforcements coming to their aid. They were made a pawn sacrifice, discarded as a ruse to draw out the enemy and strike elsewhere. Mercenaries are easily replaced, and dead ones don\'t ask to be paid, after all. It was a battle of little consequence to the war, but it was a devastating defeat for the company from which it never recovered.\n\nThe war raged on for another two years, but few still remembered the name \'%companyname%\' when it was over...";
			}
			else
			{
				data.Text = "{Having built the %companyname% to notable name recognition in the realms, the lords would bid against one another for your services, not only so you\'d fight for them, but so they\'d know at the very least they would not have to fight against you! With the crowns rolling in, and faith that the company would do well without you, it just seemed the proper time to put the sword away and retire to a life outside of war and killing.\n\nUnfortunately, such popularity comes at a cost. The company kept falling into war-time contracts and, over time, was ground down. Brothers started to leave lest they become victim to the next nobleman who thought they knew best how to command the mercenaries. | After you left the company, seeking out a more docile life in the hills, you heard that the %companyname% grew in popularity amongst the nobility. With every war, counts and barons would seek out the company\'s services. However, with such popularity comes a price. Every new conflict, every new war, they would not come without losses. Slowly, but surely, the company\'s power dwindled, its numbers depleting either through casualties or men leaving to strike out like you did before it was too late. Last you heard, the company was almost wholly destroyed when a highborn commander used it for a frontal assault. | When you took over the %companyname%, it was a mere handful of men scrambling to survive. Now it\'s more akin to a boisterous business adventure. But staying the business of killing was never your goal in life. With enough money, you retired away and left the company in charge of %successor%, one of your most trusted men.\n\n Unfortunately, your successors didn\'t quite have the knack for keeping the men safe. Last you heard, they took contract after contract, forever seeking more and more crowns with no regard for their own safety. This aggressive pursuit of the coin eventually lead to the company\'s destruction in a battle between noble houses. Despite the %companyname%\'s reputation, a noble baron had no problem using it as bait to draw out a much larger force. Thankfully, a few men did manage to retire just before this battle.}";
				this.removeSuccessor(brothers);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, false);
				data.Text += "\n\n{But that\'s just business for mercenaries. Some make it, some don\'t. No company lives forever and fewer yet will see so much as a line of mention in the history books. You plan to comfortably live out the rest of your days and hope those who survived their time in sellswording do the same. | And that\'s just the mercenary\'s life. Some win, some lose. Well, most just lose. You try to put that past out of mind and go on to live the rest of your days in peace. | Now that\'s just how it is for mercenaries. The only thing that\'s safe about mercenary work is the understanding that not everyone is going to make it out alive. Everyone knows this when they sign on, yourself included. You got lucky, others did not. That\'s just how it is. You plan to live out the rest of your days as well as you can, not only for yourself, but for those that didn\'t make it.}";
			}
		}
		else
		{
			this.Music.setTrackList(this.Const.Music.Retirement1Tracks, this.Const.Music.CrossFadeTime);
			this.updateAchievement("EarlyRetirement", 1, 1);
			data.Image = "ui/screens/retirement_01.jpg";
			data.Text = "{Without your leadership, the %companyname% quickly broke apart. Everyone went their own way, but what is a man supposed to do whose only real talent is fighting? | The %companyname% fell apart not long after your retirement. The new leadership chose poorly with its contracts and proved to be an even poorer commander in battle. When making money and winning battles is your business, it\'s not that surprising the company failed shortly after your departure. | With you no longer leading it, the %companyname% acquired a series of poor contracts that eventually lead to it breaking apart. | You decided to retire from fighting before it got to you like it gets to everyone else - with a sword and an embarrassingly bloodcurdling scream. One of the brothers took over, but while they were great sellswords, there\'s a world of difference between battling and leading. The %companyname% suffered a series of bad contracts and even worse battles leading to its eventual demise. | Your decision to retire did not come easy, neither for you nor the %companyname% which desperately argued for you to stay. But the time had come and so you went. One of the mercenaries took over as head of the band, but being a good fighter does not make you a great leader and the company soon dissolved. | The mercenaries tried to get you to stay, but you felt it was time to retire from fighting altogether. Last you heard, the %companyname%\'s new commander was fooled into a horrible contract. The money wasn\'t right, and the battle itself went south in a real hurry. The company completely broke apart not long after this misstep.}";
			data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, false);
			data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, false);
			data.Text += "\n\n{You haven\'t gotten word from the others, but then, you have your own concerns now that you\'re retired and your savings are running low... | Now that you are sitting in squalor, a small candle\'s flame your only company, you\'re beginning to regret your decision. Things have not gone well for you and the stories of the men you left behind has troubled you greatly. | Now you sit in a shack with a crowd of sleeping strangers crowding for warmth. Using a faint candlelight, you stare at the frayed sigil of the %companyname%. You thumb it back and forth, reliving fond memories to overcome this new poverty, until someone coughs and the light goes out. | Now you sit in the basement of a tavern, sleeping amongst vagrants and vagabonds who\'ve no coin to afford a room just for themselves. You want to get back into mercenary work, but with no coin you\'ll have to work from the bottom up, probably soldiering beneath some incompetent commander. Death by poverty or death by ineptitude, those seem to be your choices now. | Now you\'re sitting in a tavern by yourself, putting the last of your coin into a horn of ale. As you down the drink, a tall man enters the pub. Slabs of leather-founded ringmail are stacked on his pants, shoulders, and chest. There\'s a gold-handled weapon in a silver embroidered sheath. Standing straight with his fists at his hips, he stares about the room.%SPEECH_ON%Which of you men would be keen on killing for coin, hm? I\'m looking for sellswords. All I ask is that you know how to swing a sword and that you can\'t be afraid of one being swung at you.%SPEECH_OFF%You finish your drink and the mercenary turns to you, as though he already knows who you are and what you are capable of. | Word of the others is hard to find. After a few months, you give up on trying to figure out where they are or how they\'re doing. Instead, you watch your savings slowly dwindle, spending each night fighting off the doubts and thoughts as to why you made this choice in the first place.}";
		}

		data.Text += "\n\n";
		data.Text = this.buildGameFinishText(data.Text);
		return data;
	}

	o.addBrotherEnding = function ( _brothers, _excludedBackgrounds, _isPositive )
	{
		local removeIndex;
		local candidates = [];

		foreach( i, bro in _brothers )
		{
			if (_excludedBackgrounds.find(bro.getBackground().getID()) != null)
			{
				continue;
			}

			if (_isPositive && bro.getBackground().getGoodEnding() != null)
			{
				candidates.push({
					Index = i,
					Bro = bro
				});
			}
			else if (!_isPositive && bro.getBackground().getBadEnding() != null)
			{
				candidates.push({
					Index = i,
					Bro = bro
				});
			}
		}

		if (candidates.len() == 0)
		{
			return "";
		}

		local bro = candidates[this.Math.rand(0, candidates.len() - 1)];
		_brothers.remove(bro.Index);
		_excludedBackgrounds.push(bro.Bro.getBackground().getID());
		local villages = this.World.EntityManager.getSettlements();
		local nobleHouses = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local vars = [
			[
				"SPEECH_ON",
				"\n\n[color=#bcad8c]\""
			],
			[
				"SPEECH_OFF",
				"\"[/color]\n\n"
			],
			[
				"companyname",
				this.World.Assets.getName()
			],
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomnoblehouse",
				nobleHouses[this.Math.rand(0, nobleHouses.len() - 1)].getName()
			],
			[
				"randomnoble",
				this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]
			],
			[
				"randomtown",
				villages[this.Math.rand(0, villages.len() - 1)].getNameOnly()
			],
			[
				"name",
				bro.Bro.getNameOnly()
			]
		];

		this.Const.LegendMod.extendVarsWithPronouns(vars, bro.Bro.getGender());

		if (_isPositive)
		{
			return "\n\n" + this.buildTextFromTemplate(bro.Bro.getBackground().getGoodEnding(), vars);
		}
		else
		{
			return "\n\n" + this.buildTextFromTemplate(bro.Bro.getBackground().getBadEnding(), vars);
		}
	}

	o.getRosterDescription <- function ()
	{
		local ret = {
			TerrainModifiers = [],
			Brothers = []
		}

		for (local i=0; i < 11; i=++i)
		{
			ret.TerrainModifiers.push(["", 0]);
		}

		foreach (bro in this.World.getPlayerRoster().getAll())
		{
			local terrains = bro.getBackground().getModifiers().Terrain;
			ret.TerrainModifiers[0][0] = "Plains";
			ret.TerrainModifiers[0][1] += terrains[2] * 100.0;

			ret.TerrainModifiers[1][0] = "Swamp";
			ret.TerrainModifiers[1][1] += terrains[3] * 100.0;

			ret.TerrainModifiers[2][0] = "Hills";
			ret.TerrainModifiers[2][1] += terrains[4] * 100.0;

			ret.TerrainModifiers[3][0] = "Forests";
			ret.TerrainModifiers[3][1] += terrains[5] * 100.0;

			ret.TerrainModifiers[4][0] = "Mountains";
			ret.TerrainModifiers[4][1] += terrains[9] * 100.0;

			ret.TerrainModifiers[5][0] = "Farmland";
			ret.TerrainModifiers[5][1] += terrains[11] * 100.0;

			ret.TerrainModifiers[6][0] = "Snow";
			ret.TerrainModifiers[6][1] += terrains[12] * 100.0;

			ret.TerrainModifiers[7][0] = "Highlands";
			ret.TerrainModifiers[7][1] += terrains[14] * 100.0;

			ret.TerrainModifiers[8][0] = "Stepps";
			ret.TerrainModifiers[8][1] += terrains[15] * 100.0;

			ret.TerrainModifiers[9][0] = "Deserts";
			ret.TerrainModifiers[9][1] += terrains[17] * 100.0;

			ret.TerrainModifiers[10][0] = "Oases";
			ret.TerrainModifiers[10][1] += terrains[18] * 100.0;

			ret.Brothers.push({
				Name = bro.getName(),
				Mood = this.Const.MoodStateIcon[bro.getMoodState()],
				Level = bro.getLevel(),
				Background = bro.getBackground().getNameOnly()
			});
		}

		local sortfn = function (first, second)
		{
			if (first.Level == second.Level)
			{
				return 0
			}
			if (first.Level > second.Level)
			{
				return -1
			}
			return 1
		}
		ret.Brothers.sort(sortfn);
		return ret;
	}


	o.updateLook = function ( _updateTo = -1 )
	{
		if (_updateTo != -1)
			this.m.Look = _updateTo;

		this.World.State.getPlayer().setBaseImage(this.m.Look);

		if ("updateLook" in this.World.Assets.getOrigin())
			this.World.Assets.getOrigin().updateLook();
	}

	local init = o.init;
	o.init = function()
	{
		init();

		if ("World" in this.getroottable() && "State" in ::World)
			::World.State.m.Camp.init(); //
	}

	o.onSerialize = function ( _out )
	{
		_out.writeU16(this.m.Stash.getCapacity());
		this.m.Stash.onSerialize(_out);
		_out.writeI32(this.m.CampaignID);
		_out.writeString(this.m.Name);
		_out.writeString(this.m.Banner);
		_out.writeU8(this.m.BannerID);
		_out.writeU8(this.m.Look);
		_out.writeU8(this.m.EconomicDifficulty);
		_out.writeU8(this.m.CombatDifficulty);
		_out.writeBool(this.m.IsIronman);
		_out.writeBool(!this.m.IsPermanentDestruction);
		_out.writeString(this.m.Origin.getID());
		_out.writeString(this.m.SeedString);
		_out.writeF32(this.m.Money);
		_out.writeF32(this.m.Ammo);
		_out.writeF32(this.m.ArmorParts);
		_out.writeF32(this.m.Medicine);
		_out.writeU32(this.m.BusinessReputation);
		_out.writeF32(this.m.MoralReputation);
		_out.writeF32(this.m.Score);
		_out.writeU16(this.m.LastDayPaid);
		_out.writeU8(this.m.LastHourUpdated);
		_out.writeF32(this.m.LastFoodConsumed);
		_out.writeBool(this.m.IsCamping);
		_out.writeU8(this.m.FormationIndex);
		foreach( name in this.m.FormationNames)
		{
			_out.writeString(name);
		}
		_out.writeU8(this.m.BrothersMax);
		_out.writeU16(this.m.LastDayResourcesUpdated);
	}

	o.onDeserialize = function ( _in )
	{
		this.m.Stash.resize(_in.readU16());
		this.m.Stash.onDeserialize(_in);

		if (this.m.OverflowItems.len() != 0)
		{
			foreach( item in this.m.OverflowItems )
			{
				this.m.Stash.add(item);
			}

			this.m.OverflowItems = [];
		}

		this.m.CampaignID = _in.readI32();
		this.m.Name = _in.readString();
		this.m.Banner = _in.readString();
		this.m.BannerID = _in.readU8();
		this.m.Look = _in.readU8();
		this.m.EconomicDifficulty = _in.readU8();
		this.m.CombatDifficulty = _in.readU8();
		this.m.IsIronman = _in.readBool();
		this.m.IsPermanentDestruction = !_in.readBool();

		if (_in.getMetaData().getVersion() >= 46)
		{
			this.m.Origin = _in.readString();
			this.m.Origin = this.Const.ScenarioManager.getScenario(this.m.Origin);
		}

		if (this.m.Origin == null)
		{
			this.m.Origin = this.Const.ScenarioManager.getScenario("scenario.tutorial");
		}

		if (_in.getMetaData().getVersion() >= 41)
		{
			this.m.SeedString = _in.readString();
		}
		else
		{
			_in.readI32();
			this.m.SeedString = "Unknown";
		}

		if (_in.getMetaData().getVersion() < 64 && this.m.Origin != null && this.m.Origin.getID() == "scenario.manhunters")
		{
			this.m.Stash.add(this.new("scripts/items/misc/manhunters_ledger_item"));
		}

		this.m.Money = _in.readF32();
		this.m.Ammo = this.Math.max(0, _in.readF32());
		this.m.ArmorParts = this.Math.max(0, _in.readF32());
		this.m.Medicine = this.Math.max(0, _in.readF32());
		this.m.BusinessReputation = _in.readU32();
		this.m.MoralReputation = _in.readF32();
		this.m.Score = _in.readF32();
		this.m.LastDayPaid = _in.readU16();
		this.m.LastHourUpdated = _in.readU8();
		this.m.LastFoodConsumed = _in.readF32();
		this.m.IsCamping = _in.readBool();

		if (_in.getMetaData().getVersion() >= 46 )
		{
			this.m.FormationIndex = _in.readU8();
		}

		if (_in.getMetaData().getVersion() >= 47 )
		{
			for( local i = 0; i < this.Const.LegendMod.Formations.Count; i = ++i )
			{
				this.setFormationName(i, _in.readString())
			}
		}
		local maxBros = _in.readU8(); //Deprecated, but kept for backwards save compatibility. It is now dynamically calculated
		this.m.LastDayResourcesUpdated = _in.readU16();

		this.updateAverageMoodState();
		this.updateFood();
		this.updateFormation();
		this.m.Origin.onInit();
	}
});
