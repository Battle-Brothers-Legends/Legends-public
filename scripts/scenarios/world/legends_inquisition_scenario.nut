this.legends_inquisition_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_inquisition";
		this.m.Name = "The Inquisition";
		this.m.Description = "[p=c][img]gfx/ui/events/event_40.png[/img][/p]There is a great evil in the world, the undead walk the earth and cultists hide in every town. The holy must purge the filth.\n\n[color=#bcad8c]Endless Dead:[/color] Begins with the Undead Crisis already underway, and it can repeat \n\n[color=#bcad8c]Righteous Cause:[/color] Can\'t recruit outlaw backgrounds but more holy backgrounds available to hire\n[color=#bcad8c]Penitence:[/color] Anyone you hire gains the Mind over Body perk.\n";
		this.m.Difficulty = 2;
		this.m.Order = 280;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(6);
		this.m.StartingBusinessReputation = 1100;
	}

	function onSpawnAssets()
	{
	local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 3; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"flagellant_background"
		]);
		bros[0].getBackground().m.RawDescription = "{%name% has no greater joy than suffering in the name of the old gods. Pain and pleasure and intimately linked, just as creation and desctruction are intwined. Each lash of the whip is like the caress of an angel, and their belief is that in only through suffering can we find salvation. Few laymen understand this viewpoint, but it is respected by other servants of the old gods.}";
		bros[0].setPlaceInFormation(4);
		bros[0].getBaseProperties().Hitpoints += 10;
		bros[0].getBaseProperties().MeleeSkill += 10;
		::Legends.Traits.grant(bros[0], ::Legends.Trait.LegendInquisitionDisciple);
		this.addScenarioPerk(bros[0].getBackground(), this.Const.Perks.PerkDefs.LegendMindOverBody);
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Barbarian.leather_helmet]]));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 3;
		talents[this.Const.Attributes.Hitpoints] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 2;
		bros[1].setStartValuesEx([
			"witchhunter_background"
		]);

		bros[1].m.Talents = [];
		local talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 3;
		talents[this.Const.Attributes.RangedSkill] = 3;
		bros[1].fillTalentValues(1, true);
		bros[1].getBaseProperties().RangedSkill += 5;
		bros[1].getBaseProperties().Bravery += 10;
		bros[1].getBackground().m.RawDescription = "{%name% has seen well the damage magic can bring to the world. The witches who steal the minds of men, the nightmares that end lives, and the necromancers who bring them back again. Hunting these foul creatures is the duty of all who serve the good of the gods. If the war is to be won, %name% will need a witch hunter army.}";
		bros[1].improveMood(1.0, "Recently purged the unworthy");
		bros[1].setPlaceInFormation(3);
		bros[1].m.PerkPoints = 1;
		bros[1].m.LevelUps = 1;
		bros[1].m.Level = 2;
		::Legends.Traits.grant(bros[1], ::Legends.Trait.LegendUndeadKiller);
		this.addScenarioPerk(bros[1].getBackground(), this.Const.Perks.PerkDefs.LegendMindOverBody);

		bros[2].setStartValuesEx([
			"monk_background"
		], true, 1);
		bros[2].m.Talents = [];
		local talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 3;
		bros[2].getBaseProperties().Stamina += 10;
		bros[2].getBaseProperties().MeleeSkill += 10;
		bros[2].getBaseProperties().Hitpoints += 7;
		bros[2].getBaseProperties().Initiative -= 5;
		bros[2].getBackground().m.RawDescription = "{%name% is a huge figure, who spent many years in a temple healing and carrying the sick, learning the power of both strength and compassion. It was clear the ills of the world must be sought out and healed at their source. While healing a witch hunter, %name% was convinced to join the hunt to heal the world. }";
		bros[2].setPlaceInFormation(5);
		::Legends.Traits.grant(bros[2], ::Legends.Trait.LegendHeavy, function (_trait) {
			foreach(skill in _trait.m.Excluded)
				bros[2].getSkills().removeByID(skill);
		}.bindenv(this));
		this.addScenarioPerk(bros[2].getBackground(), this.Const.Perks.PerkDefs.LegendMindOverBody);
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
		local shield = this.new("scripts/items/shields/heater_shield");
		shield.onPaintSpecificColor(23);
		items.equip(shield);
		local cloths = [
			[1, "cloth/legend_robes_nun"]
		];
		local armor = this.Const.World.Common.pickLegendArmor(cloths);

		if (armor != null)
		{
			local chains = [
				[1, "chain/legend_armor_mail_shirt"],
				[1, "chain/legend_armor_mail_shirt_simple"],
				[1, "chain/legend_armor_short_mail"]
			];
			local chain = this.Const.World.Common.pickLegendArmor(chains);
			if (chain != null)
			{
				armor.setUpgrade(chain)
			}

			local plates = [
				[1, "plate/legend_armor_leather_jacket"],
				[1, "plate/legend_armor_leather_jacket_simple"]
			];
			local plate = this.Const.World.Common.pickLegendArmor(plates);
			if (plate != null)
			{
				armor.setUpgrade(plate)
			}
			local tabards = [
						[0, ""],
						[1, "tabard/legend_common_tabard"]
					];
			local tabard = this.Const.World.Common.pickLegendArmor(tabards);
			if (tabard != null && armor != null)
			{
				tabard.setVariant(113);
				armor.setUpgrade(tabard);
			}
			items.equip(armor);
		}

		foreach( bro in bros )
		{
			local items = bro.getItems();
			local armor = items.getItemAtSlot(this.Const.ItemSlot.Body);
			local tabards = [
					[0, ""],
					[1, "tabard/legend_noble_tabard"]
				];
				local tabard = this.Const.World.Common.pickLegendArmor(tabards);
				if (tabard != null && armor != null)
				{
					tabard.setVariant(102);
					armor.setUpgrade(tabard);
				}
		}


		this.World.Assets.getStash().add(this.new("scripts/items/supplies/bread_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/wine_item"));
		//this.World.Assets.getStash().add(this.new("scripts/items/accessory/legend_wolfsbane_necklace_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/tools/holy_water_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/legend_wooden_stake"));
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/legend_wooden_stake"));
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/legend_wooden_stake"));
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/legend_wooden_stake"));
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/legend_hand_crossbow"));
		this.World.Assets.getStash().add(this.new("scripts/items/ammo/quiver_of_bolts"));

		//unleash the dogs of war
		this.World.FactionManager.setGreaterEvilType(this.Const.World.GreaterEvilType.Undead);
		this.World.FactionManager.setGreaterEvilPhase(this.Const.World.GreaterEvilPhase.Live);
		this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStartStrength); // This constant is equal to 125, previously set to 500. Not sure if there was a particular reason for 500 so will need to double check.
		this.World.Statistics.addNews("crisis_undead_start", this.World.Statistics.createNews());
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3)
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 1), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 1));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 1), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 1));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) == 0)
				{
				}
				else if (!tile.HasRoad)
				{
				}
				else
				{
					randomVillageTile = tile;
					break;
				}
			}
		}
		while (1);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(113);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/noble_02.ogg"
			], this.Const.Music.CrossFadeTime);
			::World.Events.fire("event.legend_inquisition_scenario_intro");

			// setup undead crisis
			::World.FactionManager.m.GreaterEvil.Type = ::Const.World.GreaterEvilType.Undead;
			::World.FactionManager.m.GreaterEvil.Phase = ::Const.World.GreaterEvilPhase.Live;
			::World.FactionManager.m.GreaterEvil.Strength = ::Const.Factions.GreaterEvilStartStrength;
			::World.Statistics.addNews("crisis_undead_start", ::World.Statistics.createNews());
		}, null);
	}

	function onInit()
	{
		this.starting_scenario.onInit();
	}


	function onHiredByScenario( bro )
	{
		if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Crusader))
		{
			bro.improveMood(1.0, "Joined a righteous cause");
		}
		else
		{
			bro.worsenMood(1.0, "Dislikes your sermons");
		}
		bro.improveMood(0.5, "Learned a new skill");
	}

	function onUpdateHiringRoster( _roster )
	{
		local garbage = [];
		local bros = _roster.getAll();
		this.addBroToRoster(_roster, "flagellant_background", 4);
		this.addBroToRoster(_roster, "monk_background", 6);
		this.addBroToRoster(_roster, "witchhunter_background", 4);
		this.addBroToRoster(_roster, "legend_youngblood_background", 4);
		this.addBroToRoster(_roster, "crusader_background", 8);


		foreach( i, bro in bros )
		{
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Outlaw))
			{
				garbage.push(bro);
			}
		}

		foreach( g in garbage )
		{
			_roster.remove(g);
		}
	}

	function onGenerateBro(bro)
	{
		if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Crusader))
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.75); //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 0.75; //1.0 = default
			bro.getSkills().update();
		}
		else
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.25); //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 1.25; //1.0 = default
			bro.getSkills().update();
		}
	}

	function onBuildPerkTree( _background )
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.LegendMindOverBody);
	}

});

