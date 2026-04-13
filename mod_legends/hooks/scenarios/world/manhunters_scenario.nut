::mods_hookExactClass("scenarios/world/manhunters_scenario", function (o) {
	o.create = function ()
	{
		this.m.ID = "scenario.manhunters";
		this.m.Name = "Manhunters";
		this.m.Description = "[p=c][img]gfx/ui/events/event_172.png[/img][/p][p]Constant conflict between city states and nomads makes for good business. The bulk of your outfit are captives, forced to fight to earn their freedom, and their ranks grow after each battle.\n\n[color=#bcad8c]Army of Captives:[/color] Start with two manhunters and four indebted. Take up to 16 men into battle at once. Having equal or fewer indebted than non-indebted will make your men dissatisfied.\n[color=#bcad8c]Overseers:[/color] All non-indebted can whip indebted in combat to reset their morale and buff their stats.\n[color=#bcad8c]Captives:[/color] Indebted earn 10% more experience, are capped at level 7, and will die if struck down. However, they are 50% cheaper to buy in towns.[/p]";
		this.m.Difficulty = 3;
		this.m.Order = 89;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(12);
		this.m.StartingBusinessReputation = 100;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	o.onSpawnAssets = function ()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 6; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
		}

		local bros = roster.getAll();
		local talents;
		bros[0].setStartValuesEx([
			"manhunter_background"
		]);
		bros[0].setTitle("the Stoic");
		bros[0].getBackground().m.RawDescription = "{In a sense, you don\'t particularly care for %name%. He\'s not hateful nor forgiving toward the prisoners of war, criminals, and the like. He just handles his business. But he\'s also this calm, unwavering way with you, and it\'s a bit bothersome. The man has so much potential, which is why you have him onboard for the %companyname%, but you just wished he showed some passion now and again.}";
		bros[0].setPlaceInFormation(12);
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.new("scripts/items/weapons/oriental/light_southern_mace"));
		::Legends.Actives.grant(bros[0], ::Legends.Active.WhipSlave);
		bros[0].m.Talents = [];
		talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 1;
		talents[this.Const.Attributes.Bravery] = 2;
		talents[this.Const.Attributes.RangedDefense] = 1;
		local traits = bros[0].getSkills().getAllSkillsOfType(this.Const.SkillType.Trait);

		foreach( t in traits )
		{
			if (!t.isType(this.Const.SkillType.Special) && !t.isType(this.Const.SkillType.Background))
			{
				bros[0].getSkills().remove(t);
			}
		}

		bros[1].setStartValuesEx([
			"manhunter_background"
		]);
		bros[1].setTitle("the Whip");
		bros[1].getBackground().m.RawDescription = "{%name% is one of the worst people you have ever come to know. He is relentlessly brutal on the indebted, even by your measure, and is responsible for outright killing a few of your catches. That said, his mean streak will serve the company well. And given that you\'ve already whipped him a time or three for losing inventory, you know he can take a hit as well as he can give it.}";
		bros[1].setPlaceInFormation(13);
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.southern_head_wrap]
		]));
		items.equip(this.new("scripts/items/weapons/battle_whip"));
		::Legends.Actives.grant(bros[1], ::Legends.Active.WhipSlave);
		bros[1].worsenMood(0.0, "Annoyed by your recent reprimand not to mistreat your captives");
		bros[1].m.Talents = [];
		talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Fatigue] = 2;
		talents[this.Const.Attributes.MeleeSkill] = 1;
		talents[this.Const.Attributes.Hitpoints] = 1;
		bros[2].setStartValuesEx([
			"slave_southern_background"
		]);
		bros[2].setTitle("the Learned");
		bros[2].getBackground().m.RawDescription = "{You found %name% being lawed by city guards. It looked like they were gonna play a game of \'catch the scimitar\' with his wrists until you intervened, opining that he owed the Gilder far before he owed any man. You hoped to offload him to high-paying Viziers, but none would take him as he was too \'learned\' and seemed the exact sort of threat to spur an uprising. Unusual to a man of his standing, he does harbor a fair bit of respect for you.}";
		bros[2].setPlaceInFormation(2);
		::Legends.Traits.remove(bros[2], ::Legends.Trait.Dumb);
		::Legends.Traits.grant(bros[2], ::Legends.Trait.Bright);
		bros[2].getSprite("miniboss").setBrush("bust_miniboss_indebted");
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/wooden_stick"));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.nomad_head_wrap]
		]));
		bros[2].worsenMood(0.0, "Misses his books");
		bros[3].setStartValuesEx([
			"slave_background"
		]);
		bros[3].setTitle("the Northerner");
		bros[3].getBackground().m.RawDescription = "{Not a friendly man by any means, but that\'s what the shackles are for. %name% was on the chopping block for a series of crimes when you happened upon him. You paid for his life as an investment, stating that he now owed hard work to find salvation in the Gilder\'s eyes. He\'s not so sure of your earnest beliefs, but you paid a priest to confirm that the man indeed owes his sweat to a higher sublimity.}";
		bros[3].setPlaceInFormation(3);
		bros[3].getSprite("miniboss").setBrush("bust_miniboss_indebted");
		local items = bros[3].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/bludgeon"));
		bros[3].worsenMood(2.0, "Almost got executed");
		bros[3].improveMood(2.0, "Relieved that he escaped execution");
		bros[3].worsenMood(0.0, "Worried about what awaits him next");
		bros[4].setStartValuesEx([
			"slave_southern_background"
		]);
		bros[4].setTitle("the Deserter");
		bros[4].getBackground().m.RawDescription = "{%name% is an heirloom of heresy, a man gifted to you by one of the Vizier\'s priests. The man was a deserter in the high lord\'s army, but through wealthy connections managed to avoid execution. However, there\'s only one way to avoid the fire of the hells, and that is through indebted gratitude. He will work for you until he finds salvation, and when that happens is entirely up to you.}";
		bros[4].setPlaceInFormation(4);
		bros[4].getSprite("miniboss").setBrush("bust_miniboss_indebted");
		local items = bros[4].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/militia_spear"));
		bros[4].worsenMood(0.5, "Feels cursed to have deserted one army only to end up an indebted in another");
		bros[5].setStartValuesEx([
			"slave_southern_background"
		]);
		bros[5].setTitle("the Beggar");
		bros[5].getBackground().m.RawDescription = "{Found on the streets, %name% never stood much of a chance. Being a beggar, it was physically easy to slap the chains on him, and socially no one would care. The Gilder cares not for those who do not work, and every day the man squandered without putting in his sweat he accrued a debt. Now it must be paid lest he taste that desert fire for eternity. He\'s actually healthier looking now than when you found him, though he never seems to thank you for this.}";
		bros[5].setPlaceInFormation(5);
		bros[5].getSprite("miniboss").setBrush("bust_miniboss_indebted");
		local items = bros[5].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/wooden_stick"));

		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/manhunters_ledger_item"));
		this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() + 9);
		this.World.Assets.m.Money = this.World.Assets.m.Money;
		this.World.Assets.m.ArmorParts = this.World.Assets.m.ArmorParts / 2;
		this.World.Assets.m.Medicine = this.World.Assets.m.Medicine / 2;
		this.World.Assets.m.Ammo = this.World.Assets.m.Ammo / 2;
	}

	o.onSpawnPlayer = function ()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isIsolatedFromRoads() && randomVillage.isSouthern())
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 4), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 4), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else
				{
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		this.countIndebted();
		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(18);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/worldmap_11.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.manhunters_scenario_intro");
		}, null);
	}

	o.onGenerateBro <- function (bro)
	{
		if (bro.getBackground().getID() == "slave_background")
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.5); //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 1.0; //1.0 = default (costs nothing)
			bro.getSkills().update();
		}
		else
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.0);
			bro.getBaseProperties().DailyWageMult *= 1.0;
			bro.getSkills().update();
		}
	}

	o.onInit = function ()
	{
		this.starting_scenario.onInit();
		this.World.Assets.m.BrothersMax = 25;
		this.World.Assets.m.BrothersMaxInCombat = 16;
		this.World.Assets.m.BrothersScaleMax = 14;
	}

	o.onHired = function ( _bro )
	{
		if (_bro.getBackground().getID() != "background.slave")
		{
			::Legends.Actives.grant(_bro, ::Legends.Active.WhipSlave);
		}
		else
		{
			_bro.getSprite("miniboss").setBrush("bust_miniboss_indebted");
		}

		this.countIndebted();
	}

	o.onCombatFinished <- function ()
	{
		this.countIndebted();
		return true;
	}

	o.onUnlockPerk = function ( _bro, _perkID )
	{
		if (_bro.getLevel() == 7 && _bro.getBackground().getID() == "background.slave" && _perkID == ::Legends.Perks.getID(::Legends.Perk.Student))
		{
			_bro.setPerkPoints(_bro.getPerkPoints() + 1);
		}
	}

	o.onUpdateLevel = function ( _bro )
	{
		if (_bro.getLevel() == 7 && _bro.getBackground().getID() == "background.slave" && _bro.getSkills().hasPerk(::Legends.Perk.Student))
		{
			_bro.setPerkPoints(_bro.getPerkPoints() + 1);
		}
	}

	o.onGetBackgroundTooltip = function ( _background, _tooltip )
	{
		if (_background.getID() != "background.slave")
		{
			if (_background.getID() == "background.wildman")
			{
				_tooltip.pop();
				_tooltip.push({
					id = 16,
					type = "text",
					icon = "ui/icons/xp_received.png",
					text = "[color=%negative%]-25%[/color] Experience Gain"
				});
			}
			else if (_background.getID() == "background.apprentice")
			{
				_tooltip.pop();
			}
			else if (_background.getID() == "background.historian")
			{
				_tooltip.pop();
				_tooltip.push({
					id = 16,
					type = "text",
					icon = "ui/icons/xp_received.png",
					text = "[color=%positive%]+5%[/color] Experience Gain"
				});
			}
			else
			{
				_tooltip.push({
					id = 16,
					type = "text",
					icon = "ui/icons/xp_received.png",
					text = "[color=%negative%]-10%[/color] Experience Gain"
				});
			}
		}
		else
		{
			_tooltip.push({
				id = 16,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=%positive%]+10%[/color] Experience Gain"
			});
			_tooltip.push({
				id = 17,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "Limited to character level 7"
			});
			_tooltip.push({
				id = 18,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "Is permanently dead if struck down and will not survive with a permanent injury"
			});
		}
	}

	o.countIndebted = function ()
	{
		local roster = this.World.getPlayerRoster().getAll();
		local indebted = 0;
		local nonIndebted = [];

		foreach( bro in roster )
		{
			if (bro.getBackground().getID() == "background.slave")
			{
				indebted++;
			}
			else
			{
				nonIndebted.push(bro);
			}
		}

		this.World.Statistics.getFlags().set("ManhunterIndebted", indebted);
		this.World.Statistics.getFlags().set("ManhunterNonIndebted", nonIndebted.len());
	}

});

