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

	o.m.ProfessionEffect <- {}

	o.getArmorPartsF <- function()
	{
		return this.m.ArmorParts;
	}

	o.getMaxAmmo <- function()
	{
		local ammo = ::Const.LegendMod.MaxResources[this.m.EconomicDifficulty].Ammo;
		//::Const.Difficulty.MaxResources[this.m.EconomicDifficulty].Ammo + this.m.AmmoMaxAdditional
		ammo += this.m.AmmoMaxAdditional;
		ammo += ::World.State.getPlayer().getAmmoModifier();
		return ammo;
	}

	o.getMaxArmorParts <- function()
	{
		local parts = ::Const.LegendMod.MaxResources[this.m.EconomicDifficulty].ArmorParts;
		parts += this.m.ArmorPartsMaxAdditional; //::Const.Difficulty.MaxResources[this.m.EconomicDifficulty].ArmorParts + this.m.MedicineMaxAdditional
		parts += ::World.State.getPlayer().getArmorPartsModifier();
		return parts;
	}

	o.getMaxMedicine <- function()
	{
		local meds = ::Const.LegendMod.MaxResources[this.m.EconomicDifficulty].Medicine;
		//::Const.Difficulty.MaxResources[this.m.EconomicDifficulty].Ammo
		meds += this.m.MedicineMaxAdditional;
		meds += ::World.State.getPlayer().getMedsModifier();
		return meds;
	}

	local addBusinessReputation = o.addBusinessReputation;
	o.addBusinessReputation = function( _f )
	{
		local original = this.m.BusinessReputationRate;
		if (::World.Assets.m.ProfessionEffect.LegendBalladeInTheMaking > 0)
			this.m.BusinessReputationRate *= (1 + ::World.Assets.m.ProfessionEffect.LegendBalladeInTheMaking);
		addBusinessReputation(_f);
		this.m.BusinessReputationRate = original;
	}

	o.getBusinessReputationMax <- function()
	{
		return this.m.BusinessReputationMax;
	}

	o.getBrothersMax = function ()
	{
		return ::Const.Roster.getSizeForTier(::World.Assets.getOrigin().getRosterTier());
	}

	o.getBrothersMaxInCombat = function ()
	{
		return ::Const.Roster.getInCombatSizeForTier(::World.Assets.getOrigin().getRosterTierCombat());
	}

	o.getBrothersScaleMax = function ()
	{
		return ::Math.min(25, this.m.BrothersScaleMax);
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
		return ::World.Camp.isCamping();
	}

	o.setCamping = function( _c )
	{
		::World.Camp.onCamp();
	}

	o.setAmmo = function( _f )
	{
		this.m.Ammo = ::Math.min(::Math.max(0, _f), this.getMaxAmmo());
		this.refillAmmo();
	}

	o.checkDesertion = function () {
		if (!::World.Events.canFireEvent()) {
			return;
		}

		local candidates = [];

		foreach (bro in ::World.getPlayerRoster().getAll()) {
			if (bro.getDailyCost() == 0 || bro.getSkills().hasTrait(::Legends.Trait.Player)) {
				continue;
			}

			if (bro.getMood() < 1.0) {
				local chance = (1.0 - bro.getMood()) * 100;

				if (bro.getSkills().hasTrait(::Legends.Trait.Loyal)) {
					chance *= 0.5;
				} else if (bro.getSkills().hasTrait(::Legends.Trait.Disloyal)) {
					chance *= 2.0;
				}

				if (bro.getBackground().getID() == ::Legends.Backgrounds.getID(::Legends.Background.Companion)) {
					chance *= 0.5;
				}

				if (::World.Assets.m.ProfessionEffect.LegendAmusingOurselvesToDeath > 0) {
					chance *= 0.5;
				}

				if (::Math.rand(1, 100) <= chance) {
					candidates.push(bro);
				}
			}
		}

		if (candidates.len() != 0) {
			local bro = candidates[::Math.rand(0, candidates.len() - 1)];

			if (::World.getPlayerRoster().getSize() > 1) {
				local event = ::World.Events.getEvent("event.desertion");
				event.setDeserter(bro);
				::World.Events.fire("event.desertion", false);
			} else {
				::World.State.showGameFinishScreen(false);
			}
		}
	}

	o.refillAmmo = function()
	{
		if (this.m.Ammo == 0)
			return;

		local roster = ::World.getPlayerRoster().getAll();

		foreach( bro in roster ) {
			local items = bro.getItems().getAllItems();
			foreach( item in items ) {
				if ((item.isItemType(::Const.Items.ItemType.Ammo) || ("getAmmo" in item && "getAmmoMax" in item)) && (item.getAmmo() < item.getAmmoMax())) {
					local a = ::Math.min(this.m.Ammo, ::Math.ceil(item.getAmmoMax() - item.getAmmo()) * item.getAmmoCost());

					if (this.m.Ammo >= a) {
						item.setAmmo(item.getAmmo() + ::Math.ceil(a / item.getAmmoCost()));
						this.m.Ammo -= a;
					}
				}

				if (this.m.Ammo == 0) {
					break;
				}
			}
		}

		foreach( bro in roster )
		{
			if (bro.getFlags().get("LegendsCanRepairNet")) {
				::World.Statistics.getFlags().set("LegendsCanRepairNet", true);
				break;
			}
		}

		foreach (item in this.getStash().getItems())
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

		if (::World.State.getCurrentTown() != null) {
			::World.State.getTownScreen().updateAssets();
		}
	}

	o.setArmorParts = function( _f )
	{
		this.m.ArmorParts = ::Math.min(::Math.max(0, _f), this.getMaxArmorParts());
	}

	o.setMedicine = function( _f )
	{
		this.m.Medicine = ::Math.min(::Math.max(0, _f), this.getMaxMedicine());
	}

	o.addAmmo = function( _f )
	{
		this.m.Ammo = ::Math.min(::Math.max(0, this.m.Ammo + _f), this.getMaxAmmo());
	}

	o.addArmorParts = function( _f )
	{
		this.m.ArmorParts = ::Math.min(::Math.max(0, this.m.ArmorParts + _f), this.getMaxArmorParts());
	}

	o.addArmorPartsF <- function( _f )
	{
		this.m.ArmorParts = ::Math.minf(::Math.maxf(0, this.m.ArmorParts + _f), this.getMaxArmorParts());
	}

	o.addMedicine = function( _f )
	{
		this.m.Medicine = ::Math.min(::Math.max(0, this.m.Medicine + _f), this.getMaxMedicine());
	}

	local addBusinessReputation = o.addBusinessReputation;
	o.addBusinessReputation = function ( _f )
	{
		if (_f < 0) {
			if (this.m.BusinessReputation < 250) _f = 0;
			else if (this.m.BusinessReputation >= 250 && this.m.BusinessReputation < 500) _f = ::Math.round(0.5 * _f);
		}
		addBusinessReputation(_f);
		this.m.BusinessReputationMax = ::Math.max(this.m.BusinessReputation, this.m.BusinessReputationMax);
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
		if (_settings.BudgetDifficulty == ::Const.Difficulty.Legendary &&
			this.m.Money == 0 &&
			this.m.Ammo == 0 &&
			this.m.ArmorParts == 0 &&
			this.m.Medicine == 0
		) {
			this.m.Money = ::Const.LegendMod.StartResources[_settings.BudgetDifficulty].Money;
			this.m.Ammo = ::Const.LegendMod.StartResources[_settings.BudgetDifficulty].Ammo;
			this.m.ArmorParts = ::Const.LegendMod.StartResources[_settings.BudgetDifficulty].ArmorParts;
			this.m.Medicine = ::Const.LegendMod.StartResources[_settings.BudgetDifficulty].Medicine;
		}
		*/
		this.m.LastRosterSize = ::World.getPlayerRoster().getSize();
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
		local roster = ::World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local injuries = bro.getSkills().query(::Const.SkillType.TemporaryInjury);

			local ht;
			if (bro.getSkills().hasSkill("injury.sickness"))
			{
				injuries.push(bro.getSkills().getSkillByID("injury.sickness"));
			}

			foreach( inj in injuries )
			{
				ht = inj.getHealingTime();
				ret.MedicineMin += ht.Min * ::Const.World.Assets.MedicinePerInjuryDay;
				ret.MedicineMax += ht.Max * ::Const.World.Assets.MedicinePerInjuryDay;

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

			local rm = bro.getCurrentProperties().Modifiers.Healing * 100.0;
			if (rm > 0)
			{
				ret.Modifiers.push([rm, bro.getName(), bro.getBackground().getNameOnly()]);
			}
			ret.Modifier += rm;
		}

		ret.MedicineMin = ::Math.ceil(ret.MedicineMin);
		ret.MedicineMax = ::Math.ceil(ret.MedicineMax);
		ret.DaysMin = ::Math.ceil(ret.DaysMin);
		ret.DaysMax = ::Math.ceil(ret.DaysMax);
		return ret;
	}

	o.getDailyWageMult <- function () {
		return ::World.Assets.m.ProfessionEffect.LegendPaymaster > 0 ? this.m.DailyWageMult * (1 / ::World.Assets.m.ProfessionEffect.LegendPaymaster) : this.m.DailyWageMult;
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
	o.create = function () {
		create();
		for (local i = 0; i < ::Const.LegendMod.Formations.Count; ++i) {
			this.m.FormationNames.push(i == 0 ? "Formation 1" : "NULL");
		}
		foreach (profession in ::Const.Professions.ProfessionDefObjects) {
			this.m.ProfessionEffect[profession.Const] <- 0;
		}
	}
	o.consumeFood = function ()
	{
		local items = this.m.Stash.getItems();
		local food = [];

		foreach(bro in ::World.getPlayerRoster().getAll())
		{
			foreach(item in bro.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag))
			{
				if (item != null && item.isItemType(::Const.Items.ItemType.Food) && ::Time.getVirtualTimeF() >= item.getBestBeforeTime())
				{
					item.removeSelf();
				}
			}
		}

		foreach( i, item in items )
		{
			if (item != null && item.isItemType(::Const.Items.ItemType.Food))
			{
				if (::Time.getVirtualTimeF() >= item.getBestBeforeTime())
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
			this.m.LastFoodConsumed = ::Time.getVirtualTimeF();
			return;
		}

		food.sort(this.sortFoodByFreshness);
		local d = ::Math.maxf(0.0, ::Time.getVirtualTimeF() - this.m.LastFoodConsumed);
		this.m.LastFoodConsumed = ::Time.getVirtualTimeF();
		local eaten = d * this.getDailyFoodCost() * ::Const.World.TerrainFoodConsumption[::World.State.getPlayer().getTile().Type] * this.m.FoodConsumptionMult * ::Const.World.Assets.FoodConsumptionMult;

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
		if (this.isCamping())
			::World.State.m.Camp.update(_worldState);

		if (::World.Flags.getAsInt("MandatoryShopRefreshDayMark") + 50 <= ::World.getTime().Days)
		{
			::World.Flags.set("MandatoryShopRefreshDayMark", ::World.getTime().Days);
			foreach( t in ::World.EntityManager.getSettlements() )
			{
				t.updateShop();
			}
		}

		if (::World.getTime().Days > this.m.LastDayPaid && ::World.getTime().Hours > 8 && this.m.IsConsumingAssets)
		{
			this.m.LastDayPaid = ::World.getTime().Days;

			if (this.m.BusinessReputation > 0)
			{
				this.m.BusinessReputation = ::Math.max(0, this.m.BusinessReputation + ::Const.World.Assets.ReputationDaily);
			}

			::World.Retinue.onNewDay();

			if (::World.Flags.get("IsGoldenGoose") == true)
			{
				this.addMoney(50);
			}

			local roster = ::World.getPlayerRoster().getAll();
			local mood = 0;
			local slaves = 0;
			local nonSlaves = 0;

			if (this.m.Origin.getID() == "scenario.manhunters")
			{
				foreach( bro in roster )
				{
					if (bro.getBackground().getID() == ::Legends.Backgrounds.getID(::Legends.Background.Slave))
					{
						slaves = ++slaves;
					}
					else
					{
						nonSlaves = ++nonSlaves;
					}
				}
			}

			local items = ::World.Assets.getStash().getItems();
			foreach( item in items )
			{
				if (item == null)
				{
					continue;
				}

				item.onNewDay();
			}

			local companyRep = ::World.Assets.getMoralReputation() / 10;

			foreach( bro in roster )
			{
				bro.getSkills().onNewDay();
				bro.updateInjuryVisuals();

				if (::World.Assets.getOrigin().getID() == "scenario.legends_troupe")
				{
					this.addMoney(10);
				}


				if (bro.getDailyCost() > 0 && this.m.Money < bro.getDailyCost())
				{
					if (bro.getSkills().hasTrait(::Legends.Trait.Greedy))
					{
						bro.worsenMood(::Const.MoodChange.NotPaidGreedy, "Did not get paid");
					}
					else
					{
						bro.worsenMood(::Const.MoodChange.NotPaid, "Did not get paid");
					}
				}
					// for zombies
				if (bro.getDailyMedicine() > 0)
				{
					if (bro.getSkills().hasTrait(::Legends.Trait.LegendRottenFlesh))
					{
						bro.addLightInjury();
						bro.MoodChanges = [];
						bro.improveMood(0.0, "A lack of medicine has caused me to deteriorate");
					}
				}

				// if (bro.getSkills().hasSkill("perk.legend_pacifist"))
				// {
					// local hireTime = bro.getHireTime();
					// local currentTime =  ::World.getTime().Time;
					// local servedTime = currentTime - hireTime;
					// local servedDays = servedTime / ::World.getTime().SecondsPerDay;
					// if ((servedDays * 7) < bro.getLifetimeStats().Kills)
					// 	{
					// 		bro.worsenMood(::Const.MoodChange.BattleWithoutMe, "Remembers being forced to kill against their wishes");
					// 	}
					// if (bro.getLifetimeStats().Battles > bro.getLifetimeStats().BattlesWithoutMe)
					// {
					// 	bro.worsenMood(::Const.MoodChange.BattleWithoutMe, "Took part in too many battles");
					// }
				// }

				if (this.m.IsUsingProvisions && this.m.Food < bro.getDailyFood())
				{
					if (bro.getSkills().hasTrait(::Legends.Trait.Spartan))
					{
						bro.worsenMood(::Const.MoodChange.NotEatenSpartan, "Went hungry");
					}
					else if (bro.getSkills().hasTrait(::Legends.Trait.Gluttonous))
					{
						bro.worsenMood(::Const.MoodChange.NotEatenGluttonous, "Went hungry");
					}
					else
					{
						bro.worsenMood(::Const.MoodChange.NotEaten, "Went hungry");
					}
				}

				if (this.m.Origin.getID() == "scenario.manhunters" && slaves <= nonSlaves)
				{
					if (bro.getBackground().getID() != ::Legends.Backgrounds.getID(::Legends.Background.Slave))
					{
						bro.worsenMood(::Const.MoodChange.TooFewSlaves, "Too few indebted in the company");
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

			::Sound.play(::Const.Sound.MoneyTransaction[::Math.rand(0, ::Const.Sound.MoneyTransaction.len() - 1)], ::Const.Sound.Volume.Inventory);
			this.m.AverageMoodState = ::Math.round(mood / roster.len());
			_worldState.updateTopbarAssets();

			if (this.m.EconomicDifficulty >= 1 && this.m.CombatDifficulty >= 1)
			{
				if (::World.getTime().Days >= 365)
				{
					this.updateAchievement("Anniversary", 1, 1);
				}
				else if (::World.getTime().Days >= 100)
				{
					this.updateAchievement("Campaigner", 1, 1);
				}
				else if (::World.getTime().Days >= 10)
				{
					this.updateAchievement("Survivor", 1, 1);
				}
			}
		}

		if (::World.getTime().Hours != this.m.LastHourUpdated && this.m.IsConsumingAssets)
		{
			this.m.LastHourUpdated = ::World.getTime().Hours;
			this.consumeFood();
			local roster = ::World.getPlayerRoster().getAll();
			local campMultiplier = this.isCamping() ? this.m.CampingMult : 1.0;

			foreach( bro in roster )
			 {
			 	local d = bro.getHitpointsMax() - bro.getHitpoints();

			 	if (bro.getHitpoints() < bro.getHitpointsMax() )
			 	{
					 if (bro.getFlags().has("undead"))
			 		{
			 			bro.setHitpoints(::Math.minf(bro.getHitpointsMax(), bro.getHitpoints() + (::Const.World.Assets.HitpointsPerHour / 5) * ::Const.Difficulty.HealMult[::World.Assets.getEconomicDifficulty()] * this.m.HitpointsPerHourMult));
					}
					else
					{
			 			bro.setHitpoints(::Math.minf(bro.getHitpointsMax(), bro.getHitpoints() + ::Const.World.Assets.HitpointsPerHour * ::Const.Difficulty.HealMult[::World.Assets.getEconomicDifficulty()] * this.m.HitpointsPerHourMult ));
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
						local d = ::Math.ceil(::Math.minf(::Const.World.Assets.ArmorPerHour * ::Const.Difficulty.RepairMult[::World.Assets.getEconomicDifficulty()] * this.m.RepairSpeedMult, item.getRepairMax() - item.getRepair())); //rounding is crucial because otherwise it repairs nothing but eats tools if below 1, and in any case repair value has to be a round value
						if (::World.Assets.m.ProfessionEffect.LegendHammerThemOut > 0) {
							// Round blacksmith bonus for better determinism
							d = ::Math.ceil(d * (1 + ::World.Assets.m.ProfessionEffect.LegendHammerThemOut));
						}
						item.onRepair(item.getRepair() + d);
						// Round to 3 decimal places for better determinism
						local toolsUsed = ::Math.round(d * this.m.ArmorPartsPerArmor * toolEfficiency * 1000.0) / 1000.0;
						this.m.ArmorParts = ::Math.maxf(0, this.m.ArmorParts - toolsUsed);
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
			 local stashmaxrepairpotential = ::Math.ceil(roster.len() * ::Const.Difficulty.RepairMult[::World.Assets.getEconomicDifficulty()] * this.m.RepairSpeedMult * ::Const.World.Assets.ArmorPerHour); //otherwise fixed version will be too good
			 if (::World.Assets.m.ProfessionEffect.LegendHammerThemOut > 0)
				stashmaxrepairpotential *= (1 + ::World.Assets.m.ProfessionEffect.LegendHammerThemOut); // should be taken into account (blacksmith influence)
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
						local d = ::Math.ceil(::Math.minf(stashmaxrepairpotential, item.getRepairMax() - item.getRepair()));
						item.onRepair(item.getRepair() + d);
						// Round to 3 decimal places for better determinism
						local toolsUsed = ::Math.round(d * this.m.ArmorPartsPerArmor * toolEfficiency * 1000.0) / 1000.0;
						this.m.ArmorParts = ::Math.maxf(0, this.m.ArmorParts - toolsUsed);
						stashmaxrepairpotential = stashmaxrepairpotential - d;
			 		}

			 		if (item.getRepair() >= item.getRepairMax())
			 		{
			 			item.setToBeRepaired(false, 0);
			 		}
			 	}
			 }

			if (::World.getTime().Hours % 4 == 0)
			{
				this.checkDesertion();
				local towns = ::World.EntityManager.getSettlements();
				local playerTile = ::World.State.getPlayer().getTile();
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

					if (town != null && bro.getMoodState() <= ::Const.MoodState.Neutral)
					{
						bro.improveMood(::Const.MoodChange.NearCity, "Has enjoyed the visit to " + town.getName());
					}
				}
			}

			_worldState.updateTopbarAssets();
		}

		if (::World.getTime().Days > this.m.LastDayResourcesUpdated + 7)
		{
			this.m.LastDayResourcesUpdated = ::World.getTime().Days;
			::Legends.Mod.Debug.printLog(format("Day %s: adding resources to each settlement",::World.getTime().Days.tostring()), ::Const.LegendMod.Debug.Flags.WorldEconomy);
			foreach( t in ::World.EntityManager.getSettlements() )
			{
				t.addNewResources();
			}
		}

		// Adds Taro's Turn it in Mod
		local excluded_contracts = [
			"contract.patrol",
			"contract.escort_envoy"
		];
		local activeContract = ::World.Contracts.getActiveContract();
		if (activeContract && ::World.FactionManager.getFaction(activeContract.getFaction()).m.Type == ::Const.FactionType.NobleHouse && excluded_contracts.find(activeContract.m.Type) == null &&
		(activeContract.getActiveState().ID == "Return" || (activeContract.m.Type == "contract.big_game_hunt" && activeContract.getActiveState().Flags.get("HeadsCollected") != 0)))
		{
			local contract_faction = ::World.FactionManager.getFaction(activeContract.getFaction());
			local towns = contract_faction.getSettlements();
			if (!activeContract.m.Flags.get("UpdatedBulletpoints"))
			{
				activeContract.m.BulletpointsObjectives.pop();
				if (activeContract.m.Type == "contract.big_game_hunt"){
					activeContract.m.BulletpointsObjectives.push("Return to any town of " + contract_faction.getName() + " to get paid");
				}
				else{
					activeContract.m.BulletpointsObjectives.push("Return to any town of " + contract_faction.getName());
				}
				activeContract.m.Flags.set("UpdatedBulletpoints", true);
				foreach (town in towns)
				{
					town.getSprite("selection").Visible = true;
				}
				::World.State.getWorldScreen().updateContract(activeContract);
			}
			foreach (town in towns)
			{
				if (activeContract.isPlayerAt(town))
				{
					activeContract.m.Home = this.WeakTableRef(town);
					break;
				}
			}
		}
	}

	o.getFormation = function ()
	{
		local maxSlot = 27, ret = [];
		ret.resize(maxSlot, null);
		local roster = ::World.getPlayerRoster().getAll();

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
		local roster = ::World.getPlayerRoster().getAll();

		//Temporarily set Stash to be resizeable -- this is to prevent fully loaded bros stripping gear into a
		//full stash and losing the gear
		//::World.Assets.getStash().setResizable(true);
		//Save current loadout and strip all gear into stash if moving into a saved formation
		local toTransfer = [];
		foreach (b in roster)
		{
			b.saveFormation();
			b.getItems().transferToList(toTransfer);
		}

		local stash = ::World.Assets.getStash();
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

	o.updateFormation = function (considerMaxBros = false) {
		local NOT_IN_FORMATION = 255;
		local formation = [];
		formation.resize(27, false);
		local roster = ::World.getPlayerRoster().getAll();
		local hasUnplaced = false;
		local inCombat = 0;

		foreach (b in roster) {
			if (b.getPlaceInFormation() != NOT_IN_FORMATION	&& formation[b.getPlaceInFormation()] == false	&& (!considerMaxBros || inCombat < this.m.BrothersMaxInCombat))
			{
				formation[b.getPlaceInFormation()] = true;
				inCombat = ++inCombat;
			} else {
				b.setPlaceInFormation(NOT_IN_FORMATION);
				hasUnplaced = true;
			}
		}

		if (hasUnplaced) {
			foreach (b in roster) {
				if (b.getPlaceInFormation() != NOT_IN_FORMATION) {
					continue;
				}

				local i = 0;
				while (i != formation.len()) {
					if (formation[i] == false) {
						b.setPlaceInFormation(i);
						formation[i] = true;
						inCombat = ++inCombat;
						break;
					}

					i = ++i;
				}
			}
		}
	}

	o.clearFormation <- function ()
	{
		local roster = ::World.getPlayerRoster().getAll();

		local toTransfer = [];
		foreach (b in roster)
		{
			b.getItems().transferToList(toTransfer);
			b.saveFormation();
		}

		local stash = ::World.Assets.getStash();
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
		local roster = ::World.getPlayerRoster().getAll();

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

			for( local i = ::Const.ItemSlot.Mainhand; i <= ::Const.ItemSlot.Ammo; i = ++i )
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
						Slot = ::Const.ItemSlot.Bag
					});
				}
			}

			this.m.RestoreEquipment.push(store);
		}
	}

	o.restoreEquipment = function ()
	{
		::World.State.m.AppropriateTimeToRecalc = 0;	//Leonion's fix
		foreach( s in this.m.RestoreEquipment )
		{
			local bro = ::Tactical.getEntityByID(s.ID);

			if (bro == null || !bro.isAlive())
			{
				continue;
			}

			local currentItems = [];
			local itemsHandled = [];
			local overflowItems = [];

			for( local i = ::Const.ItemSlot.Mainhand; i <= ::Const.ItemSlot.Ammo; i = ++i )
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
						Slot = ::Const.ItemSlot.Bag
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

				if (item.Slot == ::Const.ItemSlot.Bag)
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

				if (item.Item.getCurrentSlotType() == ::Const.ItemSlot.Bag)
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
		::World.State.m.AppropriateTimeToRecalc = 1;	//Leonion's fix
		::World.State.getPlayer().calculateModifiers();	//Leonion's fix
	}


	o.addBrotherEnding = function ( _brothers, _excludedBackgrounds, _isPositive )
	{
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

		local bro = candidates[::Math.rand(0, candidates.len() - 1)];
		_brothers.remove(bro.Index);
		_excludedBackgrounds.push(bro.Bro.getBackground().getID());
		local villages = ::World.EntityManager.getSettlements();
		local nobleHouses = ::World.FactionManager.getFactionsOfType(::Const.FactionType.NobleHouse);
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
				::World.Assets.getName()
			],
			[
				"randomname",
				::Const.Strings.CharacterNames[::Math.rand(0, ::Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomnoblehouse",
				nobleHouses[::Math.rand(0, nobleHouses.len() - 1)].getName()
			],
			[
				"randomnoble",
				::Const.Strings.KnightNames[::Math.rand(0, ::Const.Strings.KnightNames.len() - 1)]
			],
			[
				"randomtown",
				villages[::Math.rand(0, villages.len() - 1)].getNameOnly()
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
			local terrains = bro.getCurrentProperties().Modifiers.Terrain;
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

		if (::World.Assets.m.ProfessionEffect.LegendTrailblazer > 0) {
			for (local i = 0; i < terrainIDs.len(); ++i) {
				local terrainBaseSpeed = ::Const.World.TerrainTypeSpeedMult[terrainIDs[i]];
				if (terrainBaseSpeed <= 1.0 && terrainBaseSpeed > 0.0) {
					ret.TerrainModifiers[i][1] *= ::Math.minf(1.0, (terrainBaseSpeed + ::World.Assets.m.ProfessionEffect.LegendTrailblazer)) / terrainBaseSpeed;
				}
			}
		}

		foreach (terrain in ret.TerrainModifiers) {
            terrain[1] *= (1 + ::World.Assets.m.ProfessionEffect.LegendWheelMaintenance) * 100.0;
        }

		local sortfn = function (first, second)
		{
			if (first.Level == second.Level) {
				return 0;
			}
			if (first.Level > second.Level)	{
				return -1;
			}
			return 1;
		}
		ret.Brothers.sort(sortfn);
		return ret;
	}

	o.updateLook = function ( _updateTo = -1 )
	{
		if (_updateTo != -1)
			this.m.Look = _updateTo;

		::World.State.getPlayer().setBaseImage(this.m.Look);

		if ("updateLook" in ::World.Assets.getOrigin())
			::World.Assets.getOrigin().updateLook();
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
		for (local i = 0; i < ::Const.LegendMod.Formations.Count; i++)
		{
			this.setFormationName(i, _in.readString());
		}
		this.m.LastDayResourcesUpdated = _in.readU16();
	}

});
