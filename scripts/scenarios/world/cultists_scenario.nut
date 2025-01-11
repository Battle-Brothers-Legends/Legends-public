this.cultists_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.cultists";
		this.m.Name = "Davkul Cultists";
		this.m.Description = "[p=c][img]gfx/ui/events/event_140.png[/img][/p][p]Davkul awaits. You lead a small flock devoted to the elder god, and it is time to spread the word. Find more followers, acquire riches, and please Davkul with sacrifices.\n\n[color=#bcad8c]Cultists:[/color] Start with a group of five cultists and encounter fanatical special cultists in towns.\n[color=#bcad8c]Sacrifices:[/color] Davkul will occasionally demand sacrifices from you, but also bestow boons upon those loyal to him. Davkul will not sacrifice his chosen elite. Cultists cost 25% less to hire and maintain.\n[color=#c90000]Let the Blood Flow:[/color] All cultists gain bonus melee skill and the [color=#008060]True Believer[/color] perk.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 90;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(8);
	}



	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 5; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.getSprite("socket").setBrush("bust_base_orcs");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			::Legends.Traits.grant(bro, ::Legends.Trait.CultistFanatic);
			::Legends.Traits.remove(bro, ::Legends.Trait.Superstitious); //If cultist, this ID will be removed as True believer is not removing them on start
			::Legends.Traits.remove(bro, ::Legends.Trait.Dastard); //If cultist, this ID will be removed as True believer is not removing them on start
			::Legends.Traits.remove(bro, ::Legends.Trait.Insecure); //If cultist, this ID will be removed as True believer is not removing them on start
			::Legends.Traits.remove(bro, ::Legends.Trait.Craven); //If cultist, this ID will be removed as True believer is not removing them on start

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
			i = ++i;
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([ // discount Alastair Crowley
			"legend_magister_background"
		]);
		bros[0].getBackground().m.RawDescription = "When %name% joined, the cultist warmly called you captain, saying \"tis a proper manner to pursue the path into the Black from whence we came\".";
		::Legends.Perks.grant(bros[0], ::Legends.Perk.RallyTheTroops);
		this.addScenarioPerk(bros[0].getBackground(), this.Const.Perks.PerkDefs.LegendTrueBeliever);
		bros[0].getBaseProperties().MeleeSkill += 10;
		bros[0].setPlaceInFormation(2);
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/battle_whip"));

		bros[1].setStartValuesEx([ //heavy hitter
			"legend_husk_background"
		]);
		bros[1].getBackground().m.RawDescription = "%name% found you upon the road, stating with certainty you were a mercenary captain. You wore but ordinary cloth at that moment, but %name% said that by Davkul\'s darkness you had an aura of wanted Black about you.";
		this.addScenarioPerk(bros[1].getBackground(), this.Const.Perks.PerkDefs.LegendTrueBeliever);
		bros[1].getBaseProperties().MeleeSkill += 10;
		bros[1].setPlaceInFormation(3);
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/two_handed_wooden_flail"));

		bros[2].setStartValuesEx([ //edgyboy 1, hitchance
			"cultist_background"
		]);
		bros[2].getBackground().m.RawDescription = "A quiet figure, %name% has shadows beneath the fingerprints, running like the brine beneath a pallid shore. When you exchanged a handshake, it was as though you could hear the hissing of your sanity.";
		this.addScenarioPerk(bros[2].getBackground(), this.Const.Perks.PerkDefs.LegendTrueBeliever);
		bros[2].getBaseProperties().MeleeSkill += 10;
		bros[2].setPlaceInFormation(4);
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.equip(this.new("scripts/items/weapons/militia_spear"));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"cultist_leather_hood"
			]
		]));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"leather_wraps"
			]
		]));
		bros[3].setStartValuesEx([ //edgyboy 2, armour
			"cultist_background"
		]);
		bros[3].getBackground().m.RawDescription = "%name% banded with you outside a tavern. The first time you saw the cultist, there were scars running up %name%\'s arms and across veins that could not be survived. But each morning it appears as though the scars move, slowly creeping in one direction: toward the forehead.";
		this.addScenarioPerk(bros[3].getBackground(), this.Const.Perks.PerkDefs.LegendTrueBeliever);
		bros[3].getBaseProperties().MeleeSkill += 10;
		bros[3].setPlaceInFormation(5);
		local items = bros[3].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.new("scripts/items/weapons/pickaxe"));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"cultist_hood"
			]
		]));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"leather_wraps"
			]
		]));
		bros[4].setStartValuesEx([ //ranged support
			"legend_lurker_background"
		]);
		bros[4].getBackground().m.RawDescription = "%name% banded with you outside a tavern. The first time you saw the cultist, there were scars running up %name%\'s arms and across veins that could not be survived. But each morning it appears as though the scars move, slowly creeping in one direction: toward the forehead.";
		this.addScenarioPerk(bros[4].getBackground(), this.Const.Perks.PerkDefs.LegendTrueBeliever);
		bros[4].getBaseProperties().MeleeSkill += 10;
		bros[4].setPlaceInFormation(6);
		local items = bros[4].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/legend_sling"));

		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money + 300;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() == 1)
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
				else if (tile.Type != this.Const.World.TerrainType.Plains && tile.Type != this.Const.World.TerrainType.Steppe && tile.Type != this.Const.World.TerrainType.Tundra && tile.Type != this.Const.World.TerrainType.Snow)
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
		this.World.Assets.updateLook(7);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.CivilianTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.cultists_scenario_intro");
		}, null);
	}

	function onUpdateHiringRoster( _roster )
	{
		this.addBroToRoster(_roster, "cultist_background", 3);
		this.addBroToRoster(_roster, "legend_lurker_background", 4);
		this.addBroToRoster(_roster, "legend_husk_background", 6);
		this.addBroToRoster(_roster, "legend_magister_background", 8);
	}


	function isCultist( _background )
	{
		return _background.isBackgroundType(this.Const.BackgroundType.ConvertedCultist | this.Const.BackgroundType.Cultist);
	}

	function onHiredByScenario( _bro ) //cultist hire
	{
		if (this.isCultist(_bro.getBackground()))
		{
			_bro.improveMood(2.0, "Embraced by Davkul");
			_bro.getSprite("socket").setBrush("bust_base_orcs");
		}
		else
		{
			_bro.worsenMood(2.0, "What madness have I walked into!?");
		}
	}
		//starting roster size; T2 = 9
	function onInit()
	{
		this.starting_scenario.onInit();
	}

	function onGenerateBro(bro)
	{
		//Can't really recruit converted cultists but its here anyway for posterity
		if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist" || bro.getBackground().getID() == "background.legend_lurker" || bro.getBackground().getID() == "background.legend_darksoul" || bro.getBackground().getID() == "background.legend_magister")
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.75) //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 0.75; //1.0 = default
			bro.getBaseProperties().MeleeSkill += 10;
			::Legends.Traits.remove(bro, ::Legends.Trait.Superstitious); //If cultist, this ID will be removed as True believer is not removing them on hire
			::Legends.Traits.remove(bro, ::Legends.Trait.Dastard); //If cultist, this ID will be removed as True believer is not removing them on hire
			::Legends.Traits.remove(bro, ::Legends.Trait.Insecure); //If cultist, this ID will be removed as True believer is not removing them on hire
			::Legends.Traits.remove(bro, ::Legends.Trait.Craven); //If cultist, this ID will be removed as True believer is not removing them on hire
			bro.getSkills().update();
		}
		else
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.25)
			bro.getBaseProperties().DailyWageMult *= 1.25;
			bro.getSkills().update();
		}
	}
	function onGetBackgroundTooltip( _background, _tooltip )
	{
		if (_background.getID() == "background.cultist" || _background.getID() == "background.converted_cultist" || _background.getID() == "background.legend_lurker") // Removed husk and magister from this if
		{
			//_tooltip.pop();
			_tooltip.push({
				id = 16,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Skill from being a cultist in a cultist mercenary company"
			});
		}

		if (_background.getID() == "background.legend_husk" || _background.getID() == "background.legend_magister")
		{
			//_tooltip.pop();
			_tooltip.push({
				id = 16,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Skill from being a cultist in a cultist mercenary company and will never be offered up to be sacrificed"
			});
		}
	}

	function onBuildPerkTree( _background ) //give true believer
	{
		if (this.isCultist(_background))
		{
			this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.LegendTrueBeliever);
		}
	}
});

