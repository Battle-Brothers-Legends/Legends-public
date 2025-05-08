::mods_hookExactClass("scenarios/world/deserters_scenario", function (o) {
	o.create = function ()
	{
		this.m.ID = "scenario.deserters";
		this.m.Name = "Deserters";
		this.m.Description = "[p=c][img]gfx/ui/events/event_88.png[/img][/p][p]For too long have you been dragged from one bloody battle to another at the whim of lords sitting in high towers. Last night, you absconded from camp together with three others. You\'re dressed like soldiers still, but you\'re deserters, and the noose will be your end if you stay here for too long.\n[color=#bcad8c]Deserters:[/color] Start with three deserters and decent armor, but lower funds, you can only be joined by outlaws or combat backgrounds, and a noble house that wants to hunt you down.\n[color=#bcad8c]First to Run:[/color] Your men always are first to act in the very first round of combat.\n[color=#c90000]Like Minded:[/color] Increased chance of finding craven dastards, deserters and the disowned. [/p]";
		this.m.Difficulty = 2;
		this.m.Order = 100;
		this.m.StartingBusinessReputation = 150;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	o.setupBro <- function ( _bro, _faction )
	{
		_bro.setStartValuesEx([
			"deserter_background"
		]);
		_bro.worsenMood(1.0, "Was dragged from one bloody battle to the next");
		_bro.improveMood(1.5, "Deserted from the army");
		_bro.m.HireTime = this.Time.getVirtualTimeF();
		_bro.m.Talents = [];
		_bro.m.Attributes = [];
		_bro.m.Talents.resize(this.Const.Attributes.COUNT, 0);

		if (this.Math.rand(1, 100) <= 50)
		{
			_bro.addHeavyInjury();
		}
		else if (this.Math.rand(1, 100) <= 50)
		{
			_bro.addLightInjury();
		}

		local items = _bro.getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		local shield = this.new("scripts/items/shields/faction_heater_shield");
		shield.setFaction(_faction.getBanner());
		items.equip(shield);

		if (this.Math.rand(1, 100) <= 33 && items.getItemAtSlot(this.Const.ItemSlot.Head) != null)
		{
			items.getItemAtSlot(this.Const.ItemSlot.Head).setCondition(items.getItemAtSlot(this.Const.ItemSlot.Head).getRepairMax() * 0.5);
		}

		if (this.Math.rand(1, 100) <= 33 && items.getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
		{
			items.getItemAtSlot(this.Const.ItemSlot.Mainhand).setCondition(items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getRepairMax() * 0.5);
		}

		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		local armor = this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.mail_hauberk, 28],
			[1, ::Legends.Armor.Standard.mail_shirt],
			[1, ::Legends.Armor.Standard.gambeson],
			[2, ::Legends.Armor.Standard.basic_mail_shirt]
		]);
		armor.setCondition(armor.getConditionMax() * this.Math.rand(25, 100) * 0.01);
		items.equip(armor);
	}

	o.onSpawnAssets = function ()
	{
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.m.Money = this.World.Assets.m.Money / 2;
	}

	o.onSpawnPlayer = function ()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && !randomVillage.isSouthern())
			{
				break;
			}

			i = ++i;
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 7), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 7));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 7), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 7));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 4)
				{
				}
				else if (!tile.HasRoad || tile.Type == this.Const.World.TerrainType.Shore)
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

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(12);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		local f = randomVillage.getFactionOfType(this.Const.FactionType.NobleHouse);
		f.addPlayerRelation(-200.0, "You and your men deserted");
		local names = [];

		for( local i = 0; i < 3; i = i )
		{
			while (true)
			{
				local n = this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)];

				if (names.find(n) == null)
				{
					names.push(n);
					break;
				}
			}

			i = ++i;
		}

		local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 3; i = i )
		{
			local bro = roster.create("scripts/entity/tactical/player");
			bro.setName(names[i]);
			bro.setPlaceInFormation(3 + i);
			this.setupBro(bro, f);
			i = ++i;
		}

		local bros = roster.getAll();
		bros[0].getBackground().m.RawDescription = "{Prior to conscription into the army, %name% was a failed, illiterate baker. Poor work and frequent dessert errors made it prone to pull %name% into military ranks. Having always hated the life, the deserter was quick to join your cause and company.}";
		bros[0].getBackground().buildDescription(true);
		local talents = bros[0].getTalents();
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.Hitpoints] = 1;
		talents[this.Const.Attributes.Fatigue] = 1;
		bros[0].m.PerkPoints = 1;
		bros[0].m.LevelUps = 1;
		bros[0].m.Level = 2;
		bros[0].m.XP = this.Const.LevelXP[bros[0].m.Level - 1];
		bros[0].fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		items.equip(this.new("scripts/items/weapons/hatchet"));
		bros[1].getBackground().m.RawDescription = "{A fine fighter by any judgment, %name% simply hated the low pay of being a soldier in the army. The pursuit of the sellsword\'s life makes sense. Though quite flighty, you believe %name%\'s transient sense of allegiance will be buffered by a steady flow of good coin.}";
		bros[1].getBackground().buildDescription(true);
		local talents = bros[1].getTalents();
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 1;
		talents[this.Const.Attributes.Bravery] = 1;
		bros[1].m.PerkPoints = 0;
		bros[1].m.LevelUps = 0;
		bros[1].m.Level = 1;
		bros[1].m.XP = this.Const.LevelXP[bros[1].m.Level - 1];
		bros[1].fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
		items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		items.equip(this.new("scripts/items/weapons/shortsword"));
		bros[2].getBackground().m.RawDescription = "{%name% is like many deserters. You can see the spirit of a fighter, but the heart for it is withering. It doesn\'t make %name% a coward, as many assume deserters to be, but instead simply someone who may need change. Hopefully the coin of mercenary work can provide it.}";
		bros[2].getBackground().buildDescription(true);
		local talents = bros[2].getTalents();
		talents[this.Const.Attributes.RangedSkill] = 2;
		talents[this.Const.Attributes.RangedDefense] = 1;
		talents[this.Const.Attributes.Initiative] = 1;
		bros[2].m.PerkPoints = 1;
		bros[2].m.LevelUps = 1;
		bros[2].m.Level = 2;
		bros[2].m.XP = this.Const.LevelXP[bros[2].m.Level - 1];
		bros[2].fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
		items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		items.equip(this.new("scripts/items/weapons/light_crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		this.World.Flags.set("HasLegendCampScouting", true);
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/retirement_02.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.deserters_scenario_intro");
		}, null);
	}

	o.onUpdateHiringRoster <- function ( _roster )
	{
		this.addBroToRoster(_roster, "deserter_background", 3);
		this.addBroToRoster(_roster, "militia_background", 6);
		this.addBroToRoster(_roster, "disowned_noble_background", 8);
		// this.addBroToRoster(_roster, "female_disowned_noble_background", 6);
		this.addBroToRoster(_roster, "retired_soldier_background", 6);
		this.addBroToRoster(_roster, "swordmaster_background", 6);
		this.addBroToRoster(_roster, "bastard_background", 6);
	}


	o.onGenerateBro <- function (bro)
	{
		local r = this.Math.rand(0, 9);
		if (r == 0)
		{
			::Legends.Traits.grant(bro, ::Legends.Trait.Dastard);
		}

		if (r == 1)
		{
			::Legends.Traits.grant(bro, ::Legends.Trait.Craven);
		}

		if (r == 2)
		{
			::Legends.Traits.grant(bro, ::Legends.Trait.LegendFearNobles);
		}

		if (r == 3)
		{
			::Legends.Traits.grant(bro, ::Legends.Trait.Pessimist);
		}

		if (r == 4)
		{
			::Legends.Traits.grant(bro, ::Legends.Trait.Paranoid);
		}

		if (r == 5)
		{
			::Legends.Traits.grant(bro, ::Legends.Trait.Superstitious);
		}

		if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat))
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.9);
			bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 0.9);
			bro.improveMood(1.5, "Is excited at becoming a deserter");
		}
	}

	o.onGetBackgroundTooltip = function ( _background, _tooltip )
	{
		_tooltip.push({
			id = 16,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Always acts first in the very first round of combat"
		});
	}

});

