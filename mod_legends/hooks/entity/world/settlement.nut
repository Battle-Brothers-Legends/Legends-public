::mods_hookExactClass("entity/world/settlement", function(o)
{
	o.m.FemaleDraftList <- [];
	o.m.StablesList <- [];
	o.m.LastStablesUpdate <- 0.0;
	o.m.StablesSeed <- 0;
	o.m.ImportedGoodsInventory <- null;
	o.m.IsUpgrading <- false;
	o.m.CaravanReceivedHistory <- array(7,[]); // 7-day rolling window recording all caravans received
	o.m.CaravanSentHistory <- array(7,[]); // 7-day rolling window recording all caravans sent
	o.m.SurroundingTileData <- null;
	o.m.SurroundingTileDataDefaultRadius <- 10;
	o.m.TempBuildSettings <- null;
	o.m.SettlementEncountersCooldownUntil <- 0.0;
	o.m.SettlementEncounters <- [];

	o.setUpgrading <- function ( _v )
	{
		this.m.IsUpgrading = _v;
	}

	o.isUpgrading <- function ()
	{
		return this.m.IsUpgrading;
	}

	o.setSize <- function ( _v )
	{
		this.m.Size = _v;

		if (this.m.Name == "")
		{
			this.m.Name = this.getRandomName(this.m.Names[_v - 1]);

			if (this.hasLabel("name"))
			{
				this.getLabel("name").Text = this.m.Name;
			}
		}

		this.updateSprites();
	}

	o.changeSupportedOrAbandonedAttachedLocations <- function ()
	{
		local current = this.getActiveAttachedLocations().len();
		local limit = this.getAttachedLocationsMax();

		if ( current > limit )
		{
			// The settlement is shrinking and will have to abandon attached locations that exceed the Tier limit
			while (this.getActiveAttachedLocations().len() > limit) {
				this.getActiveAttachedLocations().top().setAbandoned(true);
			}
		}
		else if (current < limit && this.getAttachedLocations().len() > current)
		{
			// Check if we can repopulate attached locations that were previously abandoned
			local maxIndex = ::Math.min(this.getAttachedLocations().len(), limit);
			for (local i = current; i < maxIndex; i++)
			{
				if (this.getAttachedLocations()[i].isAbandoned())
				{
					this.getAttachedLocations()[i].setAbandoned(false);
				}
			}
		}
	}

	o.changeSize <- function ( _v )
	{
		this.setUpgrading(false);
		_v = this.Math.max(1, _v);
		this.setSize(this.Math.min(3, _v));
		this.changeSupportedOrAbandonedAttachedLocations();
	}

	o.getDraftList <- function ()
	{
		local L = clone this.m.DraftList;

		if (::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled")
		{
			L.extend(this.m.FemaleDraftList);
		}

		return L;
	}

	o.getStablesList <- function ()
	{
		return this.m.StablesList;
	}

	o.getHousesMin <- function ()
	{
		return this.m.HousesMin;
	}

	o.getHousesMax <- function ()
	{
		return this.m.HousesMax;
	}

	o.getHousesType <- function ()
	{
		return this.m.HousesType;
	}

	o.getAttachedLocationsMax <- function ()
	{
		return this.m.AttachedLocationsMax;
	}

	// It will be easier to search for usages of "getSettlementTier" rather than "getSize"
	o.getSettlementTier <- function ()
	{
		return this.m.Size;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local ret = getTooltip();

		if (!this.m.IsActive)
			return ret;

		if (this.m.IsVisited && this.isUpgrading())
			ret.insert(2, {
				id = 3,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is currently being upgraded"
			});


		if (this.World.Retinue.hasFollower("follower.agent")) {
			local contracts = this.getContracts();
			local situations = this.getSituations();
			local addedSituations = {};

			foreach( i, s in situations )
			{
				if (s.isValid() && !(s.getValidUntil() == 0 && !this.World.Contracts.hasContractWithSituation(s.getInstanceID()))) {
					local id = s.getID();

					if (!(id in addedSituations)) {
						ret.push({
							id = 10 + contracts.len() + i,
							type = "text",
							icon = s.getIcon(),
							text = s.getName()
						});
						addedSituations[id] <- true;
					}
				}
			}
		}
		else if (this.World.State.getDistantVisionBonus()) {
			foreach( s in this.m.Situations )
			{
				ret.push({
					id = 6,
					type = "text",
					text = "Has current event: " + s.getName()
				});
			}
		}

		if (this.Const.LegendMod.DebugMode)
			ret.push({
				id = 6,
				type = "hint",
				text = "Resources: " + this.getResources()
			});

		if (this.Const.LegendMod.DebugMode)
			ret.push({
				id = 6,
				type = "hint",
				text = "Generating Resources: " + this.getNewResources()
			});

		if (this.Const.LegendMod.DebugMode || this.m.IsVisited && ::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			ret.extend([
				{
					id = 6,
					type = "hint",
					icon = "ui/icons/settlement_tier_icon.png",
					divider = "top",
					text = "Settlement Tier: " + this.getSize()
				},
				{
					id = 6,
					type = "hint",
					icon = "ui/icons/asset_money_small.png",
					text = "Wealth " + this.getWealth() + " %"
				}
			]);

		return ret;
	}

	// Use addWorldEconomyResources instead so it is easier to search for usages. Keeping this here for compatibility
	o.addResources <- function ( _v )
	{
		this.setResources(this.getResources() + _v);
	}

	// Use this instead of addResources so it is easier to search for usages
	o.addWorldEconomyResources <- function ( _v )
	{
		this.setResources(this.getResources() + _v);
	}


	o.getWealth <- function ()
	{
		return this.Math.round(100.0 * (1.0 * this.getResources() / this.getWealthBaseLevel()));
	}

	o.getWealthBaseLevel <- function ()
	{
		local baseLevel = 50 + this.getSize() * 50;
		if (this.isMilitary())
			baseLevel += 50.0;

		if (this.isKindOf(this, "city_state"))
			baseLevel += 100;
		return baseLevel;
	}


	o.getSpriteName <- function ()
	{
		local s = this.m.Sprite;

		if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			s = "legend_" + this.m.Sprite;
		}

		if (this.isUpgrading())
		{
			s = s + "_upgrade";
		}

		return s;
	}

	local getUIContractInformation = o.getUIContractInformation;
	o.getUIContractInformation = function ()
	{
		local result = getUIContractInformation();

		foreach(contract in getContracts() )
		{
			foreach (entry in result.Contracts)
			{
				if (entry.ID != contract.getID())
					continue;

				entry.CategoryIcon <- contract.getUICategoryIcon();
				entry.Alignment <- ::Legends.Mod.ModSettings.getSetting("ContractCategoryIconAlignment").getValue().tolower();
				break;
			}
		}

		return result;
	}

	o.getUIDescription <- function()
	{
		return this.m.UIDescription;
	}

	o.getUIBackground <- function()
	{
		return this.m.UIBackground;
	}

	o.getUIBackgroundCenter <- function()
	{
		return this.m.UIBackgroundCenter;
	}

	o.getUIBackgroundLeft <- function()
	{
		return this.m.UIBackgroundLeft;
	}

	o.getUIBackgroundRight <- function()
	{
		return this.m.UIBackgroundRight;
	}

	o.getUIRamp <- function()
	{
		return this.m.UIRamp;
	}

	o.getUIRampPathway <- function()
	{
		return this.m.UIRampPathway;
	}

	o.getUIMood <- function()
	{
		return this.m.UIMood;
	}

	o.getUIForeground <- function()
	{
		return this.m.UIForeground;
	}

	o.getLighting <- function()
	{
		return this.m.Lighting;
	}

	local getUIInformation = o.getUIInformation;
	o.getUIInformation = function ()
	{
		this.m.UIDescription = getUIDescription();
		this.m.UIBackground = getUIBackground();
		this.m.UIBackgroundCenter = getUIBackgroundCenter();
		this.m.UIBackgroundLeft = getUIBackgroundLeft();
		this.m.UIBackgroundRight = getUIBackgroundRight();
		this.m.UIRamp = getUIRamp();
		this.m.UIRampPathway = getUIRampPathway();
		this.m.UIMood = getUIMood();
		this.m.UIForeground = getUIForeground();

		local result = getUIInformation();

		foreach(contract in getContracts())
		{
			foreach (entry in result.Contracts)
			{
				if (entry.ID != contract.getID())
					continue;

				entry.CategoryIcon <- contract.getUICategoryIcon();
				entry.Alignment <- ::Legends.Mod.ModSettings.getSetting("ContractCategoryIconAlignment").getValue().tolower();
				break;
			}
		}

		for (local i = m.Buildings.len() - 1; i >= 0 ; --i)
		{
			if (i >= result.Slots.len() || m.Buildings[i] == null || m.Buildings[i].isHidden())
				continue;

			if (m.Buildings[i].m.IsClosedAtDay && ::World.getTime().IsDaytime)
				result.Slots[i] = null;
		}

		result.Encounters <- [];
		foreach(encounter in this.m.SettlementEncounters) {
			if (encounter != null) {
				result.Encounters.push({
					Icon = encounter.m.Icon,
					Type = encounter.getType(),
				});
			}
		}

		return result;
	}

	local getUIPreloadInformation = o.getUIPreloadInformation;
	o.getUIPreloadInformation = function()
	{
		this.m.UIDescription = getUIDescription();
		this.m.UIBackground = getUIBackground();
		this.m.UIBackgroundCenter = getUIBackgroundCenter();
		this.m.UIBackgroundLeft = getUIBackgroundLeft();
		this.m.UIBackgroundRight = getUIBackgroundRight();
		this.m.UIRamp = getUIRamp();
		this.m.UIRampPathway = getUIRampPathway();
		this.m.UIMood = getUIMood();
		this.m.UIForeground = getUIForeground();

		local result = getUIPreloadInformation();

		for (local i = m.Buildings.len() - 1; i >= 0 ; --i)
		{
			if (i >= result.Slots.len() || m.Buildings[i] == null || m.Buildings[i].isHidden())
				continue;

			if (m.Buildings[i].m.IsClosedAtDay && ::World.getTime().IsDaytime)
				result.Slots[i] = null;
		}

		return result;
	}

	o.getImportedGoodsInventory <- function()
	{
		return this.m.ImportedGoodsInventory;
	}

	local getBuyPriceMult = o.getBuyPriceMult;
	o.getBuyPriceMult = function()
	{
		local p = getBuyPriceMult();
		local barterMult = ::World.State.getPlayer().getBarterMult();

		if (this.m.Modifiers.BuyPriceMult - barterMult >= 0.01)
			p *= this.m.Modifiers.BuyPriceMult - barterMult;

		return p;
	}

	local getSellPriceMult = o.getSellPriceMult;
	o.getSellPriceMult = function ()
	{
		local p = getSellPriceMult();
		p *= this.m.Modifiers.SellPriceMult + this.World.State.getPlayer().getBarterMult();
		return p;
	}

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ImportedGoodsInventory = this.new("scripts/items/stash_container");
		this.m.ImportedGoodsInventory.setID("imported_inventory");
		this.m.ImportedGoodsInventory.setResizable(true);
		this.m.IsShowingStrength = true;
		this.m.IsScalingDefenders = true;
	}

	local addSituation = o.addSituation;
	o.addSituation = function ( _s, _validForDays = 0 )
	{
		_s.m.IsSouthern = this.isSouthern();
		return addSituation( _s, _validForDays);
	}

	o.resolveSituationByInstance <- function ( _instanceID )
	{
		foreach( i, e in this.m.Situations )
		{
			if (e.getInstanceID() == _instanceID)
			{
				e.onResolved(this);
				this.m.Situations.remove(i);
				this.m.Modifiers.reset();

				foreach( s in this.m.Situations )
				{
					s.onUpdate(this.m.Modifiers);
				}

				return 0;
			}
		}

		return _instanceID;
	}

	local addBuilding = o.addBuilding;
	o.addBuilding = function ( _building, _slot = null )
	{
		addBuilding(_building, _slot);

		if (_building.getID() == "building.blackmarket")
		{
			++this.Const.World.Buildings.Blackmarket;
		}
		else if (_building.getID() == "building.stables")
		{
			++this.Const.World.Buildings.Stables;
		}
	}

	o.buildNewLocation <- function ()
	{
		return null;
	}

	// A helper function to filter out any existing attached locations from possible candidates in buildNewLocation()
	o.filterNewLocation <- function ( _items )
	{
		// ::MSU.Log.printData(_items.map(function(item){return item[1].Script;}));
		local ret = clone _items;
		local existingLocations = this.getAttachedLocations().map(function(location){ return location.ClassName; });
		local garbage = [];
		// Find any candidate locations in _items that have already been built
		for (local i=0; i < _items.len(); i++)
		{
			local arr = split(_items[i][1].Script, "/");
			local location = arr[arr.len() - 1];
			if (existingLocations.find(location) != null)
			{
				garbage.push(i);
			}
		}

		// Now remove any locations that have already been built from ret
		garbage.reverse();
		foreach ( index in garbage )
		{
			ret.remove(index);
		}

		// Just in case all candidate locations have already be built, then allow duplicates
		if ( ret == null || ret.len() < 1 )
		{
			ret = _items;
		}

		// ::MSU.Log.printData(ret.map(function(item){ return item[1].Script;}));
		return ret;
	}

	local buildAttachedLocation = o.buildAttachedLocation;
	o.buildAttachedLocation = function ( _num, _script, _terrain, _nearbyTerrain, _additionalDistance = 0, _mustBeNearRoad = false, _clearTile = true, _force = false )
	{
		local currentNum = this.m.AttachedLocations.len();

		if (_force) this.m.AttachedLocationsMax = currentNum + _num;
		else this.m.AttachedLocationsMax = getAttachedLocationsMax();

		buildAttachedLocation(_num, _script, _terrain, _nearbyTerrain, _additionalDistance, _mustBeNearRoad, _clearTile);

		if (_force) this.m.AttachedLocationsMax = getAttachedLocationsMax();

		return this.m.AttachedLocations.len() > currentNum ? this.m.AttachedLocations.top() : null;
	}

	o.getBuilding <- function ( _id )
	{
		foreach( b in this.m.Buildings )
		{
			if (b != null && b.getID() == _id)
			{
				return b;
			}
		}

		return null;
	}

	o.setTempBuildSettings <- function(_settings)
	{
		m.TempBuildSettings = _settings;
	}

	local build = o.build;
	o.build = function ( _settings = null )
	{
		setTempBuildSettings(_settings);
		build();
	}

	local updateRoster = o.updateRoster;
	o.updateRoster = function ( _force = false )
	{
		if (_force || m.LastRosterUpdate == 0 || ((::Time.getVirtualTimeF() - m.LastRosterUpdate) / ::World.getTime().SecondsPerDay) >= 2) {
			m.DraftList = getDraftList(); // apply the draftlist
			::World.getTemporaryRoster().clear(); // using this to store the stabled
			::World.Assets.getOrigin().setCurrentSettlement(this); // new thing added by Hanter, so i put it here
			local stable = ::World.getTemporaryRoster(), roster = ::World.getRoster(getID());
			foreach(bro in roster.getAll())
			{
				if (bro.isStabled()) {
					stable.add(bro); // store in temp, this is also a way to help them dodge the background purge in noble or militia origin
					roster.remove(bro); // temporarily remove them so they won't be considered in the original function
					continue;
				}

				bro.getFlags().set("Legend_onGenerateBroPass", true);
			}

			updateRoster(_force); // run the original function

			foreach (bro in roster.getAll())
			{
				if (bro.getFlags().get("Legend_onGenerateBroPass")) {
					bro.getFlags().remove("Legend_onGenerateBroPass"); // remove this flag, no need to serialize it afterward
					continue; // flag found so this isn't a newly generated brother
				}

				::World.Assets.getOrigin().onGenerateBro(bro); // call this new function added by Hanter
			}

			foreach (bro in stable.getAll())
			{
				roster.add(bro); // return the donkey
				stable.remove(bro);
			}

			::World.getTemporaryRoster().clear(); // clean up
		}

		updateStables(_force);
	}

	o.updateStables <- function ( _force = false )
	{
		if (!hasBuilding("building.stables"))
			return;

		local daysPassed = (::Time.getVirtualTimeF() - m.LastStablesUpdate) / ::World.getTime().SecondsPerDay;

		if (!_force && m.LastStablesUpdate != 0 && daysPassed < 2)
			return;

		if (m.StablesSeed != 0)
			::Math.seedRandom(m.StablesSeed);

		m.StablesSeed = ::Math.floor(::Time.getRealTime() + ::Math.rand());
		m.LastStablesUpdate = ::Time.getVirtualTimeF();
		local current = [], roster = ::World.getRoster(getID());
		local iterations = ::Math.max(1, daysPassed / 2), activeLocations = 0;

		foreach( loc in getAttachedLocations() )
		{
			if (loc.isActive())
				++activeLocations;
		}

		foreach (bro in roster.getAll())
		{
			if (bro.isStabled())
				current.push(bro);
		}

		local minRosterSizes = [0,1,3,5];
		local rosterMin = minRosterSizes[m.Size];
		local rosterMax = minRosterSizes[m.Size] + activeLocations;

		if (::World.FactionManager.getFaction(m.Factions[0]).getPlayerRelation() < 50) {
			rosterMin *= (::World.FactionManager.getFaction(m.Factions[0]).getPlayerRelation() / 50.0);
			rosterMax *= (::World.FactionManager.getFaction(m.Factions[0]).getPlayerRelation() / 50.0);
		}

		rosterMin *= m.Modifiers.StablesMult;
		rosterMax *= m.Modifiers.StablesMult;

		if (iterations < 5) {
			for( local i = 0; i < iterations; ++i )
			{
				for( local maxRecruits = ::Math.rand(::Math.max(0, rosterMax / 2 - 1), rosterMax - 1); current.len() > maxRecruits;  )
				{
					local n = ::Math.rand(0, current.len() - 1);
					roster.remove(current.remove(n));
				}
			}
		}
		else {
			foreach( bro in current )
			{
				roster.remove(bro);
			}

			current.clear();
		}

		local maxRecruits = ::Math.rand(rosterMin, rosterMax);
		local draftList = ["legend_donkey_background"]; //getStablesList();

		/* stable list currently only contains donkey so there is no need to update in other places
		foreach( loc in getAttachedLocations() )
		{
			loc.onUpdateStablesList(draftList);
		}

		foreach( b in m.Buildings )
		{
			if (b != null)
				b.onUpdateStablesList(draftList);
		}

		foreach( s in getSituations() )
		{
			s.onUpdateStablesList(draftList);
		}

		::World.Assets.getOrigin().onUpdateStablesList(draftList);
		*/

		while (maxRecruits > current.len())
		{
			local bro = roster.create("scripts/entity/tactical/player");
			bro.setStartValuesEx(draftList);
			current.push(bro);
		}
	}

	local updateImportedProduce = o.updateImportedProduce;
	o.updateImportedProduce = function ()
	{
		if (this.m.ProduceImported.len() == 0 && this.m.ImportedGoodsInventory.getItems().len() == 0)
			return;

		local marketplace = this.getBuilding("building.marketplace");

		if (marketplace != null) {
			foreach( p in this.m.ImportedGoodsInventory.getItems() )
				marketplace.getStash().add(p);

			this.m.ImportedGoodsInventory.clear();
		}

		updateImportedProduce();
	}

	local setActive = o.setActive;
	o.setActive = function ( _a, _burn = true )
	{
		if (_a == this.m.IsActive)
			return;

		this.m.Sprite = getSpriteName();
		this.m.HousesType = getHousesType();
		setActive(_a, _burn = true);
	}

	local destroy = o.destroy;
	o.destroy = function()
	{
		this.m.Sprite = getSpriteName();
		destroy();
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function()
	{
		this.m.HousesType = getHousesType();
		onUpdate();
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		this.m.HousesMax = getHousesMax();
		this.m.Sprite = getSpriteName();
		onInit();
		this.updateSurroundingTileData();
	}

	o.onLeave <- function ()
	{
		foreach (item in this.World.Assets.getStash().getItems()) {
			if (item == null)
				continue;
			if (item.isBought() && !item.isSold()) {
				if (item.isItemType(this.Const.Items.ItemType.TradeGood)) {
					this.World.Statistics.getFlags().increment("TradeGoodsBought");
					if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
						this.setResources(this.getResources() + item.getResourceValue());
				}
			}
			item.setBought(false);
			item.setTransactionPrice(null);
		}

		foreach (bro in this.World.getPlayerRoster().getAll())
			foreach (item in bro.getItems().getAllItems())
				if (item.isBought()) {
					item.setBought(false);
					item.setTransactionPrice(null);
				}

		foreach (building in this.getBuildings())
		{
			local stash = building.getStash();
			if (stash != null)
			{
				foreach (item in stash.getItems())
				{
					if (item == null) continue;
					if (item.isSold() && !item.isBought())
					{
						if (item.isItemType(this.Const.Items.ItemType.TradeGood))
						{
							this.World.Statistics.getFlags().increment("TradeGoodsSold");

							if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
							{
								this.setResources(this.getResources() + item.getResourceValue());
							}
						}
					}
					item.setSold(false);
					item.setTransactionPrice(null);
				}
			}
		}

		if (this.World.Statistics.getFlags().has("TradeGoodsSold") && this.World.Statistics.getFlags().get("TradeGoodsSold") >= 10)
		{
			this.updateAchievement("Trader", 1, 1);
		}

		if (this.World.Statistics.getFlags().has("TradeGoodsSold") && this.World.Statistics.getFlags().get("TradeGoodsSold") >= 50)
		{
			this.updateAchievement("MasterTrader", 1, 1);
		}

		if (::Legends.Mod.ModSettings.getSetting("SkipCamp").getValue())
		{
			return;
		}

		local eventID = "";

		if (!this.World.Flags.get("HasLegendCampTraining") && this.hasBuilding("building.training_hall"))
		{
			eventID = "event.legend_camp_unlock_training";
		}
		else if (!this.World.Flags.get("HasLegendCampBarber") && this.hasBuilding("building.barber"))
		{
			eventID = "event.legend_camp_unlock_barber";
		}
		else if (!this.World.Flags.get("HasLegendCampCrafting") && (this.hasBuilding("building.taxidermist") || this.hasBuilding("building.taxidermist_oriental")))
		{
			eventID = "event.legend_camp_unlock_crafting";
		}
		else if (!this.World.Flags.get("HasLegendCampFletching") && (this.hasAttachedLocation("attached_location.fletchers_hut") || this.hasBuilding("building.weaponsmith") || this.hasBuilding("building.weaponsmith_oriental")))
		{
			eventID = "event.legend_camp_unlock_fletching";
		}
		else if (!this.World.Flags.get("HasLegendCampGathering") && (this.hasAttachedLocation("attached_location.gatherers_hut") || this.hasAttachedLocation("attached_location.herbalists_grove") || this.hasAttachedLocation("attached_location.plantation")))
		{
			eventID = "event.legend_camp_unlock_gather";
		}
		else if (!this.World.Flags.get("HasLegendCampHunting") && (this.hasAttachedLocation("attached_location.trapper") || this.hasAttachedLocation("attached_location.hunters_cabin")))
		{
			eventID = "event.legend_camp_unlock_hunt";
		}
		else if (!this.World.Flags.get("HasLegendCampScraping") && (this.hasAttachedLocation("attached_location.workshop") || this.hasBuilding("building.armorsmith") || this.hasBuilding("building.armorsmith_oriental")))
		{
			eventID = "event.legend_camp_unlock_scrap";
		}
		else if (!this.World.Flags.get("HasLegendCampPainter") && (this.hasAttachedLocation("attached_location.workshop") || this.hasBuilding("building.armorsmith") || this.hasBuilding("building.armorsmith_oriental"))) //PaintingTent
		{
			eventID = "event.legend_camp_unlock_painter";
		}
		else if (!this.World.Flags.get("HasLegendCampScouting") && (this.hasAttachedLocation("attached_location.wooden_watchtower") || this.hasAttachedLocation("attached_location.stone_watchtower") || this.hasAttachedLocation("attached_location.fortified_outpost")))
		{
			eventID = "event.legend_camp_unlock_scouting";
		}

		if (eventID == "")
		{
			return;
		}

		this.World.Camp.fireEvent(eventID, this.getName());
	}

	o.isBuilding <- function ()
	{
		foreach( s in this.getSituations() )
		{
			switch(s.getID())
			{
			case "situation.rebuilding_effort":
			case "situation.legend_degrading_effort":
			case "situation.legend_upgrading_effort":
			case "situation.legend_upgrading_locations_effort":
				return true;
			}
		}

		return false;
	}

	o.getBuildings <- function ()
	{
		local ret = [];
		foreach (b in this.m.Buildings) {
			if (b != null)
				ret.push(b);
		}
		return ret;
	}

	o.getBaseResourceLevel <- function ()
	{
		local minResources = 50 + this.getSize() * 50;
		if (this.isMilitary())
			minResources = minResources + 50;
		if (this.isKindOf(this, "city_state"))
			minResources = minResources + 100;
		return minResources;
	}

	o.canUpgrade <- function ()
	{
		if (this.m.Size >= 3)
			return false;

		if (this.isUpgrading())
			return false;

		foreach( a in this.getAttachedLocations() )
		{
			if (a.isBuilding())
				return false;
		}

		return this.getResources() >= this.getBaseResourceLevel();
	}

	o.canBuildLocation <- function ()
	{
		if (this.isUpgrading())
			return false;

		if (this.m.AttachedLocations.len() >= this.getAttachedLocationsMax())
			return false;

		foreach( a in this.getAttachedLocations() )
		{
			if (a.isBuilding())
				return false;
		}

		return this.getResources() >= this.getBaseResourceLevel();
	}

	o.canUpgradeLocations <- function ()
	{
		if (this.isUpgrading())
			return false;

		if (this.m.AttachedLocations.len() < this.getAttachedLocationsMax())
			return false;

		foreach( a in this.getAttachedLocations() )
		{
			if (a.isBuilding())
				return false;
		}

		return this.getResources() >= this.getBaseResourceLevel();
	}

	o.numShips <- function ()
	{
		local f = this.World.FactionManager.getFaction(this.m.Factions[0]);

		if (f == null)
			return 0;

		local num = 0;

		foreach( u in f.getUnits() )
		{
			if (u.m.Name == "Ship")
				num++;
		}

		return num;
	}

	o.getNewResources <- function ()
	{
		local resources = 0;

		foreach( loc in this.getAttachedLocations() )
		{
			resources += loc.getNewResources();
		}

		resources += this.m.HousesTiles.len() * 2;
		// this.logWarning("Adding a total of: " + resources + " : to a town that has " + this.m.HousesTiles.len() + " total tiles.")
		::Legends.Mod.Debug.printLog(format("%s adding %s resources",::Const.LegendMod.Debug.Utils.settlementSummaryStr(this, true, true),resources.tostring()), ::Const.LegendMod.Debug.Flags.WorldEconomy);
		return resources;
	}

	o.addNewResources <- function()
	{
		if (!this.m.IsActive)
			return;

		this.addWorldEconomyResources(this.getNewResources());
	}

	o.getCaravanReceivedHistory <- function ()
	{
		return this.m.CaravanReceivedHistory;
	}

	o.getCaravanSentHistory <- function ()
	{
		return this.m.CaravanSentHistory;
	}

	o.getCaravanReceivedCount <- function ()
	{
		local sums = this.m.CaravanReceivedHistory.map(function(arr){return arr.len();});
		return sums.reduce(function(prev, curr){return prev + curr;});
	}

	// Get the total number of caravans sent from this settlement over the past 7 days
	o.getCaravanSentCount <- function ()
	{
		local sums = this.m.CaravanSentHistory.map(function(arr){return arr.filter(function(index, data){return data.type == ::Const.World.Common.WorldEconomy.Trade.CaravanHistoryType.Initiated}).len();});
		return sums.reduce(function(prev, curr){return prev + curr;});
	}

	// Get the total number of caravans sent from this settlement and successfully reached their destination over the past 7 days
	o.getCaravanCompletedCount <- function ()
	{
		local sums = this.m.CaravanSentHistory.map(function(arr){return arr.filter(function(index, data){return data.type == ::Const.World.Common.WorldEconomy.Trade.CaravanHistoryType.Completed}).len();});
		return sums.reduce(function(prev, curr){return prev + curr;});
	}

	// Get the total number of caravans sent from this settlement and were destroyed along the way over the past 7 days
	o.getCaravanDestroyedCount <- function ()
	{
		local sums = this.m.CaravanSentHistory.map(function(arr){return arr.filter(function(index, data){return data.type == ::Const.World.Common.WorldEconomy.Trade.CaravanHistoryType.Destroyed}).len();});
		return sums.reduce(function(prev, curr){return prev + curr;});
	}

	o.updateCaravanReceivedHistory <- function ( _data )
	{
		this.m.CaravanReceivedHistory[0].push(_data);
	}

	o.updateCaravanSentHistory <- function ( _data )
	{
		this.m.CaravanSentHistory[0].push( _data );
	}

	o.onNewDay <- function ()
	{
		this.refreshCaravanHistory();
	}

	o.refreshCaravanHistory <- function ()
	{
		this.updateRollingWindow(this.getCaravanReceivedHistory());
		this.updateRollingWindow(this.getCaravanSentHistory());
	}

	o.updateRollingWindow <- function ( _arr )
	{
		_arr.pop();
		_arr.insert(0,[]);
	}

	o.updateSurroundingTileData <- function ( _radius = null )
	{
		_radius = _radius == null ? this.m.SurroundingTileDataDefaultRadius : _radius;
		this.m.SurroundingTileData = ::Const.LegendMod.Hex.World.getTilesWithinRadiusOrganizedByRadiusAndType(this.getTile(), _radius);
	}

	o.getSurroundingTilesOfType <- function ( _types, _maxRadius, _minRadius = 0)
	{
		if (_maxRadius > this.m.SurroundingTileData.Data.len())
			this.updateSurroundingTileData(_maxRadius);

		return this.m.SurroundingTileData.getTilesOfTypesBetweenRadius(_types, _maxRadius, _minRadius);
	}

	o.getSurroundingTileTypeProportion <- function ( _types, _maxRadius, _minRadius = 0)
	{
		if (_maxRadius > this.m.SurroundingTileData.Data.len() )
			this.updateSurroundingTileData(_maxRadius);

		return this.m.SurroundingTileData.getProportionOfTypesBetweenRadius(_types, _maxRadius, _minRadius);
	}

	o.getSurroundingTileTypeCount <- function ( _types, _maxRadius, _minRadius = 0)
	{
		if (_maxRadius > this.m.SurroundingTileData.Data.len() )
			this.updateSurroundingTileData(_maxRadius);

		return this.m.SurroundingTileData.getCountOfTypesBetweenRadius(_types, _maxRadius, _minRadius);
	}

	o.updateSprites <- function( _burn = true )
	{
		if (this.m.IsActive)
		{
			this.getSprite("location_banner").Visible = true;
			this.getLabel("name").Visible = true;
			this.getSprite("body").setBrush(this.getSpriteName());

			foreach( h in this.m.HousesTiles )
			{
				continue;
				local tile = this.World.getTileSquare(h.X, h.Y);
				tile.clear(this.Const.World.DetailType.Houses);
				local d = tile.spawnDetail("world_houses_0" + this.getHousesType() + "_0" + h.V, this.Const.World.ZLevel.Object - 3, this.Const.World.DetailType.Houses);

				if (d == null)
				{
					continue;
				}

				d.Scale = 0.85;
			}
		}
		else
		{
			this.World.getRoster(this.getID()).clear();
			this.getSprite("location_banner").Visible = false;
			this.getLabel("name").Visible = false;
			this.getSprite("body").setBrush(this.getSpriteName() + "_ruins");
			this.getSprite("lighting").Alpha = 0;

			if (_burn)
			{
				this.spawnFireAndSmoke();
			}

			foreach( h in this.m.HousesTiles )
			{
				continue;
				local tile = this.World.getTileSquare(h.X, h.Y);
				tile.clear(this.Const.World.DetailType.Houses | this.Const.World.DetailType.Lighting);
				local d = tile.spawnDetail("world_houses_0" + this.getHousesType() + "_0" + h.V + "_ruins", this.Const.World.ZLevel.Object - 3, this.Const.World.DetailType.Houses);
				d.Scale = 0.85;
				this.spawnFireAndSmoke(tile.Pos);
			}

			foreach( loc in this.m.AttachedLocations )
			{
				if (loc.isActive())
				{
					loc.setActive(false);
				}

				loc.setSettlement(null);
			}
		}
	}

	o.onEncounterClicked <- function(_i, _townScreen){
		this.World.Encounters.fireEncounter(this.m.SettlementEncounters[_i]);
		this.m.SettlementEncounters.remove(_i);
	}

	/**
	 * On settlement enter, check if it should show event.
	 */
	local onEnter = o.onEnter;
	o.onEnter = function () {
		local ret = onEnter();
		this.updateEncounters();
		return ret;
	}

	/**
	 * Updates encounters in the town.
	 */
	o.updateEncounters <- function() {
		if (this.m.SettlementEncountersCooldownUntil > this.Time.getVirtualTimeF()) {
			local notValid = [];
			foreach (e in this.m.SettlementEncounters) {
				if (!e.isValid(this))
					notValid.push(e);
			}
			foreach (e in notValid) {
//				::logInfo("encounter became non valid " + e.getType());
				::MSU.Array.removeByValue(this.m.SettlementEncounters, e);
			}
//			::logInfo("cooldown still on, skipping the creation");
			return;
		}

		local list = [];
		foreach (e in this.World.Encounters.m.SettlementEncounters) {
			if (e.isValid(this)) {
				list.push(e);
			}
		}

		local count = this.Math.rand(3, 5);
		while(list.len() > count) {
			local r = this.Math.rand(0, list.len() - 1);
			list.remove(r);
		}
		this.m.SettlementEncounters.clear();
		foreach (e in list) {
			this.m.SettlementEncounters.push(e);
		}
		this.m.SettlementEncountersCooldownUntil = this.Time.getVirtualTimeF() + (5 * this.World.getTime().SecondsPerDay);
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function ( _out )
	{
		onSerialize(_out);
		_out.writeU8(this.m.Size);
		_out.writeBool(this.m.IsUpgrading);
		_out.writeF32(this.m.LastStablesUpdate);
		_out.writeI32(this.m.StablesSeed);
		this.m.ImportedGoodsInventory.onSerialize(_out);
		::MSU.Serialization.serialize(this.m.CaravanReceivedHistory, _out);
		::MSU.Serialization.serialize(this.m.CaravanSentHistory, _out);

		_out.writeF32(this.m.SettlementEncountersCooldownUntil);
		foreach(e in this.m.SettlementEncounters) {
			if (e.isValid(this)) {
				_out.writeBool(true);
				_out.writeString(e.getType());
			}
		}
		_out.writeBool(false);
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		onDeserialize(_in);
		this.m.Size = _in.readU8();
		this.m.IsUpgrading = _in.readBool();
		this.m.LastStablesUpdate = _in.readF32();
		this.m.StablesSeed = _in.readI32();

		this.m.ImportedGoodsInventory.onDeserialize(_in);
		this.m.CaravanReceivedHistory = ::MSU.Serialization.deserialize(_in);
		this.m.CaravanSentHistory = ::MSU.Serialization.deserialize(_in);

		this.m.SettlementEncountersCooldownUntil = _in.readF32();
		while(_in.readBool()) {
			local e = this.World.Encounters.getEncounter(_in.readString());
			if(e != null) {
				this.m.SettlementEncounters.push(e);
			}
		}
		this.updateSprites();
	}
});
