::mods_hookBaseClass("contracts/contract", function(o) {
	while(!("Payment" in o.m)) o = o[o.SuperName]; // find the base class
    if(!("_mod_legend" in o))
    {
        o._mod_legend <- true;// only override the methods once per base instance
    }

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

		if (brothers.len() < 2) {
			brother1 = "unknown"
			brother2 = "unknown"
		} else {
			brother1 = brothers[brother1].getName();
			brother2 = brothers[brother2].getName();
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
				brother1
			],
			[
				"randombrother2",
				brother2
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
				"employer",
				this.Tactical.getEntityByID(this.m.EmployerID).getName()
			],
			[
				"faction",
				this.World.FactionManager.getFaction(this.m.Faction).getName()
			],
			[
				"townname",
				this.m.Home.getName()
			],
			[
				"produce",
				this.m.Home.getProduceAsString()
			],
			[
				"origin",
				this.m.Origin.getName()
			],
			[
				"maxcount",
				this.m.Payment.MaxCount
			]
		];
		this.onPrepareVariables(vars);
		vars.push([
			"reward",
			this.m.Payment.getOnCompletion() + this.m.Payment.getInAdvance()
		]);
		return this.buildTextFromTemplate(_text, vars);
	}

	local payFn = o.m.Payment.getOnCompletion;
	o.m.Payment.getOnCompletion = function () 
	{
		local val = payFn();
		return this.Math.max(this.Const.Difficulty.MinPayments[this.World.Assets.getEconomicDifficulty()], val)
	}

	local headFn = o.m.Payment.getPerCount
	o.m.Payment.getPerCount = function ()
	{
		local val = headFn();
		return this.Math.max(this.Const.Difficulty.MinHeadPayments[this.World.Assets.getEconomicDifficulty()], val)
	}

	o.getReputationToDifficultyMult = function()
	{
		local s = this.Math.maxf(0.75, 0.94 * this.Math.pow(0.01 * this.World.State.getPlayer().getStrength(), 0.94));
		local d = this.Math.minf(5.0, s);
		return d * this.Const.Difficulty.EnemyMult[this.World.Assets.getCombatDifficulty()];
	}
//	o.getReputationToPaymentMult = function()
//	{
//		local r = this.Math.minf(2.7, this.Math.maxf(0.1, this.Math.pow(this.Math.maxf(0, 0.003 * this.World.Assets.getBusinessReputation()), 0.39)));
//		return r * this.Const.Difficulty.PaymentMult[this.World.Assets.getEconomicDifficulty()];
//	}
//
//	o.getReputationToPaymentLightMult = function()
//	{
//		local r = this.Math.minf(5.0, this.Math.maxf(0.1, this.Math.pow(this.Math.maxf(0, 0.003 * this.World.Assets.getBusinessReputation()), 0.35)));
//		return r * this.Const.Difficulty.PaymentMult[this.World.Assets.getEconomicDifficulty()];
//	}


	o.getPaymentMult = function()
	{
		local repDiffMult = this.Math.pow(this.getReputationToDifficultyMult(), 0.5);

		local roster = this.World.getPlayerRoster().getAll();
		local broMult = 0.0;
		foreach( bro in roster )
		{
			broMult += bro.getBarterModifier();
		}
		return (this.m.PaymentMult + broMult) * (this.m.DifficultyMult * repDiffMult);
	}

	o.addUnitsToEntity = function ( _entity, _partyList, _resources )
	{
		local total_weight = 0;
		local potential = [];

		this.logInfo("freykin contract test");
		//testing new bandit spawns
		if (_partyList.IsBandit == true)
		{
			this.logInfo("bandit contract spawn worked");
			local party = 
			{
				Cost = 0,
				MovementSpeedMult = _partyList.MovementSpeedMult,
				VisibilityMult = _partyList.VisibilityMult,
				VisionMult = _partyList.VisionMult,
				Body = _partyList.Body,
				Troops = []
			}
			
			local troops = _partyList.Troops;
			
			local melee_weight = _partyList.MeleeWeight;
			local cavalry_weight = _partyList.CavalryWeight;
			local ranged_weight _partyList.RangedWeight;
			local leader_weight = _partyList.LeaderWeight;
	
			total_weight = melee_weight + cavalry_weight + ranged_weight + leader_weight;
	
			if(total_weight != 1)
				this.logInfo("Contract Weight is not 100%");
			
			this.logInfo("Contract resources test" + _resources);
			
			while(_resources > 0)
			{
				local random = this.Math.rand(1, 100);
				
				local weight = 0;
				
				foreach(type in troops)
				{
					weight += type.Weight * 100;
					
					if (random <= weight)
					{
						local t = this.Math.rand(1, type.len() - 1);
						local troop = type[t];
						
						if(this.doesTroopAlreadyExist(troop, party.Troops))
						{
							local index = this.getTroopIndex(troop, party.Troops);
							++party.Troops[index].Num;
							_resources = _resources - troop.Cost;
							break;
						}
						troop.Num = 1;
						party.Troops.push(troop);
						_resources = _resources - troop.Cost;
					}
				}
			}
			
			foreach( t in party.Troops )
			{
				local mb;
	
				if (this.getDifficultyMult() >= 1.15)
				{
					mb = 5;
				}
				else if (this.getDifficultyMult() >= 0.85)
				{
					mb = 0;
				}
				else
				{
					mb = -99;
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
			this.logInfo("bandit contract test end");
			return;
		}

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

		local p;

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
			if (this.m.DifficultyMult < 0.9)
			{
				return {
					Image = "ui/images/difficulty_easy.png",
					IsProcedural = false
				};
			}
			else if (this.m.DifficultyMult >= 0.9 && this.m.DifficultyMult < 1.1)
			{
				return {
					Image = "ui/images/difficulty_medium.png",
					IsProcedural = false
				};
			}
			else if (this.m.DifficultyMult >= 1.1 && this.m.DifficultyMult < 1.4 )
			{
				return {
					Image = "ui/images/difficulty_hard.png",
					IsProcedural = false
				};
			}
			else
			{
				return {
					Image = "ui/images/difficulty_legend.png",
					IsProcedural = false
				};
			}
		}
		else
		{
			return null;
		}
	}

	o.getUIDifficultySmall = function()
	{
		if (this.m.DifficultyMult < 0.9)
		{
			return "ui/icons/difficulty_easy";
		}
		else if (this.m.DifficultyMult >= 0.9 && this.m.DifficultyMult < 1.1)
		{
			return "ui/icons/difficulty_medium";
		}
		else if (this.m.DifficultyMult >= 1.1 && this.m.DifficultyMult < 1.4)
		{
			return "ui/icons/difficulty_hard";
		}
		else
		{
			return "ui/icons/difficulty_legend";
		}
	}
});

o.doesTroopAlreadyExist <- function(_troop, _troops)
	{
		foreach(t in _troops)
		{
			if(_troop.Type == t.Type)
			return true;
		}
		return false;
	}
	
	o.getTroopIndex <- function(_troop, _troops)
	{
		for(i = 0; i < _troops.len(); ++i)
		{
			if(_troop == _troops[i])
				return i;
			else
				return null;
		}
	}