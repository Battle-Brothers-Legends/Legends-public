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

	o.m.IsArenaTooled <- false;

	o.m.HasDrillSergeant <- 0;
	o.m.HasScholars <- 0;
	o.m.HasVeterinarian <- 0;

	o.getArmorPartsF <- function()
	{
		return this.m.ArmorParts;
	}

	o.getMaxAmmo <- function()
	{
		local ammo = this.Const.LegendMod.MaxResources[this.m.EconomicDifficulty].Ammo;
		//this.Const.Difficulty.MaxResources[this.m.EconomicDifficulty].Ammo + this.m.AmmoMaxAdditional
		ammo += this.m.AmmoMaxAdditional;
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

	local addBusinessReputation = o.addBusinessReputation;
	o.addBusinessReputation = function( _f )
	{
		local original = this.m.BusinessReputationRate;
		if (::World.Retinue.hasFollower("follower.minstrel"))
			this.m.BusinessReputationRate *= 1.25; // should be taken into account (blacksmith influence)
		addBusinessReputation(_f);
		this.m.BusinessReputationRate = original;
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

	o.refillAmmo = function()
	{
		if (m.Ammo == 0)
			return;

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster ) {
			local items = bro.getItems().getAllItems();
			foreach( item in items ) {
				if ((item.isItemType(this.Const.Items.ItemType.Ammo) || ("getAmmo" in item && "getAmmoMax" in item)) && (item.getAmmo() < item.getAmmoMax())) {
					local a = this.Math.min(this.m.Ammo, this.Math.ceil(item.getAmmoMax() - item.getAmmo()) * item.getAmmoCost());

					if (this.m.Ammo >= a) {
						item.setAmmo(item.getAmmo() + this.Math.ceil(a / item.getAmmoCost()));
						this.m.Ammo -= a;
					}
				}

				if (this.m.Ammo == 0) {
					break;
				}
			}
		}

		local repairNet = false;
		foreach( bro in roster )
		{
			if (bro.getFlags().get("LegendsCanRepairNet")) {
				::World.Statistics.getFlags().set("LegendsCanRepairNet", true);
				break;
			}
		}

		foreach (item in getStash().getItems())
		{
			if (item == null)
				continue;

			if (!item.isItemType(::Const.Items.ItemType.Net) || !item.isItemType(::Const.Items.ItemType.Ammo) || item.getAmmo() >= item.getAmmoMax())
				continue;

			local ammoCost = item.getAmmoCost();
			if (item.isItemType(::Const.Items.ItemType.Net) && ::World.Statistics.getFlags().get("LegendsCanRepairNet"))
			{
				ammoCost -= 5;
			}
			local a = ::Math.min(this.m.Ammo, ::Math.ceil(item.getAmmoMax() - item.getAmmo()) * ammoCost);

			if (this.m.Ammo >= a) {

				item.setAmmo(item.getAmmo() + ::Math.ceil(a / ammoCost));
				this.m.Ammo -= a;
			}

			if (this.m.Ammo == 0)
				break;
		}

		if (this.World.State.getCurrentTown() != null) {
			this.World.State.getTownScreen().updateAssets();
		}
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

	local addBusinessReputation = o.addBusinessReputation;
	o.addBusinessReputation = function ( _f )
	{
		if (_f < 0) {
			if (this.m.BusinessReputation < 250) _f = 0;
			else if (this.m.BusinessReputation >= 250 && this.m.BusinessReputation < 500) _f = ::Math.round(0.5 * _f);
		}
		addBusinessReputation(_f);
		this.m.BusinessReputationMax = this.Math.max(this.m.BusinessReputation, this.m.BusinessReputationMax);
	}

	// overwriting due to certain options
	local setCampaignSettings = o.setCampaignSettings;
	o.setCampaignSettings = function ( _settings )
	{
		this.getStash().setResizable(true); // to make sure all starting item to be added without issue

		if (!("IsExplorationMode" in _settings))
			_settings.IsExplorationMode <- false;

		setCampaignSettings(_settings);
		this.calculateStartingStashSize(_settings);

		/* probably don't need this as legendary economic makes all starting resources to be 0 afterall
		if (_settings.BudgetDifficulty == this.Const.Difficulty.Legendary &&
			this.m.Money == 0 &&
			this.m.Ammo == 0 &&
			this.m.ArmorParts == 0 &&
			this.m.Medicine == 0
		) {
			this.m.Money = this.Const.LegendMod.StartResources[_settings.BudgetDifficulty].Money;
			this.m.Ammo = this.Const.LegendMod.StartResources[_settings.BudgetDifficulty].Ammo;
			this.m.ArmorParts = this.Const.LegendMod.StartResources[_settings.BudgetDifficulty].ArmorParts;
			this.m.Medicine = this.Const.LegendMod.StartResources[_settings.BudgetDifficulty].Medicine;
		}
		*/
		this.m.LastRosterSize = this.World.getPlayerRoster().getSize();
	}

	o.calculateStartingStashSize <- function( _settings )
	{
		local size = ::Const.LegendMod.MaxResources[_settings.EconomicDifficulty].Stash + ::World.Assets.getOrigin().getStashModifier();
		this.getStash().setResizable(false); // turn off the infinite stash size
		this.getStash().sort();
		this.getStash().resize(size);
		::Legends.Stash.setStartingSize(size);
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
			this.m.FormationNames.push(i == 0 ? "Formation 1" : "NULL");
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
					if (bro.getSkills().hasTrait(::Legends.Trait.Greedy))
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
					if (bro.getSkills().hasTrait(::Legends.Trait.Spartan))
					{
						bro.worsenMood(this.Const.MoodChange.NotEatenSpartan, "Went hungry");
					}
					else if (bro.getSkills().hasTrait(::Legends.Trait.Gluttonous))
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

			local toolEfficiency = ::Legends.S.getToolEfficiency();
			foreach (bro in roster) {
				if (this.m.ArmorParts == 0) {
					break;
				}

				// Camp repair is handled in `repair_building.nut`
				if (this.isCamping()) {
			 		break;
			 	}

			 	local items = bro.getItems().getAllItems();
				local updateBro = false;

				foreach (item in items) {
					if (item.getRepair() < item.getRepairMax()) {
						local d = this.Math.ceil(this.Math.minf(this.Const.World.Assets.ArmorPerHour * this.Const.Difficulty.RepairMult[this.World.Assets.getEconomicDifficulty()] * this.m.RepairSpeedMult, item.getRepairMax() - item.getRepair())); //rounding is crucial because otherwise it repairs nothing but eats tools if below 1, and in any case repair value has to be a round value
						if (::World.Retinue.hasFollower("follower.blacksmith")) {
							// Round blacksmith bonus for better determinism
							d = this.Math.ceil(d * 1.33);
						}
						item.onRepair(item.getRepair() + d);
						// Round to 3 decimal places for better determinism
						local toolsUsed = this.Math.round(d * this.m.ArmorPartsPerArmor * toolEfficiency * 1000.0) / 1000.0;
						this.m.ArmorParts = this.Math.maxf(0, this.m.ArmorParts - toolsUsed);
						updateBro = true;
			 		}

			 		if (item.getRepair() >= item.getRepairMax()) {
			 			item.setToBeRepaired(false, 0);
			 		}

			 		if (this.m.ArmorParts == 0) {
			 			break;
			 		}

					// Can only repair as many items at the same time as there are bros in the roster
					if (updateBro) {
						break;
					}
				}

				if (updateBro) {
					bro.getSkills().update();
				}
			 }

			 local items = this.m.Stash.getItems();
			 local stashmaxrepairpotential = this.Math.ceil(roster.len() * this.Const.Difficulty.RepairMult[this.World.Assets.getEconomicDifficulty()] * this.m.RepairSpeedMult * this.Const.World.Assets.ArmorPerHour); //otherwise fixed version will be too good
			 if (::World.Retinue.hasFollower("follower.blacksmith"))
				stashmaxrepairpotential *= 1.33; // should be taken into account (blacksmith influence)
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
						// Round to 3 decimal places for better determinism
						local toolsUsed = this.Math.round(d * this.m.ArmorPartsPerArmor * toolEfficiency * 1000.0) / 1000.0;
						this.m.ArmorParts = this.Math.maxf(0, this.m.ArmorParts - toolsUsed);
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
		local excluded_contracts = [
			"contract.patrol",
			"contract.escort_envoy"
		];
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
		local maxSlot = 27, ret = [];
		ret.resize(maxSlot, null);
		local roster = this.World.getPlayerRoster().getAll();

		foreach( b in roster )
		{
			if (b.getPlaceInFormation() >= maxSlot)
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
			return;

		if (_index == null)
			_index = 0;

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
		if (_name != "")
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

		::Const.LegendMod.extendVarsWithPronouns(vars, bro.Bro);

		if (_isPositive)
		{
			return "\n\n" + this.buildTextFromTemplate(bro.Bro.getBackground().getGoodEnding(), vars);
		}
		else
		{
			return "\n\n" + this.buildTextFromTemplate(bro.Bro.getBackground().getBadEnding(), vars);
		}
	}

	o.getRosterDescription <- function () {
		local terrainIDs = [2, 3, 4, 5, 9, 11, 12, 14, 15, 17, 18];

		local ret = {
			TerrainModifiers = [
				["Plains", ::Const.World.TerrainTypeSpeedMult[2]],
            	["Swamp", ::Const.World.TerrainTypeSpeedMult[3]],
            	["Hills", ::Const.World.TerrainTypeSpeedMult[4]],
            	["Forests", ::Const.World.TerrainTypeSpeedMult[5]],
            	["Mountains", ::Const.World.TerrainTypeSpeedMult[9]],
            	["Farmland", ::Const.World.TerrainTypeSpeedMult[11]],
            	["Snow", ::Const.World.TerrainTypeSpeedMult[12]],
            	["Highlands", ::Const.World.TerrainTypeSpeedMult[14]],
            	["Steppes", ::Const.World.TerrainTypeSpeedMult[15]],
            	["Deserts", ::Const.World.TerrainTypeSpeedMult[17]],
            	["Oases", ::Const.World.TerrainTypeSpeedMult[18]]
			],
			Brothers = []
		}

		foreach (bro in ::World.getPlayerRoster().getAll()) {
			local terrains = bro.getBackground().getModifiers().Terrain;
			for (local i = 0; i < terrainIDs.len(); ++i) {
            	ret.TerrainModifiers[i][1] += terrains[terrainIDs[i]];
        	}

			ret.Brothers.push({
				Name = bro.getName(),
				Mood = ::Const.MoodStateIcon[bro.getMoodState()],
				Level = bro.getLevel(),
				Background = bro.getBackground().getNameOnly()
			});
		}

		if (this.World.Retinue.hasFollower("follower.scout")) {
			for (local i = 0; i < terrainIDs.len(); ++i) {
				local terrainBaseSpeed = ::Const.World.TerrainTypeSpeedMult[terrainIDs[i]];
				if (terrainBaseSpeed <= 0.65 && terrainBaseSpeed > 0.0) {
					ret.TerrainModifiers[i][1] *= (terrainBaseSpeed + 0.15) / terrainBaseSpeed;
				}
			}
		}

		local globalMultiplier = 1.0;
		foreach (bro in ::World.getPlayerRoster().getAll()) {
			if (bro.getSkills().hasPerk(::Legends.Perk.LegendWheelMaintenance)) {
				globalMultiplier += 0.05;
			}
		}

		foreach (terrain in ret.TerrainModifiers) {
            terrain[1] *= globalMultiplier * 100.0;
        }

		local sortfn = function (first, second)
		{
			if (first.Level == second.Level) {
				return 0
			}
			if (first.Level > second.Level)	{
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

	local onSerialize = o.onSerialize;
	o.onSerialize = function ( _out )
	{
		onSerialize(_out);
		_out.writeU8(this.m.FormationIndex);
		foreach( name in this.m.FormationNames)
		{
			_out.writeString(name);
		}
		_out.writeU16(this.m.LastDayResourcesUpdated);
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		onDeserialize(_in);
		this.m.FormationIndex = _in.readU8();
		for (local i = 0; i < this.Const.LegendMod.Formations.Count; i++)
		{
			this.setFormationName(i, _in.readString())
		}
		this.m.LastDayResourcesUpdated = _in.readU16();
	}

});
