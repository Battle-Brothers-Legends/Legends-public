this.ork_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.ork_warband";
		this.m.Name = "Ork Warband";
		this.m.Description = "[p=c][img]gfx/ui/events/event_49.png[/img][/p][p]A band of orcs \n[color=#bcad8c]Warband:[/color] You can not enter towns, but can recruit and trade in your camp [color=#c90000]Fightiness[/color] The size of the horde grows and shrinks by winning battles. They would rather die than retreat. \n[color=#bcad8c]Ork Horde:[/color] You can only recruit other greenskins.\n";
		this.m.Difficulty = 2;
		this.m.Order = 180;
		this.m.StartingBusinessReputation = -50; // Still use default reputation tiers even if starting at negative reputation
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}

	function onSpawnAssets()
	{
		//turn on the camp builds for orks
		this.World.Flags.set("HasLegendCampRecruit", true);
		this.World.Flags.set("HasLegendCampTrader", true);
		
		local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 4; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			i = ++i;
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"orc_young_background"
		]);
		bros[0].getBackground().m.RawDescription = "A goblin warrior, %name% has been through many campaigns of raiding and pillaging. Although a creature of few words, the raider is an absolutely vicious specimen in battle. Even for a raider, what he does to defeated villagers irks many. It is likely he came with you to satiate his more sadistic lusts.";
		bros[0].improveMood(1.0, "Had a successful raid");
		bros[0].setPlaceInFormation(3);
		bros[0].setVeteranPerks(2);
		bros[0].m.PerkPoints = 2;
		bros[0].m.LevelUps = 2;
		bros[0].m.Level = 3;
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.Fatigue] = 1;
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		local warhound = this.new("scripts/items/accessory/warhound_item");
		warhound.m.Name = "Fenrir the Warhound";
		items.equip(warhound);
		local armor = this.new("scripts/items/legend_armor/cloth/legend_sackcloth");
		local plate = this.new("scripts/items/legend_armor/plate/legend_reinforced_animal_hide_armor");
		armor.setUpgrade(plate);
		items.equip(armor);
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/bear_headpiece"
			]
		]));
		bros[1].setStartValuesEx([
			"goblin_warrior_background"
		]);
		bros[1].getBackground().m.RawDescription = "%name% was a boy when taken from a southern village and raised amongst the goblins of the wastes. While he learned the language and culture, he never fit in and was a constant victim of cruel jokes and games. You are not sure if he has followed you to return home or to get away from his northern \'family\'.";
		bros[1].improveMood(1.0, "Had a successful raid");
		bros[1].setPlaceInFormation(4);
		bros[1].setVeteranPerks(2);
		bros[1].m.PerkPoints = 2;
		bros[1].m.LevelUps = 2;
		bros[1].m.Level = 3;
		bros[1].m.Talents = [];
		local talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.Hitpoints] = 1;
		talents[this.Const.Attributes.Fatigue] = 2;
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		local armor = this.new("scripts/items/legend_armor/cloth/legend_sackcloth");
		local plate = this.new("scripts/items/legend_armor/plate/legend_scrap_metal_armor");
		armor.setUpgrade(plate);
		items.equip(armor)

		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/leather_headband"
			]
		]));
		bros[2].setStartValuesEx([
			"goblin_ambusher_background"
		]);
		bros[2].getBackground().m.RawDescription = "Orc raiders often take from lands foreign to them. Most see their raids as a matter of material and meat, but occasionally they will enslave goblins with great potential. %name%, a northerner, was such a child and he was raised to be an ambusher himself. Half his life was with his primitive clan, and the other half with those who took him. This has made him as hardy and brutish a warrior as one can get.";
		bros[2].improveMood(1.0, "Had a successful raid");
		bros[2].setPlaceInFormation(5);
		bros[2].setVeteranPerks(2);
		bros[2].m.PerkPoints = 2;
		bros[2].m.LevelUps = 2;
		bros[2].m.Level = 3;
		bros[2].m.Talents = [];
		local talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 1;
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.Hitpoints] = 2;
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		local armor = this.new("scripts/items/legend_armor/cloth/legend_sackcloth_patched");
		local plate = this.new("scripts/items/legend_armor/plate/legend_hide_and_bone_armor");
		armor.setUpgrade(plate);
		items.equip(armor);
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/leather_helmet"
			]
		]));
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.addMoralReputation(-30.0);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/strange_meat_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/legend_dog_meat_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money / 2;
		this.World.Assets.m.Ammo = this.World.Assets.m.Ammo / 2;
	}

	function onSpawnPlayer()
	{
		local randomVillage;
		local northernmostY = 0;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			local v = this.World.EntityManager.getSettlements()[i];

			if (v.getTile().SquareCoords.Y > northernmostY && !v.isMilitary() && !v.isIsolatedFromRoads() && v.getSize() <= 2)
			{
				northernmostY = v.getTile().SquareCoords.Y;
				randomVillage = v;
			}

			i = ++i;
		}

		randomVillage.setLastSpawnTimeToNow();
		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 2), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 2));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 2), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 2));

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

		local attachedLocations = randomVillage.getAttachedLocations();
		local closest;
		local dist = 99999;

		foreach( a in attachedLocations )
		{
			if (a.getTile().getDistanceTo(randomVillageTile) < dist)
			{
				dist = a.getTile().getDistanceTo(randomVillageTile);
				closest = a;
			}
		}

		if (closest != null)
		{
			closest.setActive(false);
			closest.spawnFireAndSmoke();
		}

		local s = this.new("scripts/entity/world/settlements/situations/raided_situation");
		s.setValidForDays(5);
		randomVillage.addSituation(s);
		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local houses = [];

		foreach( n in nobles )
		{
			local closest;
			local dist = 9999;

			foreach( s in n.getSettlements() )
			{
				local d = s.getTile().getDistanceTo(randomVillageTile);

				if (d < dist)
				{
					dist = d;
					closest = s;
				}
			}

			houses.push({
				Faction = n,
				Dist = dist
			});
		}

		houses.sort(function ( _a, _b )
		{
			if (_a.Dist > _b.Dist)
			{
				return 1;
			}
			else if (_a.Dist < _b.Dist)
			{
				return -1;
			}

			return 0;
		});

		for( local i = 0; i < 2; i = i )
		{
			houses[i].Faction.addPlayerRelation(-200.0, "You are considered outlaws and barbarians");
			i = ++i;
		}

		houses[1].Faction.addPlayerRelation(18.0);
		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(5);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/barbarians_02.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.raiders_scenario_intro");
		}, null);
	}

	function isDroppedAsLoot( _item )
	{
		return this.Math.rand(1, 100) <= 15;
	}

	function onHiredByScenario( bro )
	{

	}


	function onUpdateHiringRoster( _roster )
	{
		this.addBroToRoster(_roster, "goblin_warrior_background", 4);
		this.addBroToRoster(_roster, "orc_warrior_background", 5);
		this.addBroToRoster(_roster, "goblin_ambusher_background", 7);
		this.addBroToRoster(_roster, "goblin_shaman_background", 4);
	}

	function onGenerateBro(bro)
	{
			if (this.World.Assets.getAverageMoodState() < this.Const.MoodState.Angry)
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.1)
				bro.getBaseProperties().DailyWageMult *= 1.1;
				bro.getSkills().update();
				bro.worsenMood(0.5, "Doesn't want to join a band of losers");
			}
			if (this.World.Assets.getAverageMoodState() < this.Const.MoodState.Disgruntled)
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.1)
				bro.getBaseProperties().DailyWageMult *= 1.1;
				bro.getSkills().update();
			}
			if (this.World.Assets.getAverageMoodState() < this.Const.MoodState.Concerned)
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.1)
				bro.getBaseProperties().DailyWageMult *= 1.1;
				bro.getSkills().update();
			}
			
			if (this.World.Assets.getAverageMoodState() > this.Const.MoodState.InGoodSpirit)
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.9)
				bro.getBaseProperties().DailyWageMult *= 0.9;
				bro.getSkills().update();
			}
			if (this.World.Assets.getAverageMoodState() > this.Const.MoodState.Eager)
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.9)
				bro.getBaseProperties().DailyWageMult *= 0.9;
				bro.getSkills().update();
			}
			if (this.World.Assets.getAverageMoodState() > this.Const.MoodState.Euphoric)
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.9)
				bro.getBaseProperties().DailyWageMult *= 0.9;
				bro.getSkills().update();
				bro.improveMood(0.5, "Keen to join a powerful warband");
			}
	
	}

});

