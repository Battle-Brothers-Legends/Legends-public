this.legends_troupe_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_troupe";
		this.m.Name = "The Troupe";
		this.m.Description = "[p=c][img]gfx/ui/events/event_26.png[/img][/p]The life of an artist is not an easy one, misunderstood and under appreciated. Perhaps performers will have more luck together, find and audience, travel the world, or at least stop having things thrown at you. \n\n[color=#bcad8c]Acrobatics:[/color] Anyone you hire gains the Leap ability \n[color=#bcad8c]Exposure:[/color] You will encounter more performers, and they will be cheaper to hire.\n[color=#bcad8c]Busking:[/color] You gain 10 crowns each day for each member of the troupe. Tavern rumors and drinks are cheaper.";
		this.m.Difficulty = 2;
		this.m.Order = 290;
		this.m.IsFixedLook = true;
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}

	function onSpawnAssets()
	{
	local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 4; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"legend_illusionist_background"
		]);
		bros[0].getBackground().m.RawDescription = "{%name% learned how to entertain on the streets, using slight of hand and magic tricks to dupe unwitting punters out of their coin. Illusion is easier with a distraction, so the choice to join others was easy.}";
		bros[0].m.PerkPoints = 2;
		bros[0].m.LevelUps = 2;
		bros[0].m.Level = 3;
		bros[0].setPlaceInFormation(13);
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_legend_leap"));
		bros[1].getSkills().add(this.new("scripts/skills/perks/perk_legend_push"));
		bros[0].m.PerkPointsSpent += 1;
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.Const.World.Common.pickHelmet([[1, "jesters_hat"]]));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/legend_slingstaff"));
		bros[1].setStartValuesEx([
			"minstrel_background"
		]);
		bros[1].getBackground().m.RawDescription = "{%name% worked providing entertainment at inns around the country, but the bar fights and road bandits make it no life for a solo artist. Joining with others was for safety as much as the show.}";
		bros[1].setPlaceInFormation(12);
		bros[1].getSkills().add(this.new("scripts/skills/perks/perk_legend_leap"));
		bros[1].getSkills().add(this.new("scripts/skills/perks/perk_legend_drums_of_life"));
		
		bros[1].m.PerkPointsSpent += 1;
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.Const.World.Common.pickHelmet([[1, "named/jugglers_hat"]]));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/lute"));
		bros[2].setStartValuesEx([
			"female_minstrel_background"
		]);
		bros[2].getBackground().m.RawDescription = "{%name% has been in the court of a local noble for years, but the same audience every night grows tiresome. It was time to find a band, hit the road and find some new audiences for their art.}";
		bros[2].improveMood(1.0, "Got the band back together");
		bros[2].setPlaceInFormation(4);
		bros[2].m.PerkPoints = 3;
		bros[2].m.LevelUps = 3;
		bros[2].m.Level = 4;
		bros[2].getSkills().add(this.new("scripts/skills/perks/perk_legend_leap"));
		bros[2].getSkills().add(this.new("scripts/skills/perks/perk_legend_drums_of_war"));
		bros[2].m.PerkPointsSpent += 1;
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.Const.World.Common.pickHelmet([[1, "named/jugglers_hat"]]));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/legend_drum"));
		bros[3].setStartValuesEx([
			"juggler_background"
		]);
		bros[3].getBackground().m.RawDescription = "{%name% was juggling and throwing knives in markets, and agreed to join the troupe to improve the show with the skills of others}";
		bros[3].setPlaceInFormation(13);
		bros[3].m.PerkPoints = 1;
		bros[3].m.LevelUps = 1;
		bros[3].m.Level = 2;
		bros[3].getSkills().add(this.new("scripts/skills/perks/perk_legend_leap"));
		bros[3].getSkills().add(this.new("scripts/skills/perks/perk_legend_push"));
		bros[3].m.PerkPointsSpent += 1;
		local items = bros[3].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.Const.World.Common.pickHelmet([[1, "named/jugglers_padded_hat"]]));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/greenskins/orc_javelin"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/legend_pie_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/legend_drum"));
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/greenskins/goblin_spiked_balls"));
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
		this.World.Assets.updateLook(114);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/retirement_01.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_troupe_scenario_intro");
		}, null);

	}



	function onHiredByScenario( bro )
	{

		bro.improveMood(0.5, "Learned a new skill");
		bro.getSkills().add(this.new("scripts/skills/perks/perk_legend_leap"));
	}

	function onUpdateHiringRoster( _roster )
	{
		local garbage = [];
		local bros = _roster.getAll();

		foreach( i, bro in bros )
		{
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Performing))
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.75) //1.0 = default
				bro.getBaseProperties().DailyWageMult *= 0.75; //1.0 = default
				bro.getSkills().update();
			}

		}

	}

	function onBuildPerkTree( _background )
	{
		if (_background.m.CustomPerkTree == null)
		{
			return;
		}
		_background.m.CustomPerkTree[0].push(this.Const.Perks.PerkDefs.LegendLeap);
	}

	function onUpdateDraftList( _list, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		if (_list.len() < 5)
		{
			local r;
			r = this.Math.rand(0, 2);
			if (r == 0)
			{
			_list.push("beggar_background");
			}
			r = this.Math.rand(0, 4);
			if (r == 0)
			{
			_list.push("minstrel_background");
			}
			r = this.Math.rand(0, 6);
			if (r == 0 && _gender)
			{
			_list.push("female_minstrel_background");
			}
			r = this.Math.rand(0, 8);
			if (r == 0)
			{
				_list.push("juggler_background");
			}
		}
		if (_list.len() >= 5)
		{
			local r;
			r = this.Math.rand(0, 2);
			if (r == 0)
			{
			_list.push("beggar_background");
			}
			r = this.Math.rand(0, 4);
			if (r == 0)
			{
			_list.push("minstrel_background");
			}
			r = this.Math.rand(0, 6);
			if (r == 0 && _gender)
			{
			_list.push("female_minstrel_background");
			}
			r = this.Math.rand(0, 8);
			if (r == 0)
			{
				_list.push("juggler_background");
			}
			r = this.Math.rand(0, 20);
			if (r == 0)
			{
			_list.push("eunuch_background");
			}
			r = this.Math.rand(0, 49);
			if (r == 0)
			{
				_list.push("legend_illusionist_background");
			}
			r = this.Math.rand(0, 49);
			if (r == 0)
			{
				_list.push("belly_dancer_background");
			}
			r = this.Math.rand(0, 49);
			if (r == 0)
			{
				_list.push("gambler_background");
			}
			r = this.Math.rand(0, 49);
			if (r == 0)
			{
				_list.push("legend_dervish_background");
			}
		}
	}

});

