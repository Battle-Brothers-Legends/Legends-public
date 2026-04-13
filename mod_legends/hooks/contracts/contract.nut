::mods_hookBaseClass("contracts/contract", function ( o )
{
	while(!("ID" in o.m)) o=o[o.SuperName];

	o.m.Category <- "";
	o.m.Description <- "";
	o.m.DescriptionTemplates <- [];
	// Variables for item payment
	o.m.Payment.Items <- []; // stores negotiated item payment based contracts
	o.m.Payment.ItemPool <- []; // weighted list of available items
	o.m.Payment.IsSingleItem <- false; // option used to roll just single item from the list, normally money pool is used to buy items

	o.create = function()
	{
		local r;

		if (this.World.getTime().Days < 5)
		{
			r = this.Math.rand(1, 30);
		}
		else if (this.World.getTime().Days < 10)
		{
			r = this.Math.rand(1, 75);
		}
		else
		{
			r = this.Math.rand(1, 100);
		}

		if (r <= 30)
		{
			this.m.DifficultyMult = this.Math.rand(70, 85) * 0.01;
		}
		else if (r <= 75)
		{
			this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
		}
		else if (r <= 95)
		{
			this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = this.Math.rand(145, 165) * 0.01;
		}

		this.m.PaymentMult = this.Math.rand(90, 110) * 0.01;
		this.m.Flags = this.new("scripts/tools/tag_collection");
		this.m.TempFlags = this.new("scripts/tools/tag_collection");
		this.createStates();
		this.createScreens();
	}

	o.getDescription <- function()
	{
		return this.m.Description;
	}

	o.formatDescription <- function()
	{
		if (this.m.DescriptionTemplates.len() == 0)
			return;

		this.m.Description = ::MSU.Array.rand(this.m.DescriptionTemplates);
	}

	local getOnCompletion = o.m.Payment.getOnCompletion;
	o.m.Payment.getOnCompletion = function ()
	{
		local val = getOnCompletion();
		return this.Math.max(this.Const.Difficulty.MinPayments[this.World.Assets.getEconomicDifficulty()], val)
	}

	local getPerCount = o.m.Payment.getPerCount;
	o.m.Payment.getPerCount = function ()
	{
		local val = getPerCount();
		return this.Math.max(this.Const.Difficulty.MinHeadPayments[this.World.Assets.getEconomicDifficulty()], val)
	}

	o.getScaledDifficultyMult = function()
	{
		local s = this.Math.maxf(0.75, 0.94 * this.Math.pow(0.01 * this.World.State.getPlayer().getStrength(), 0.89));
		local d = this.Math.minf(5.0, s);
		return d * this.Const.Difficulty.EnemyMult[this.World.Assets.getCombatDifficulty()];
	}

	o.getPaymentMult = function()
	{
		local repDiffMult = this.Math.pow(this.getScaledDifficultyMult(), 0.5);
		local broMult = this.World.State.getPlayer().getBarterMult();
		return (this.m.PaymentMult + broMult) * (this.m.DifficultyMult * repDiffMult) * this.World.Assets.m.ContractPaymentMult;
	}

	o.getPaymentItems <- function() {
		local grouped = {};
		foreach (item in this.m.Payment.Items) {
			if (item.getID() in grouped) {
				grouped[item.getID()].count++;
				continue;
			}
			grouped[item.getID()] <- {
				item = item,
				count = 1
			};
		}

		local list = [];
		foreach (entry in grouped) {
			list.push({
				id = 1,
				icon = "ui/items/" + entry.item.getIcon(),
				text = (entry.count > 1 ? ::format("%dx ", entry.count) : "") + entry.item.getName()
			});
		}
		return list;
	}

	o.addUnitsToEntity = function ( _entity, _partyList, _resources )
	{
		local p;

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

			if (this.getDifficultyMult() >= 1.45)
			{
				mb += 15;
			}
			else if (this.getDifficultyMult() >= 1.15)
			{
				mb += 5;
			}
			else if (this.getDifficultyMult() >= 0.85)
			{
				mb += 0;
			}
			else
			{
				mb += -99;
			}

			for( local i = 0; i != t.Num; i = ++i )
			{
				this.Const.World.Common.addTroop(_entity, t, false, mb);
			}
		}

		if (_entity.isLocation())
		{
			_entity.resetDefenderSpawnDay();
		}

		_entity.updateStrength();
	}

	o.getUIMiddleOverlay = function()
	{
		if (("ShowDifficulty" in this.m.ActiveScreen) && this.m.ActiveScreen.ShowDifficulty)
		{
			switch ((this.getDifficulty()))
			{
				case 1:
					return {
						Image = "ui/images/difficulty_easy.png",
						IsProcedural = false
					};
				case 2:
					return {
						Image = "ui/images/difficulty_medium.png",
						IsProcedural = false
					};
				case 3:
					return {
						Image = "ui/images/difficulty_hard.png",
						IsProcedural = false
					};
			}
			return {
				Image = "ui/images/difficulty_legend.png",
				IsProcedural = false
			};
		}
		else
		{
			return null;
		}
	}

	o.getUIDifficultySmall = function()
	{
		switch (this.getDifficulty())
		{
			case 1:
				return "ui/icons/difficulty_easy";
			case 2:
				return "ui/icons/difficulty_medium";
			case 3:
				return "ui/icons/difficulty_hard";
			default:
				return  "ui/icons/difficulty_legend";
		}
	}

	o.getDifficulty <- function ()
	{
		if (this.m.DifficultyMult < 0.9)
			return 1;
		if (this.m.DifficultyMult < 1.1)
			return 2;
		if (this.m.DifficultyMult < 1.4)
			return 3;
		return 4;
	}

	o.resolveSituation = function ( _situationInstance, _settlement, _list = null)
	{
		if (_situationInstance == 0 || _settlement == null || typeof _settlement == "instance" && _settlement.isNull())
			return 0;

		local s = _settlement.getSituationByInstance(_situationInstance);
		local ret = _situationInstance;

		if (s != null)
		{
			if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			{
				ret = _settlement.resolveSituationByInstance(_situationInstance);
			}
			else
			{
				ret = _settlement.removeSituationByInstance(_situationInstance);
			}
		}

		if (_list != null && s != null && !_settlement.hasSituation(s.getID()))
		{
			_list.push({
				id = 10,
				icon = s.getIcon(),
				text = s.getRemovedString(_settlement.getName())
			});
		}

		return ret;
	}

	o.buildText <- function(_text)
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local brother1 = this.Math.rand(0, brothers.len() - 1);
		local brother2 = this.Math.rand(0, brothers.len() - 1);

		if (brothers.len() >= 2)
		{
			while (brother1 == brother2)
			{
				brother2 = this.Math.rand(0, brothers.len() - 1);
			}
		}

		local villages = this.World.EntityManager.getSettlements();
		local randomTown;

		do
		{
			randomTown = villages[this.Math.rand(0, villages.len() - 1)].getNameOnly();
		}
		while (randomTown == null || randomTown == this.m.Home.getNameOnly());

		local text;
		local vars = [
			[
				"SPEECH_ON",
				"\n\n[color=#bcad8c]\""
			],
			[
				"SPEECH_START",
				"[color=#bcad8c]\""
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
				"randomnoble",
				this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]
			],
			[
				"randombrother",
				brothers.len() < 2 ? "unknown" : brothers[brother1].getName()
			],
			[
				"randombrother2",
				brothers.len() < 2 ? "unknown" : brothers[brother2].getName()
			],
			[
				"randomtown",
				randomTown
			],
			[
				"reward_completion",
				this.m.Payment.getOnCompletion()
			],
			[
				"reward_advance",
				this.m.Payment.getInAdvance()
			],
			[
				"reward_count",
				this.m.Payment.getPerCount()
			],
			[
				"reward_item_count",
				this.m.Payment.Items.len()
			],
			[
				"employer",
				this.m.EmployerID != 0 ? this.Tactical.getEntityByID(this.m.EmployerID).getName() : ""
			],
			[
				"faction",
				this.World.FactionManager.getFaction(this.m.Faction).getName()
			],
			[
				"maxcount",
				this.m.Payment.MaxCount
			]
		];

		if (this.m.Origin != null) {
			vars.push([
				"origin",
				this.m.Origin.getName()
			]);
		}

		if (this.m.Home != null) {
			vars.push([
				"townname",
				this.m.Home.getName()
			]);
			vars.push(			[
				"produce",
				this.m.Home.getProduceAsString()
			]);
		}

		this.onPrepareVariables(vars);
		vars.push([
			"reward",
			this.m.Payment.getOnCompletion() + this.m.Payment.getInAdvance()
		]);
		if (this.m.EmployerID != 0)
		{
			::Const.LegendMod.extendVarsWithPronouns(vars, this.getEmployer(), "employer");
		}
		::Const.LegendMod.extendVarsWithPronouns(vars, brothers[brother1], "randombrother");
		::Const.LegendMod.extendVarsWithPronouns(vars, brothers[brother2], "randombrother2");
		// Dynamically handle pronouns for any additional actors in a contract
        // For this to work, any contract text using the placeholder pronoun must refer to the actor in the lowercase form of the actor's variable name
        // For example, the placeholder "%they_somebody%" will get the pronoun for this.m.Somebody
        foreach (key, value in this.m) {
            if (::MSU.isKindOf(value, "actor")) {
                ::Const.LegendMod.extendVarsWithPronouns(vars, value, key.tolower());
            }
        }
		return this.buildTextFromTemplate(_text, vars);
	}

	o.getUICategoryIcon <- function()
	{
		local c = this.getCategory();
		return c == "" ? "" : this.Const.Contracts.ContractCategoryIconMap[c];
	}

	o.getCategory <- function()
	{
		if (this.getFaction() > 0 && this.World.FactionManager.getFaction(this.getFaction()).getType() == this.Const.FactionType.Settlement && (this.m.Category == "" || this.m.Category == null))
		{
			// At the current phase, all Settlement contracts should have assigned categories
			::Legends.Mod.Debug.printWarning("Contract Overhaul: Missing Category for settlement contract: " + this.getName(),::Const.LegendMod.Debug.Flags.ContractCategories);
		}
		return this.m.Category;
	}

	o.setCategory <- function( _c )
	{
		this.m.Category = _c;
	}

	local getUIBulletpoints = o.getUIBulletpoints;
	o.getUIBulletpoints = function (_objectives = true, _payment = true) {
		local ret = getUIBulletpoints(_objectives, _payment);
		if (_payment) {
			foreach (entry in ret) {
				if (!("title" in entry))
					continue;
				if (entry.title != "Payment")
					continue;
				if (this.m.Payment.Pool == 0)
					entry.items = []; // this will fix dummy 100 coins minimum if there's no money in the pool
				if (this.m.Payment.Items.len() > 0) {
					entry.items.extend(::Legends.EventList.addItems(this.m.Payment.Items).map(@(_item) {
						icon = _item.icon,
						text = _item.text + " on completion"
					}));
				}
			}
			if (ret.map(@(_e) _e.title).find("Payment") == null) {
				ret.push({
					title = "Payment",
					items = ::Legends.EventList.addItems(this.m.Payment.Items).map(@(_item) {
						icon = _item.icon,
						text = _item.text + " on completion"
					}),
					fixed = true
				});
			}
		}
		return ret;
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function (_out) {
		onSerialize(_out);
		foreach (item in this.m.Payment.Items) {
			_out.writeBool(true);
			_out.writeI32(item.ClassNameHash);
			item.onSerialize(_out);
		}
		_out.writeBool(false);
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function(_in)
	{
		onDeserialize( _in );

		this.m.Payment.Items = [];
		while (_in.readBool()) {
			local item = ::new(::IO.scriptFilenameByHash(_in.readI32()));
			item.onDeserialize(_in);
			this.m.Payment.Items.push(item);
		}

		if (this.m.Flags.get("UpdatedBulletpoints"))
		{
			local contract_faction = this.World.FactionManager.getFaction(this.getFaction());
			local towns = contract_faction.getSettlements();
			this.m.BulletpointsObjectives.pop();
			if (this.m.Type == "contract.big_game_hunt"){
				this.m.BulletpointsObjectives.push("Return to any town of " + contract_faction.getName() + " to get paid")
			}
			else{
				this.m.BulletpointsObjectives.push("Return to any town of " + contract_faction.getName())
			}
			foreach (town in towns)
			{
				town.getSprite("selection").Visible = true;
			}
			this.World.State.getWorldScreen().updateContract(this);
		}
	}

});
