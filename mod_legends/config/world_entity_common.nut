if (!("World" in ::Const))
{
	::Const.World <- {};
}

::Const.World.Common.WorldEconomy <- {};

::Const.World.Common.WorldEconomy.Trade <- {
	// weigted container
	WeightedContainer = null,

	// the table to look up the price of an item, unrecorded one will be filled up automatically the first time it shows up
	PriceLookUp = {},

	// the max products should be generated
	PreferProduceNumMax = 9,

	// the maximum stash size of 'this.m.ImportedGoodsInventory' of any settlement
	ImportedGoodsInventorySizeMax = 50,

	// price of filler goods, the raw price of bread is ~52 crowns, so this is a bit overpriced
	// also net cost 50 so funnily it's not a bad filler goods
	PriceOfFillerGoods = 55,

	// for brigand_follower.nut retiune
	AmountOfLeakedCaravanInventoryInfo = 3,

	// don't want a single item to take up a large portion of the budget
	ExpensiveLimitMult = 0.90,

	// percentage of acceptable overbudget
	OverBudgetPct = 0.10,

	// percentage of profit make from investment
	ProfitPct = 0.40,

	// willing percentage of resources to invest on a trade
	PreferInvestmentMin = 1,
	PreferInvestmentMax = 2,

	DecisionID = {
		TradeGoods   = 0,
		Foods       = 1,
		Supplies   = 2,
		Weapons   = 3,
		Armors   = 4,
	    Exotic  = 5,
	    Misc   = 6,
		COUNT = 7,
	},

	// const for the list of possible decisions and to deciding which goods should be gathered, more can be added if you can specify the conditions
	Decisions = [
		{
			Weight = 2,
			Name = "TradeGoods",
			PreferShops = [],
			PreferNum = 2,
			PreferMax = 6,
			function IsValid( _item, _shopID )
			{
				if (!_item.isItemType(this.Const.Items.ItemType.TradeGood))
					return 0;

				return _item.getValue() * 0.65;
			}
		},
		{
			Weight = 1,
			Name = "Foods",
			PreferShops = [],
			PreferNum = 5,
			PreferMax = 20,
			function IsValid( _item, _shopID )
			{
				// must be a food_item and hasn't been bought by player
				if (!::MSU.isKindOf(_item, "food_item") || _item.m.BestBefore != 0.0)
					return 0;

				return _item.getValue();
			}
		},
		{
			Weight = 1,
			Name = "Supplies",
			PreferShops = [],
			PreferNum = 3,
			PreferMax = 10,
			function IsValid( _item, _shopID )
			{
				if (!_item.isItemType(this.Const.Items.ItemType.Supply))
					return 0;

				return _item.getValue() * 1.25;
			}
		},
		{
			Weight = 1,
			Name = "Weapons",
			PreferShops = ["building.weaponsmith", "building.fletcher", "building.blackmarket"],
			PreferNum = 2,
			PreferMax = 8,
			function IsValid( _item, _shopID )
			{
				if (_item.isItemType(this.Const.Items.ItemType.Ammo))
					return _item.getValue() * 1.33;

				if (_item.isItemType(this.Const.Items.ItemType.Weapon))
					return _item.getValue() * 0.70;

				return 0;
			}
		},
		{
			Weight = 1,
			Name = "Armors",
			PreferShops = ["building.armorsmith", "building.marketplace", "building.blackmarket"],
			PreferNum = 2,
			PreferMax = 8,
			function IsValid( _item, _shopID )
			{
				if (_item.isItemType(this.Const.Items.ItemType.Armor) || _item.isItemType(this.Const.Items.ItemType.Helmet))
					return _item.getValue() * 0.70;

				if (_item.isItemType(this.Const.Items.ItemType.Shield))
					return _item.getValue() * 0.82;

				return 0;
			},
		},
		{
			Weight = 2,
			Name = "Exotic",
			PreferShops = ["building.alchemist", "building.kennel", "building.blackmarket"],
			PreferNum = 2,
			PreferMax = 10,
			function IsValid( _item, _shopID )
			{
				if (_shopID == "building.alchemist" && _item.isItemType(this.Const.Items.ItemType.Tool))
					return _item.getValue() * 0.70;

				return _item.getValue();
			}
		},
		{
			Weight = 1,
			Name = "Misc",
			PreferShops = [],
			PreferNum = 2,
			PreferMax = 8,
			function IsValid( _item, _shopID )
			{
				return _item.getValue() >= 200 ? _item.getValue() : 0;
			}
		},
	],

	CaravanHistoryType = {
		Initiated = 0,
		Completed = 1,
		Destroyed = 2,
	},

	CaravanHistoryData = {
		type = null,
		originID = "",
		destinationID = "",
		investment = 0,
		profit = 0,
		itemHashes = [],
		coordinates = [],
	},

	function createCaravanHistoryData( _type, _originID, _destinationID, _investment, _profit, _items, _coordinates )
	{
		local data = clone this.CaravanHistoryData;
		data.type = _type;
		data.originID = _originID;
		data.destinationID = _destinationID;
		data.investment = _investment;
		data.profit = _profit;
		data.itemHashes = _items.map(function(item){ return item.ClassNameHash });
		data.coordinates = _coordinates // an array of length 2 for X, Y hexagonal coordiantes; when type is: Initiated->origin settlement, Completed->destination settlement, Destroyed->location of death
		return data;
	}

	function getCaravanHistoryDataItems( _data )
	{
		return _data.itemHashes.map(function(hash){return this.new( ::IO.scriptFilenameByHash(hash) )});
	}

	function getWeightContainer( _array = null )
	{
		if (this.WeightedContainer == null) this.WeightedContainer = ::MSU.Class.WeightedContainer();

		if (_array != null) {
			this.WeightedContainer.clear();
			this.WeightedContainer.addArray(_array);
		}

		return this.WeightedContainer;
	}

	function calculateTradingBudget( _settlement, _min = -1, _max = -1 )
	{
		local isMilitary = _settlement.isMilitary();
		local mult = 6.0 * (_settlement.getSize() + 1);

		if (isMilitary) mult *= 2.0;

		if (::MSU.isKindOf(_settlement, "city_state")) mult *= 1.75;

		local budget = ::Math.round(::Math.rand(50, 75 + (!isMilitary ? 10 : 0)) * mult);

		if (_min != -1) budget = ::Math.max(_min, budget); // budget shouldn't be smaller than _min

		if (_max != -1) budget = ::Math.min(_max, budget); // budget shouldn't be higher than _max

		return budget;
	}

	function setupTrade( _party, _settlement, _destination, _fixedBudget = -1, _minBudget = -1, _maxBudget = -1 )
	{
		local budget = _fixedBudget != -1 ? _fixedBudget : this.calculateTradingBudget(_settlement, _minBudget, _maxBudget);
		local result = this.makeTradingDecision(_settlement, budget);
		local finance = this.getExpectedFinancialReport(_settlement);

		// spend resources
		_settlement.addWorldEconomyResources(-finance.Investment);

		// set origin settlement
		_party.setOrigin(_settlement);

		// loading goods
		foreach (item in result.Items)
		{
			if (item.getTradeHistorySettlementIDs().len() == 0)
			{
				item.setOriginSettlement(_settlement);
			}
		}

		_party.getStashInventory().assign(result.Items);

		// setup financial flag
		_party.getFlags().set("CaravanProfit", finance.Profit); // expected profit made from this trade
		_party.getFlags().set("CaravanInvestment", finance.Investment); // investment on this trade :)
		_party.getFlags().set("CaravanDestinationID", _destination.getID());

		// record caravan history
		local coords = _settlement.getTile().Coords;
		local caravanHistoryData = this.createCaravanHistoryData(this.CaravanHistoryType.Initiated, _settlement.getID(), _destination.getID(), finance.Investment, finance.Profit, result.Items, [coords.X, coords.Y]);
		_settlement.updateCaravanSentHistory(caravanHistoryData);

		// print log to declare action
		//this.logWarning("Exporting " + _party.getStashInventory().getItems().len() + " items (" + result.Value + " crowns), focusing on trading \'" + result.Decision + "\', investing " + finance.Investment + " resources," /*expecting at least " + finance.Profit + " resouces as profit,*/ + " from " + _settlement.getName() + " via a caravan bound for " + _destination.getName() + " town");
	}

	function getExpectedFinancialReport( _settlement )
	{
		local result = {};
		result.Investment <- ::Math.max(1, ::Math.round(_settlement.getWealthBaseLevel() * ::Math.rand(this.PreferInvestmentMin, this.PreferInvestmentMax) * 0.01));
		result.Profit <- ::Math.round(result.Investment * this.ProfitPct);
		return result;
	}

	function makeTradingDecision( _settlement, _budget )
	{
		local decisions = this.compileTradingDecision(_settlement, _budget);

		if (decisions.Potential.len() == 0) return this.addFillerGoods(_settlement, _budget, null, false, "tools/throwing_net");

		local result;
		local name = this.getWeightContainer(decisions.Potential).roll();

		if (name == "FreshlyProduced")
			result = this.gatherProduce(_settlement, _budget);
		else
			result = this.gatherItems(_settlement, this.DecisionID[name], decisions.ItemList, _budget);

		result.Items.sort(function(_item1, _item2){
			if (_item1.getValue() > _item2.getValue()) return -1;
			else if (_item1.getValue() < _item2.getValue()) return 1;
			else return 0;
		});

		result.Decision <- name; // declare decision to trade what kind of goods
		return result;
	}

	function compileTradingDecision( _settlement, _budget )
	{
		local result = {};
		result.Potential <- [];
		result.ItemList <- [];

		// 1% to just straight up exporting nets \(>-<)/ instead of compiling any data
		if (::Math.rand(1, 100) == 1) return result;

		local acceptableBudget = ::Math.round(_budget * (1.0 + this.OverBudgetPct));
		local tooExpensiveLimit = ::Math.round(_budget * this.ExpensiveLimitMult);

		for(local i = 0; i < this.DecisionID.COUNT; ++i)
		{
			result.ItemList.push({
				Items = [],
				Average = 0,
				Total = 0,
			});
		}

		foreach(building in _settlement.getBuildings())
		{
			local stash = building.getStash();
			local shopID = building.getID();

			if (stash == null)
				continue;

			foreach(d in this.Decisions)
			{
				if (d.PreferShops.len() > 0 && d.PreferShops.find(shopID) == null)
					continue;

				foreach(_item in stash.getItems())
				{
					if (_item == null)
						continue;

					local v = ::Math.floor(d.IsValid(_item, shopID));

					if (v < 1 || // check if the item meets the condition of this 'choice of goods'
					 v >= tooExpensiveLimit) // a single item should not cost a large portion of the available budget
						continue;

					result.ItemList[this.DecisionID[d.Name]].Total += v;
					result.ItemList[this.DecisionID[d.Name]].Items.push({
						Item = _item,
						Stash = stash,
					});
				}
			}
		}

		foreach(i, list in result.ItemList)
		{
			local num = list.Items.len();

			if (num == 0) continue;

			list.Average = ::Math.floor(list.Total / num);

			local a = ::Math.floor(acceptableBudget / list.Average);

			if (a <= 0) continue;

			// the buy power is less than the prefer number of goods to gather
			if (a < this.Decisions[i].PreferNum)
			{
				// when the goods num is too low
				if (this.Decisions[i].PreferNum - 2 <= 0) continue;

				// chance to discard this decision
				//if (::Math.rand(1, 3) == 1) continue;

				// chance to discard this decision
				if (::Math.rand(a, this.Decisions[i].PreferNum) > this.Decisions[i].PreferNum + ::Math.floor((a - this.Decisions[i].PreferNum) / 2)) continue;
			}

			result.Potential.push([this.Decisions[i].Weight, this.Decisions[i].Name]);
		}

		if (_settlement.getProduce().len() > 0) result.Potential.push([1, "FreshlyProduced"]);

		return result;
	}

	function addFillerGoods( _settlement, _budget, _target = null, _isFull = false, _itemScript = "supplies/bread_item" )
	{
		local max = 15;

		if (_target == null) _target = { Items = [], Value = 0, Decision = "FillerGoods" };
		else max -= _target.Items.len();

		if (max <= 0) return _target;

		if (_isFull) max = ::Math.min(2, max);

		local num = ::Math.min(max, ::Math.max(1, ::Math.floor(_budget / this.PriceOfFillerGoods)));

		for (local i = 0; i < num; ++i)
		{
			_target.Items.push(::new("scripts/items/" + _itemScript));
			_target.Value += this.PriceOfFillerGoods;
		}

		return _target;
	}

	function gatherProduce( _settlement, _budget )
	{
		local map = {}; // to gather data for the weighted container
		local array = []; // for the weighted container
		local extra = ::Math.round(_budget * this.OverBudgetPct);
		local min = 9999999;

		foreach(p in _settlement.getProduce())
		{
			if (p in map)
			{
				map[p][0] += 1;
				continue;
			}

			map[p] <- [1, p];

			if (!(p in this.PriceLookUp)) this.PriceLookUp[p] <- ::new("scripts/items/" + p).getValue();

			if (min > this.PriceLookUp[p]) min = this.PriceLookUp[p];
		}

		// fill up the weigted array
		foreach(k, pair in map)
		{
			array.push(pair);
		}

		local ret = [];
		local tries = 0;
		local isOverBudget = false;
		local weight_container = this.getWeightContainer(array);
		local result = { Items = [], Value = 0 };

		while(tries < 25 && weight_container.len() > 0)
		{
			local r = weight_container.roll();

			if (this.PriceLookUp[r] > _budget)
			{
				if (isOverBudget || this.PriceLookUp[r] > _budget + extra)
				{
					++tries;
					// remove from selection list when the price can no longer be affordable
					weight_container.remove(r);
					continue;
				}

				// willing to go over budget for a little bit
				isOverBudget = true;
				_budget += extra;
			}

			// adds to the list
			result.Items.push(::new("scripts/items/" + r));

			// adds up the total cost
			result.Value += this.PriceLookUp[r];

			// reduces the remaining budget
			_budget -= this.PriceLookUp[r];

			// see if it exceeds the threshold
			if (result.Items.len() >= this.PreferProduceNumMax) break;

			// check if the remaning budget can still be enough to buy the cheapest product
			if (_budget < min) break;
		}

		// spend the last remaining budget for breads, who wouldn't want bread :)
		if (_budget >= this.PriceOfFillerGoods) this.addFillerGoods(_settlement, _budget, result, result.Items.len() >= this.PreferProduceNumMax);

		return result;
	}

	function gatherItems( _settlement, _index, _array, _budget )
	{
		local result = { Items = [], Value = 0 };
		local extra = ::Math.round(_budget * this.OverBudgetPct);
		local data = _array[_index];
		local isOverBudget = false;
		local tries = 0;

		while(tries < 50 && _budget > data.Average && data.Items.len() > 0)
		{
			local _i = data.Items.remove(::Math.rand(0, data.Items.len() - 1));
			local v = _i.Item.getValue();

			// check if the budget is enought to buy
			if (v > _budget)
			{
				if (isOverBudget || v > _budget + extra)
				{
					++tries;
					continue;
				}

				// willing to go over budget for a little bit
				isOverBudget = true;
				_budget += extra;
			}

			// adds to the list
			result.Items.push(_i.Item);

			// adds up the total cost
			result.Value += v;

			// removes from origin stash
			_i.Stash.remove(_i.Item);

			// reduces the remaining budget
			_budget -= v;

			if (result.Items.len() >= this.Decisions[_index].PreferMax) break;

			data.Total -= v;
			// recalculate the average price
			data.Average = ::Math.floor(data.Total / data.Items.len());
		}

		// spend the last remaining budget for breads, who wouldn't want bread :)
		if (_budget >= this.PriceOfFillerGoods) this.addFillerGoods(_settlement, _budget, result, result.Items.len() >= this.Decisions[_index].PreferMax);

		return result;
	}
};

::Const.World.Common.WorldEconomy.Settlement <- {
	UpgradeResourceCost = 50,
}

::Const.World.Common.assignTroops = function( _party, _partyList, _resources, _weightMode = 1 )
{
	local p;
	//New Legends Dynamic Spawn lists
	if (typeof(_partyList) == "table")
	{
		p = this.Const.World.Common.buildDynamicTroopList(_partyList, _resources)
	}
	//Vanilla partlyList spawnlists
	else
	{

		if (_partyList[_partyList.len() - 1].Cost < _resources * 0.7)
		{
			_resources = _partyList[_partyList.len() - 1].Cost;
		}

		local total_weight = 0;
		local best;
		local bestCost = _weightMode == this.WeightMode.Strongest ? -9000.0 : 9000;
		local potential = [];


		foreach( party in _partyList )
		{
			if (party.Cost < _resources * 0.7)
			{
				continue;
			}

			if (party.Cost > _resources)
			{
				break;
			}

			if (_weightMode == this.WeightMode.Weighted || _weightMode == this.WeightMode.Random)
			{
				potential.push(party);
				total_weight = total_weight + party.Cost;
			}
			else if (_weightMode == this.WeightMode.Strongest)
			{
				if (party.Cost > bestCost)
				{
					best = party;
					bestCost = party.Cost;
				}
			}
			else if (_weightMode == this.WeightMode.Weakest)
			{
				if (party.Cost < bestCost)
				{
					best = party;
					bestCost = party.Cost;
				}
			}
		}

		if (potential.len() == 0 && best == null)
		{
			bestCost = 9000;
			foreach( party in _partyList )
			{
				best = party;
				if (this.Math.abs(_resources - party.Cost) > bestCost)
				{
					break;
				}
				bestCost = this.Math.abs(_resources - party.Cost);
			}
			p = best;
		}
		else if (_weightMode == this.WeightMode.Random)
		{
			p = potential[this.Math.rand(0, potential.len() - 1)];
		}
		else if (_weightMode == this.WeightMode.Strongest || _weightMode == this.WeightMode.Weakest)
		{
			p = best;
		}
		else if (_weightMode == this.WeightMode.Weighted)
		{
			p = best;
			local pick = this.Math.rand(1, total_weight);
			foreach( party in potential )
			{
				p = party;
				if (pick <= party.Cost)
				{
					break;
				}

				pick = pick - party.Cost;
			}
		}
	}

	_party.setMovementSpeed(p.MovementSpeedMult * this.Const.World.MovementSettings.Speed);
	_party.setVisibilityMult(p.VisibilityMult);
	_party.setVisionRadius(this.Const.World.Settings.Vision * p.VisionMult);
	_party.getSprite("body").setBrush(p.Body);


	local troopMbMap = {};
	foreach( t in p.Troops )
	{
		local key = "Enemy" + t.Type.ID;
		if (!(key in troopMbMap))
		{
			troopMbMap[key] <- this.Const.LegendMod.GetFavEnemyBossChance(t.Type.ID);
		}

		local mb = troopMbMap[key];

		for( local i = 0; i != t.Num; i = ++i )
		{
			this.addTroop(_party, t, false, mb);
		}
	}

	_party.updateStrength();
	return p;
}

::Const.World.Common.addTroop = function ( _party, _troop, _updateStrength = true, _minibossify = 0 )
{
	local troop = clone _troop.Type;
	troop.Party <- this.WeakTableRef(_party);
	troop.Faction <- _party.getFaction();
	troop.Name <- "";

	if (troop.Variant > 0)
	{
		_minibossify = _minibossify + this.World.Assets.m.ChampionChanceAdditional;
		local upperBound = ("DieRoll" in troop) ? troop.DieRoll : 100;
		if (!this.Const.DLC.Wildmen || this.Math.rand(1, upperBound) > troop.Variant + _minibossify + (this.World.getTime().Days > 90 ? 0 : -1))
		{
			troop.Variant = 0;
		}
		else
		{
			troop.Strength = this.Math.round(troop.Strength * 1.35);
			troop.Variant = this.Math.rand(1, 255);

			if ("NameList" in _troop.Type)
			{
				troop.Name = this.generateName(_troop.Type.NameList) + ((_troop.Type.TitleList != null) ? " " + _troop.Type.TitleList[this.Math.rand(0, _troop.Type.TitleList.len() - 1)] : "");
			}
		}
	}

	_party.getTroops().push(troop);

	if (_updateStrength)
	{
		_party.updateStrength();
	}

	return troop;
}

::Const.World.Common.addUnitsToCombat = function( _into, _partyList, _resources, _faction, _minibossify = 0 )
{
	local p

	if (typeof(_partyList) == "table")
	{
		p = this.Const.World.Common.buildDynamicTroopList(_partyList, _resources)
	}
	else
	{
		local total_weight = 0;
		local potential = [];

		foreach( party in _partyList )
		{
			if (party.Cost < _resources * 0.7)
			{
				continue;
			}

			if (party.Cost > _resources)
			{
				break;
			}

			potential.push(party);
			total_weight = total_weight + party.Cost;
		}

		if (potential.len() == 0)
		{
			local best;
			local bestCost = 9000;

			foreach( party in _partyList )
			{
				if (this.Math.abs(_resources - party.Cost) <= bestCost)
				{
					best = party;
					bestCost = this.Math.abs(_resources - party.Cost);
				}
			}

			p = best;
		}
		else
		{
			local pick = this.Math.rand(1, total_weight);

			foreach( party in potential )
			{
				if (pick <= party.Cost)
				{
					p = party;
					break;
				}

				pick = pick - party.Cost;
			}
		}
	}

	local troopMbMap = {};
	foreach( t in p.Troops )
	{
		local key = "Enemy" + t.Type.ID;
		if (!(key in troopMbMap))
		{
			troopMbMap[key] <- this.Const.LegendMod.GetFavEnemyBossChance(t.Type.ID);
		}
		local mb = troopMbMap[key];
		mb += _minibossify;

		for( local i = 0; i != t.Num; i = ++i )
		{
			local unit = clone t.Type;
			unit.Faction <- _faction;
			unit.Name <- "";

			if (unit.Variant > 0)
			{
				local upperBound = ("DieRoll" in unit) ? unit.DieRoll : 100;
				if (!this.Const.DLC.Wildmen || this.Math.rand(1, upperBound) > unit.Variant + mb + (this.World.getTime().Days > 100 ? 0 : -1))
				{
					unit.Variant = 0;
				}
				else
				{
					unit.Strength = this.Math.round(unit.Strength * 1.35);
					unit.Variant = this.Math.rand(1, 255);

					if ("NameList" in unit)
					{
						unit.Name = this.generateName(unit.NameList) + (unit.TitleList != null ? " " + unit.TitleList[this.Math.rand(0, unit.TitleList.len() - 1)] : "");
					}
				}
			}

			_into.push(unit);
		}
	}
}

::Const.World.Common.dynamicSelectTroop <- function (_list, _resources, _scale, _map, _credits)
{
	local startingCredits = _credits;
	local candidates = [];
	local T = [];
	local totalWeight = 0;
	local dateToSkip = 0
	switch (this.World.Assets.getCombatDifficulty())
	{
		case this.Const.Difficulty.Easy:
			dateToSkip = 120;
			break;
		case this.Const.Difficulty.Normal:
			dateToSkip = 90
			break;
		case this.Const.Difficulty.Hard:
			dateToSkip = 60
			break;
		case this.Const.Difficulty.Legendary:
			dateToSkip = 30
			break;
	}
	dateToSkip = 90;

	//Go through each Item in the spawn list (which are structures defining enemies)
	foreach (t in _list)
	{
		// foreach (k,v in t) {
		//  	this.logInfo("K " + k + ": " +v)
		// }
		//Don't pick if resources are greater than threshold
		if ("MaxR" in t && _resources > t.MaxR)
		{
			continue;
		}

		//Don't pick if resources are less than threshold AND we have not surpassed
		//the given days in game based on Difficulty
		if ("MinR" in t)
		{
			local minr = 0;
			if (typeof(t.MinR) == "function")
			{
				minr = t.MinR()
			}
			else
			{
				minr = t.MinR;
			}

			if (_resources < minr && this.World.getTime().Days <= dateToSkip)
			{
				continue
			}
		}

		local w = 0
		if (typeof(t.Weight) == "function")
		{
			w = t.Weight(_scale)
		}
		else
		{
			w = t.Weight;
		}

		if (w == 0)
		{
			T.push(t)
			continue
		}
		totalWeight += w;
		candidates.push(t);
	}

	local r = this.Math.rand(1, totalWeight);
	foreach (t in candidates)
	{
		local w = 0;
		if (typeof(t.Weight) == "function")
		{
			w = t.Weight(_scale);
		}
		else
		{
			w = t.Weight;
		}
		r = r - w;
		if (r > 0)
		{
			continue;
		}
		T.push(t);
		break;
	}

	foreach (troop in T)
	{
		if ("Type" in troop)
		{

			local key = troop.Type.Script;
			if (!(key in _map))
			{
				_map[key] <- {
					Type = troop.Type,
					Num = 0
				}
			}

			if ("Roll" in troop)
			{
				if (typeof(troop.Roll) == "function")
				{
					if (!troop.Roll(_map[key].Num))
					{
						continue;
					}
				}
				else
				{
					local chance = 1.0 / (1.0 + this.Math.pow(_map[key].Num, 0.5)) * 100
					if (this.Math.rand(1, 100) > chance)
					{
						continue;
					}
				}
			}

			_credits -= troop.Cost;
			_map[key].Num += 1;


			if ("MaxCount" in troop)
			{
				for (local i = 1; i < troop.MaxCount; i = ++i)
				{
					if (_credits < 0)
					{
						break;
					}

					local w = 100;
					if (typeof(troop.Weight) == "function")
					{
						w = troop.Weight(_scale);
					}
					else
					{
						w = troop.Weight;
					}

					if (this.Math.rand(0, 100) < w)
					{
						_credits -= troop.Cost;
						local key = troop.Type.Script;
						if (!(key in _map))
						{
							_map[key] <- {
								Type = troop.Type,
								Num = 0
							}
						}
						_map[key].Num += 1;
					}
				}
			}

		}


		if ("Guards" in troop)
		{
			local maxCount = "MaxGuards" in troop ? troop.MaxGuards : 1;
			local minCount = "MinGuards" in troop ? troop.MinGuards : 1;
			for (local i = 0; i < maxCount; i = ++i)
			{
				local weight = 100;
				if ("MaxGuardsWeight" in troop)
				{
					weight = troop.MaxGuardsWeight;
				}
				local r = this.Math.rand(0, 100)
				if (weight < r && i >= minCount)
				{
					continue;
				}

				_credits = this.Const.World.Common.dynamicSelectTroop(troop.Guards, _resources, _scale, _map, _credits)

				if (_credits < 0)
				{
					break;
				}
			}
		}

		if (_credits < 0)
		{
			return _credits;
		}

		if (!("SortedTypes" in troop))
		{
			continue;
		}

		local points = troop.SortedTypes[0].Cost;
		if (troop.SortedTypes.len() > 1)
		{
			local meanScaled = troop.MinMean + _scale * (troop.MaxMean - troop.MinMean)
			points = this.Math.max(points, this.Const.LegendMod.BoxMuller.BoxMuller(meanScaled, troop.Deviation));
			//this.logInfo(cat + " Mean " + meanScaled + " : Deviation " + troops.Deviation + " : Points " + points)
		}

		//Always purchase the most expensive unit we can
		for (local i = troop.SortedTypes.len() - 1; i >= 0; i = --i)
		{
			if (troop.SortedTypes[i].Cost > points)
			{
				continue;
			}

			local index = this.Math.rand(0, troop.SortedTypes[i].Types.len() - 1);

			if ("MaxR" in troop.SortedTypes[i].Types[index] && _resources > troop.SortedTypes[i].Types[index].MaxR)
			{
				continue;
			}

			if ("MinR" in  troop.SortedTypes[i].Types[index])
			{
				local minr = 0;
				if (typeof(troop.SortedTypes[i].Types[index].MinR) == "function")
				{
					minr = troop.SortedTypes[i].Types[index].MinR()
				}
				else
				{
					minr = troop.SortedTypes[i].Types[index].MinR;
				}

				if (_resources < minr && this.World.getTime().Days <= dateToSkip)
				{
					continue
				}
			}

			local key = troop.SortedTypes[i].Types[index].Type.Script;
			if (!(key in _map))
			{
				_map[key] <- {
					Type = troop.SortedTypes[i].Types[index].Type,
					Num = 0
				}
			}

			if ("Roll" in troop)
			{
				if (typeof(troop.Roll) == "function")
				{
					if (!troop.Roll(_map[key].Num))
					{
						continue;
					}
				}
				else
				{
					local chance = 1.0 / (1.0 + this.Math.pow(_map[key].Num, 0.5)) * 100
					if (this.Math.rand(1, 100) > chance)
					{
						continue;
					}
				}
			} else if ("Roll" in troop.SortedTypes[i].Types[index]) {
				if (typeof(troop.SortedTypes[i].Types[index].Roll) == "function")
				{
					if (!troop.SortedTypes[i].Types[index].Roll(_map[key].Num))
					{
						continue;
					}
				}
				else
				{
					local chance = 1.0 / (1.0 + this.Math.pow(_map[key].Num, 0.5)) * 100
					if (this.Math.rand(1, 100) > chance)
					{
						continue;
					}
				}
			}



			_credits -= troop.SortedTypes[i].Types[index].Cost;
			_map[key].Num += 1

			if ("Guards" in troop.SortedTypes[i].Types[index])
			{
				_credits = this.Const.World.Common.dynamicSelectTroop(troop.SortedTypes[i].Types[index].Guards, _resources, _scale, _map, _credits)
			}
			break;
		}
	}
//	if (startingCredits == _credits && T.len() > 0) {
//		throw "dynamicSelectTroop didn't change credits"
//	}
	return _credits
}

::Const.World.Common.buildDynamicTroopList <- function( _template, _resources)
{
//	::logInfo("*DynamicTroopList : template = " + _template.Name + " : resources = " + _resources)
	local credits = _resources;
	if ("MinR" in _template)
	{
		credits = this.Math.max(_template.MinR, credits);
	}
	local scale = "MaxR" in _template ? (_resources * 1.0) / (_template.MaxR * 1.0) : 1.0;
	local troopMap = {};
	local prevPoints = 0;

	if ("Fixed" in _template)
	{
		credits = this.Const.World.Common.dynamicSelectTroop(_template.Fixed, _resources, scale, troopMap, credits);
	}

	if ("Troops" in _template && _template.Troops.len() > 0)
	{
		local tries = 200;
		while (credits > 0 && tries > 0)
		{
			credits = this.Const.World.Common.dynamicSelectTroop(_template.Troops, _resources, scale, troopMap, credits);
			tries--;
		}
	}

	local T = []
	foreach ( k, v in troopMap)
	{
		T.push(v);
	}


	//TESTING
//	 foreach (t in T)
//	 {
//	 	::logInfo(t.Type.Script + " : " + t.Num);
//	 }

	return {
		MovementSpeedMult = _template.MovementSpeedMult,
		VisibilityMult = _template.VisibilityMult,
		VisionMult = _template.VisionMult,
		Body = _template.Body,
		Troops = T
	}
}

::Const.World.Common.pickLegendArmor <- function (_list)
{
	return this.Const.World.Common.pickItem(_list, "scripts/items/legend_armor/")
}

::Const.World.Common.pickLegendHelmet <- function (_list)
{
	return this.Const.World.Common.pickItem(_list, "scripts/items/legend_helmets/")
}

::Const.World.Common.pickItem <- function (_list, _script = "")
{
	local candidates = []
	local totalWeight = 0
	local w = 0
	foreach (t in _list)
	{
		if (t[0] == 0)
		{
			continue;
		}
		candidates.push(t)
		totalWeight += t[0]
	}

	local r = this.Math.rand(0, totalWeight);
	foreach (t in candidates)
	{
		r = r - t[0];
		if (r > 0)
		{
			continue;
		}

		if (_script == "")
		{
			return t[1];
		}

		if (t[1] == "")
		{
			return null
		}
		local ret = this.new(_script + t[1]);
		if (t.len() == 3)
			ret.setVariant(t[2])
		return ret;
	}
	return null;
}

::Const.World.Common.pickHelmet <- function (_helms)
{
	local candidates = [];
	local totalWeight = 0;
	foreach (t in _helms)
	{
		if (t[0] == 0)
		{
			continue;
		}
		candidates.push(t);
		totalWeight += t[0];
	}

	local r = this.Math.rand(0, totalWeight);
	local helm = "";
	local variant = null;
	foreach (t in candidates)
	{
		r = r - t[0];
		if (r > 0)
		{
			continue;
		}
		helm = t[1];

		if (t.len() == 3)
		{
			variant = t[2];
		}
		break;
	}

	//Disabling helmet layers temporariliy
	if (helm == "")
	{
		return null;
	}
	// return this.new("scripts/items/helmets/" + helm);


	local layersObj = this.Const.LegendMod.Helmets[helm];
	if (layersObj.Script != "")
	{
		local helmet = this.new(layersObj.Script);
		if (variant != null)
		{
			helmet.setupArmor(variant);
		}
		return helmet;
	}

	local set = layersObj.Sets[this.Math.rand(0, layersObj.Sets.len() -1)]
	local helmet = this.Const.World.Common.pickLegendHelmet(set.Hoods);
	if (helmet != null)
	{
		if (variant != null)
		{
			if (helm == "greatsword_faction_helm") //this doesn't set variant properly for things like [1, "hood", 63] in cripple_background file
				helmet.setupArmor(variant);
		}

		 local helm = this.Const.World.Common.pickLegendHelmet(set.Helms);
		 if (helm != null)
		 {
			 helmet.setUpgrade(helm)
		 }

		 local top = this.Const.World.Common.pickLegendHelmet(set.Tops);
		 if (top != null)
		 {
			 helmet.setUpgrade(top)
		 }

		local van = this.Const.World.Common.pickLegendHelmet(set.Vanity);
		 if (van != null)
		 {
			 helmet.setUpgrade(van)
		 }

		if ("Vanity2" in set)
		{
			local van2 = this.Const.World.Common.pickLegendHelmet(set.Vanity2);
			if (van2 != null)
			{
				helmet.setUpgrade(van2)
			}
		}
	}

	return helmet;
}

::Const.World.Common.pickArmor <- function (_armors)
{
	local candidates = [];
	local totalWeight = 0;
	foreach (t in _armors)
	{
		if (t[0] == 0)
		{
			continue;
		}
		candidates.push(t);
		totalWeight += t[0];
	}

	local r = this.Math.rand(0, totalWeight);
	local armorID = "";
	local variant = null;
	local faction = null;
	foreach (t in candidates)
	{
		r = r - t[0];
		if (r > 0)
		{
			continue;
		}
		armorID = t[1];
		if (t.len() == 3)
		{
			variant = t[2];
		}
		if (t.len() == 4)
		{
			faction = t[3];
		}
		break;
	}

	if (armorID == "")
	{
		return null;
	}


	if (!(armorID in this.Const.LegendMod.Armors))
	{

		return this.new("scripts/items/armor/" + armorID);
	}

	local layersObj = this.Const.LegendMod.Armors[armorID];
	if (layersObj.Script != "")
	{
		local item = this.new(layersObj.Script);
		if (faction != null)
		{
			item.setupArmor(faction);
		}
		return item;
	}

	local set = layersObj.Sets[this.Math.rand(0, layersObj.Sets.len() -1)]
	local armor = this.Const.World.Common.pickLegendArmor(set.Cloth);
	if (armor == null)
	{
		return this.new("scripts/items/armor/" + armorID);
	}

	if (faction != null)
	{
		armor.setupArmor(faction);
	}

	local chain = this.Const.World.Common.pickLegendArmor(set.Chain);
	if (chain != null)
	{
		armor.setUpgrade(chain)
	}

	local plate = this.Const.World.Common.pickLegendArmor(set.Plate);
	if (plate != null)
	{
		armor.setUpgrade(plate)
	}

	local cloak = this.Const.World.Common.pickLegendArmor(set.Cloak);
	if (cloak != null)
	{
		armor.setUpgrade(cloak)
	}

	local tab = this.Const.World.Common.pickLegendArmor(set.Tabard);
	if (tab != null)
	{
		armor.setUpgrade(tab)
	}

	local att = this.Const.World.Common.pickLegendArmor(set.Attachments);
	if (att != null)
	{
		armor.setUpgrade(att)
	}

	return armor;
}

::Const.World.Common.pickArmorUpgrade <- function (_armors)
{
	local candidates = [];
	local totalWeight = 0;
	foreach (t in _armors)
	{
		if (t[0] == 0)
		{
			continue;
		}
		candidates.push(t);
		totalWeight += t[0];
	}

	local r = this.Math.rand(0, totalWeight);
	local armorID = "";
	local variant = null;
	local faction = null;
	foreach (t in candidates)
	{
		r = r - t[0];
		if (r > 0)
		{
			continue;
		}
		armorID = t[1];
		if (t.len() == 3)
		{
			variant = t[2];
		}
		if (t.len() == 4)
		{
			faction = t[3];
		}
		break;
	}


	if (!(armorID in this.Const.LegendMod.Armors))
	{
		return this.new("scripts/items/armor_upgrades/" + armorID);
	}

	local layersObj = this.Const.LegendMod.Armors[armorID];
	if (layersObj.Script != "")
	{
		return this.new(layersObj.Script);
	}

	return null;
}

/*

	_outfitArr
	[
		[1, "my outfit"]
		[1, "my outfit"]
	]

	_armorArr same
	_helmetArr same


*/

//Operating assuming that if we have chance not -1 we sent in an armor and helmet array that aren't null
::Const.World.Common.pickOutfit <- function ( _outfitArr, _armorArr = null, _helmetArr = null, _chance = 0)
{
	if (_chance != 0)
	{
		if (this.Math.rand(1, 100) >= _chance)
		{
			// this.logInfo("Pick outfit rolled against a chance and returned two things")
			return [this.Const.World.Common.pickArmor(_armorArr), this.Const.World.Common.pickHelmet(_helmetArr)]
		}
	}
	else if (_armorArr != null && _helmetArr != null && _armorArr.len() > 0 && _helmetArr.len() > 0)
	{
		local armorCount = 0
		local helmCount = 0
		local outfitCount = 0

		foreach (t in _armorArr)
		{
			if (t[0] > 0)
			{
				armorCount += 1
			}
		}
		foreach (t in _helmetArr)
		{
			if (t[0] > 0)
			{
				helmCount += 1
			}
		}
		foreach (t in _outfitArr)
		{
			if (t[0] > 0)
			{
				outfitCount += 1
			}
		}

		if (this.Math.rand(1, armorCount * helmCount) > outfitCount)
		{
			// this.logInfo("Pick outfit rolled against an armor*helmcount and returned two things")
			return [this.Const.World.Common.pickArmor(_armorArr), this.Const.World.Common.pickHelmet(_helmetArr)]
		}
	}

	local candidates = [];
	local totalWeight = 0;
	foreach (t in _outfitArr)
	{
		if (t[0] == 0)
		{
			continue;
		}
		candidates.push(t);
		totalWeight += t[0];
	}

	local r = this.Math.rand(0, totalWeight);
	local outfitID = "";
	foreach (t in candidates)
	{
		r = r - t[0];
		if (r > 0)
		{
			continue;
		}
		outfitID = t[1];
		break;
	}

	local layersObj = this.Const.LegendMod.Outfits[outfitID];
	// this.logInfo("Pick outfit picked an outfit")
	return [this.Const.World.Common.pickArmor(layersObj.Body), this.Const.World.Common.pickHelmet(layersObj.Helmet)]

}

::Const.World.Common.convNameToList <- function ( _named )
{
	local findString = ["helmets/", "armor/", "legend_armor/", "legend_helmets/"];
	local retArr = [];
	foreach( search in findString )
	{
		if (_named[0].find(search) != null ) //was this list
		{
			foreach( item in _named )
			{
				retArr.push(
					[1, item.slice(item.find(search) + search.len())]
				);
			}
			break; //can skip 1-2 list[0].finds with this
		}
	}
	return retArr;
}

::Const.World.Common.getArenaBros <- function()
{
	local ret = [];
	local roster = this.World.getPlayerRoster().getAll();

	foreach( bro in roster )
	{
		local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

		if (item != null && item.getID() == "accessory.legend_arena_collar")
		{
			ret.push(bro);
		}
	}

	return ret;
}

if (!("LegendMod" in ::Const))
{
	::Const.LegendMod <- {};
}

::Const.LegendMod.BoxMuller <- {
	UseLast = false,
	NextValue = 0.0,
	function generate()
	{
		if (this.UseLast)
		{
			this.UseLast = false;
			return this.NextValue;
		}
		local s = 0.0;
		local v1 = 0.0;
		local v2 = 0.0;
		while (s >= 1.0 || s == 0.0)
		{
			v1 = 2.0 * this.Math.rand(0, 1000) / 1000 - 1.0;
			v2 = 2.0 * this.Math.rand(0, 1000) / 1000 - 1.0;
			s = v1 * v1 + v2 * v2;
		}

		s = this.Math.pow(-2.0 * log(s) / s, 0.5);
		this.NextValue = v2 * s
		this.UseLast = true;
		return v1 * s;
	}

	function BoxMuller( _mean, _deviation )
	{
		local g = this.generate()
		return _mean + g * _deviation;
	}

	function Next( _min, _max )
	{
		local deviations = 3.5;
		local r = _max + 1; //so we iterate at least once
		while (r > _max || r < _min)
		{
			r = this.BoxMuller(_min + (_max - _min) / 2.0, (_max - _min) / 2.0 / deviations);
		}
		return r;
	}
}

::Const.World.Common.addHostileUnitsToCombat <- function ( _into, _partyList, _resources, _faction, _minibossify = 0)
{
	local fact = _faction;
	// this.logWarning("Faction: " + fact)
	if (this.World.FactionManager.isAlliedWithPlayer(_faction))
	{
		fact = this.World.FactionManager.getFactionOfType(this.Const.FactionType.DummyFaction).getID();
		// this.logWarning("Modified: " + fact)
	}
	this.Const.World.Common.addUnitsToCombat(_into, _partyList, _resources, fact, _minibossify = 0)
}

//Perks array is [weight, perk name, cost]
//Returns array of perks
//You could modify this too by changing the perk name to be an array of perks (which is what trees are), and add that for a cost instead + iterate thru that tree
//This has no "smart" selecting meaning you could theoretically get wildly random perks, but because I'm using this currently for themed units it's not an issue in that scenario
//THIS CANNOT AND WILL NOT CHECK IF THE PERK ALREADY EXISTS ON THE ENTITY YOU SHOULD PROBABLY NOT THROW IN RANDOMIZED PERKS THAT THE UNIT ALREADY HAS BE ETHICAL PLEASE
::Const.World.Common.pickPerks <- function (_perks, _power)
{
	if (_perks.len() == 0)
	{
		return [];
	}
	if (_power == 0)
	{
		return [];
	}

	local candidates = [];
	local totalWeight = 0;
	foreach (t in _perks)
	{
		if (t[0] == 0)
		{
			continue;
		}
		if (t[2] > _power)
		{
			continue; //no need to add stuff that's a cost higher than our power selector
		}
		candidates.push(t);
		totalWeight += t[0];
	}

	local ret = [];
	while (_power > 0) {

		if (candidates.len() == 0) { return ret; }

		local r = this.Math.rand(0, totalWeight);
		foreach (i, t in candidates)
		{
			r = r - t[0];
			if (r > 0)
			{
				continue;
			}
			local skill = null;
			if (typeof t[1] == "string")
			{
				skill = this.new("scripts/skills/perks/" + t[1]);
				ret.push(skill);
			}
			else if (typeof t[1] == "array")
			{
				foreach(s in t[1])
				{
					skill = this.new("scripts/skills/perks/" + s);
					ret.push(skill);
				}
			}
			else { logWarning("Attempted to select perks from something that isn't a string or an array") }

			totalWeight -= t[0];
			_power -= t[2];
			candidates.remove(i);
		}
		//we necessarily had to have selected something to get here so we check if anything has a higher power + remove it
		local garbage = [];
		foreach (i, t in candidates)
		{
			if (t[2] > _power) { garbage.push(i) } //checking like this means if we only have 2 power costs left and have 1 it won't put us negative
		}
		garbage.reverse();
		foreach (i in garbage)
		{
			candidates.remove(i)
		}
	}
	return ret;
}

//testing for perk selector
// local testArray = [
// 	// [1, "perk_nimble", 2],
// 	[1, "perk_relentless", 1],
// 	[1, "perk_brawny", 1],
// 	[1, "perk_steel_brow", 3],
// 	// [1, "perk_battle_forged", 2],
// 	[1, "perk_lookout", 1],
// 	[1, ["perk_battle_forged", "perk_nimble"], 3]
// ]

// local perksPicked = this.Const.World.Common.pickPerks(testArray, 5)
// foreach(p in perksPicked)
// {
// 	this.logInfo("Selected the perk: " + p.getID())
// }
// this.logInfo("----------------------")
// local perksPicked = this.Const.World.Common.pickPerks(testArray, 20)
// foreach(p in perksPicked)
// {
// 	this.logInfo("Selected the perk: " + p.getID())
// }
// this.logInfo("----------------------")
// local perksPicked = this.Const.World.Common.pickPerks(testArray, 0)
// foreach(p in perksPicked)
// {
// 	this.logInfo("Selected the perk: " + p.getID())
// }


// TESTING
// foreach(k,v in this.Const.World.Spawn)
// {
// 	if (k == "Troops" || k == "Unit" || k == "TroopsMap")
// 	{
// 		continue;
// 	}

// 	if (typeof(v) != "table")
// 	{
// 		continue
// 	}

// 	if (!("MaxR" in v))
// 	{
// 		continue;
// 	}

// 	local P = [0.15, 0.25, 0.50, 0.75, 1];

// 	this.logInfo("****** " + k + " ******")
// 	foreach (p in P)
// 	{
// 		this.logInfo(" >>> Percent:  " + p + " <<<")
// 		for (local i = 0; i < 3; i = ++i)
// 		{
// 			this.logInfo(" RUN  " + i)
// 			local res = ::Const.World.Common.buildDynamicTroopList(v, p * v.MaxR)
// 			foreach (t in res.Troops)
// 			{
// 				this.logInfo(t.Type.Script + " : " + t.Num)
// 			}
// 		}

// 	}
// }

// local weight = [30, 100, 160, 200];
// local pList = [

// 	this.Const.World.Spawn.Peasants

// ];
// foreach ( p in pList )
// {
// 	foreach ( w in weight )
// 	{
// 		for (local i = 0; i < 25; i = ++i)
// 		{

// 			this.logWarning(" RUNNING ON TROOP: " + p);
// 			this.logInfo(" RUN: " + i + ", OF WEIGHT: " + w);

// 			local res = ::Const.World.Common.buildDynamicTroopList(p, w);
// 			foreach (t in res.Troops)
// 				this.logInfo(t.Type.Script + " : " + t.Num);

// 		}
// 	}
// }
