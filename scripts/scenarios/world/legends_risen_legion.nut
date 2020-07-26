this.legends_risen_legion <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legend_risen_legion";
		this.m.Name = "Legion";
		this.m.Description = "[p=c][img]gfx/ui/events/event_73.png[/img][/p]An ancient legion risen from the dead to reclaim the world.\n\n[color=#bcad8c]Dreaded:[/color] All towns will begin hostile to you.\n[color=#bcad8c]Beyond death:[/color] Every character in your party has a 66% chance to survive death\n[color=#bcad8c]Dead walking:[/color] You can not hire in towns, but you may find recruits by patrolling near mass graves and sunken castles.\n";
		this.m.Difficulty = 3;
		this.m.Order = 12;
	}



	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local partysize = 12;
		local broLevelMax = 3;

		

		for( local i = 0; i < partysize; i = ++i )
		{
			local broLevel = this.Math.rand(1, broLevelMax);
			local broPerks = broLevel - 1; 
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			
			bro.m.Level = broLevel;
			bro.m.LevelUps = broPerks;
			bro.m.PerkPoints = broPerks;
			bro.setVeteranPerks(3);
			bro.getTags().add("PlayerSkeleton");
			bro.getTags().add("undead");
			bro.getTags().add("skeleton");
			bro.getSkills().add(this.new("scripts/skills/traits/legend_deathly_spectre_trait"));
			bro.getSkills().add(this.new("scripts/skills/racial/skeleton_racial"));
			bro.getSkills().add(this.new("scripts/skills/injury_permanent/legend_fleshless"));
			local items = bro.getItems();
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));

	

			local r = this.Math.rand(1, 8);
			if (r <= 3)
				{
				bro.setStartValuesEx([
				"militia_background"
				]);
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
					local t = this.Math.rand(1, 2);
					if (t == 1)
						{
						items.equip(this.new("scripts/items/helmets/ancient/legend_ancient_legionary_helmet_restored"));
						}
					if (t == 2)
						{
						items.equip(this.new("scripts/items/helmets/ancient/ancient_legionary_helmet"));
						}
				items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
				items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
				items.addToBag(this.new("scripts/items/weapons/javelin"));
				items.addToBag(this.new("scripts/items/weapons/javelin"));
	
				}
			if (r == 4)
				{
				bro.setStartValuesEx(this.Const.CharacterBackgroundsAnimated);
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
					local t = this.Math.rand(1, 2);
					if (t == 1)
						{
						items.equip(this.new("scripts/items/helmets/ancient/legend_ancient_legionary_helmet_restored"));
						}
					if (t == 2)
						{
						items.equip(this.new("scripts/items/helmets/ancient/ancient_legionary_helmet"));
						}
				items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
				items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
				items.addToBag(this.new("scripts/items/weapons/javelin"));
				items.addToBag(this.new("scripts/items/weapons/javelin"));
				}
			if (r == 5)
				{
				bro.setStartValuesEx([
				"beast_hunter_background"
				]);
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
				items.equip(this.new("scripts/items/helmets/ancient/ancient_gladiator_helmet"));
				items.equip(this.new("scripts/items/weapons/ancient/ancient_sword"));
				items.equip(this.new("scripts/items/tools/throwing_net"));
				items.addToBag(this.new("scripts/items/tools/throwing_net"));
				items.addToBag(this.new("scripts/items/tools/throwing_net"));
	
				}
			if (r == 6)
				{
				bro.setStartValuesEx([
				"swordmaster_background"
				]);

				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
				items.equip(this.new("scripts/items/helmets/ancient/ancient_honorguard_helmet"));
				items.equip(this.new("scripts/items/weapons/ancient/rhomphaia"));
				items.addToBag(this.new("scripts/items/weapons/javelin"));
				items.addToBag(this.new("scripts/items/weapons/javelin"));

				}
			if (r >= 7)
				{
				bro.setStartValuesEx([
				"retired_soldier_background"
				]);
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
				items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
				items.equip(this.new("scripts/items/helmets/ancient/ancient_household_helmet"));
				items.equip(this.new("scripts/items/weapons/ancient/bladed_pike"));
				items.addToBag(this.new("scripts/items/weapons/javelin"));
				items.addToBag(this.new("scripts/items/weapons/javelin"));

				}

			
				local cloths = [
					[0, ""],
					[1, "cloth/legend_sackcloth"],
					[1, "cloth/legend_sackcloth_patched"],
					[1, "cloth/legend_sackcloth_tattered"],
					[10, "cloth/legend_ancient_cloth"],
					[10, "cloth/legend_ancient_cloth_restored"],
					[0, "cloth/legend_tunic"],
					[0, "cloth/legend_tunic_noble"]
				];
				local armor = this.Const.World.Common.pickLegendArmor(cloths)

				local plates = [
						[0, ""],
						[0, "plate/legend_armor_leather_brigandine"],
						[0, "plate/legend_armor_leather_brigandine_hardened"],
						[0, "plate/legend_armor_leather_brigandine_hardened_full"],
						[0, "plate/legend_armor_leather_jacket"],
						[0, "plate/legend_armor_leather_jacket_simple"],
						[0, "plate/legend_armor_leather_lamellar"],
						[0, "plate/legend_armor_leather_lamellar_harness_heavy"],
						[0, "plate/legend_armor_leather_lamellar_harness_reinforced"],
						[0, "plate/legend_armor_leather_lamellar_heavy"],
						[0, "plate/legend_armor_leather_lamellar_reinforced"],
						[0, "plate/legend_armor_leather_noble"],
						[0, "plate/legend_armor_leather_padded"],
						[0, "plate/legend_armor_leather_riveted"],
						[0, "plate/legend_armor_leather_riveted_light"],
						[0, "plate/legend_armor_leather_scale"],
						[1, "plate/legend_armor_plate_ancient_gladiator"],
						[1, "plate/legend_armor_plate_ancient_chest"],
						[1, "plate/legend_armor_plate_ancient_chest_restored"],
						[1, "plate/legend_armor_plate_ancient_harness"],
						[1, "plate/legend_armor_plate_ancient_mail"],
						[1, "plate/legend_armor_plate_ancient_scale"],
						[1, "plate/legend_armor_plate_ancient_scale_coat"],
						[1, "plate/legend_armor_plate_ancient_scale_harness"],
						[0, "plate/legend_armor_plate_chest"],
						[0, "plate/legend_armor_plate_chest_rotten"],
						[0, "plate/legend_armor_plate_cuirass"],
						[0, "plate/legend_armor_plate_full"],
						[0, "plate/legend_armor_scale"],
						[0, "plate/legend_armor_scale_coat"],
						[0, "plate/legend_armor_scale_coat_rotten"],
						[0, "plate/legend_armor_scale_shirt"]
				]
				local plate = this.Const.World.Common.pickLegendArmor(plates)
					if (plate != null)
					{
						armor.setUpgrade(plate)
					}
				items.equip(armor);


				local val = this.World.LegendsMod.BroStats().addNewActorID(bro);
				bro.m.CompanyID = val;
		}

		

			this.World.Assets.getStash().add(this.new("scripts/items/supplies/wine_item"));
			this.World.Assets.getStash().add(this.new("scripts/items/tents/tent_train"));
			this.World.Assets.getStash().add(this.new("scripts/items/tents/tent_repair"));
			this.World.Assets.getStash().add(this.new("scripts/items/tents/tent_scout"));
			this.World.Assets.getStash().add(this.new("scripts/items/tents/tent_heal"));
			this.World.Assets.getStash().add(this.new("scripts/items/tents/tent_scrap"));
			this.World.Assets.getStash().add(this.new("scripts/items/tents/tent_fletcher"));
	}

	function onSpawnPlayer()
	{
		local randomVillage;
		local northernmostY = 0;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			local v = this.World.EntityManager.getSettlements()[i];

			if (v.getTile().SquareCoords.Y > northernmostY && !v.isMilitary() && !v.isIsolatedFromRoads() && v.getSize() <= 2)
			{
				northernmostY = v.getTile().SquareCoords.Y;
				randomVillage = v;
			}
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

		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);

		foreach( n in nobles )
		{

			n.addPlayerRelation(-400.0, "You are the undead, to be despised");

		}

		local skellies = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Undead);

		foreach( n in skellies )
		{

			n.addPlayerRelation(400.0, "For the empire!");

		}

		//this.m.StaticRelationsToFaction.resize(this.Const.FactionType.len());
		this.m.StaticRelationsToFaction[this.Const.FactionType.NobleHouse] = true;
		this.m.StaticRelationsToFaction[this.Const.FactionType.Undead] = true;

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(112);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/undead_01.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_risen_legion_intro");
		}, null);

				this.World.Tags.set("HasLegendCampGathering", true);
				this.World.Tags.set("HasLegendCampCrafting", true);
				this.World.Tags.set("HasLegendCampFletching", true);
				this.World.Tags.set("HasLegendCampHealing", true);
				this.World.Tags.set("HasLegendCampHunting", true);
				this.World.Tags.set("HasLegendCampScouting", true);
				this.World.Tags.set("HasLegendCampScraping", true);
				this.World.Tags.set("HasLegendCampTraining", true);
	}

	function onUpdateHiringRoster( _roster )
	{
		local garbage = [];
		local bros = _roster.getAll();

		foreach( i, bro in bros )
		{
			if (bro.isStabled())
			{
				continue;
			}
			if (!bro.isStabled())
			{
				garbage.push(bro);
			}
		}

		foreach( g in garbage )
		{
			_roster.remove(g);
		}
	}

	function onHiredByScenario( bro )
	{
		bro.getSkills().add(this.new("scripts/skills/traits/legend_deathly_spectre_trait"));

		if (!bro.getSkills().hasSkill("racial.skeleton") && bro.getTags().has("skeleton"))
		{
		bro.getSkills().add(this.new("scripts/skills/racial/skeleton_racial"));
		bro.getSkills().add(this.new("scripts/skills/injury_permanent/legend_fleshless"));
		}
		local r = this.Math.rand(0, 2);
		if (bro.getBackground().isOutlawBackground())
		{
			bro.improveMood(0.5, "Finds perverse joy in your actions")
			if (r == 0)
			{
				bro.getSkills().add(this.new("scripts/skills/traits/paranoid_trait"));
			}
		}
		else if (bro.getBackground().isCrusaderRecruitBackground())
		{
			bro.worsenMood(1.5, "Is deeply disturbed by you");
			if (r == 0)
			{
				bro.getSkills().add(this.new("scripts/skills/traits/superstitious_trait"));
			}
			if (r == 1)
			{
				bro.getSkills().add(this.new("scripts/skills/traits/paranoid_trait"));
			}
		}

	}
});

