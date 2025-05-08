::mods_hookExactClass("scenarios/world/rangers_scenario", function (o) {
	o.create = function ()
	{
		this.m.ID = "scenario.rangers";
		this.m.Name = "Band of Poachers";
		this.m.Description = "[p=c][img]gfx/ui/events/event_10.png[/img][/p][p]For years you have made a decent living by poaching in the local woods, evading your lord\'s men by being quick on your feet. But pickings have become slimmer and slimmer, and you are faced with a decision - how to make a living when all you know is how to use a bow?\n\n[color=#bcad8c]Hunters:[/color] Start with a group of three woodsmen.\n[color=#bcad8c]Expert Scouts:[/color] You move faster and can always get a scouting report for any enemies near you.\n[color=#bcad8c]Travel Light:[/color] You can carry fewer items in your company\'s inventory.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 30;
		this.m.StartingBusinessReputation = 100;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}



	o.onSpawnAssets = function ()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 3; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
			i = ++i;
		}

		local bros = roster.getAll();
		local talents;
		bros[0].setStartValuesEx([
			"hunter_background"
		]);
		bros[0].getBackground().m.RawDescription = "{A bit of a devious runt, though a good person at heart. %name% used to hunt for the local liege, but when the nobleman died falling into an unseen ravine the hunter was blamed and kicked out of court. With some guile, %name% turned hunting talents into poaching and fur trade. Has a merchant\'s mind and was quick to engender the idea of mercenary work because of it.}";
		bros[0].setPlaceInFormation(3);
		bros[0].m.Talents = [];
		talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.RangedSkill] = 2;
		talents[this.Const.Attributes.RangedDefense] = 1;
		talents[this.Const.Attributes.Initiative] = 1;
		bros[0].m.PerkPoints = 0;
		bros[0].m.LevelUps = 0;
		bros[0].m.Level = 1;
		bros[1].setStartValuesEx([
			"poacher_background"
		]);
		bros[1].getBackground().m.RawDescription = "{%name% fell into poaching after a drought ravaged the personal farmstead. Like most poachers, %name% is not truly of the criminal mind. Long grouped together in the hunting gangs, the poacher was quick to nominate you as captain of the new sellsword outfit.}";
		bros[1].setPlaceInFormation(4);
		bros[1].m.Talents = [];
		talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.RangedSkill] = 2;
		talents[this.Const.Attributes.Fatigue] = 1;
		talents[this.Const.Attributes.Initiative] = 1;
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		items.equip(this.new("scripts/items/weapons/short_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		bros[2].setStartValuesEx([
			"poacher_background"
		]);
		bros[2].getBackground().m.RawDescription = "{A former jester whose gag was to shoot three water jugs out of the sky. You do not know how %name% got into poaching and you sense bitterness about some jester-related drama, but an excellent archer nonetheless. Likes to pretend being a far better shot than you. Nonsense, of course.}";
		bros[2].setPlaceInFormation(5);
		bros[2].m.Talents = [];
		talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.RangedSkill] = 2;
		talents[this.Const.Attributes.Bravery] = 1;
		talents[this.Const.Attributes.Initiative] = 1;
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		items.equip(this.new("scripts/items/weapons/legend_northern_sling"));
		this.World.Flags.set("HasLegendCampHunting", true);
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		//this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() - 18); creates a crash on legendary eco difficulty due to taking too many slots away
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/cured_venison_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/furs_item"));
		this.World.Assets.m.ArmorParts = this.World.Assets.m.ArmorParts / 2;
		this.World.Assets.m.Ammo = this.World.Assets.m.Ammo * 2;
	}

	o.onSpawnPlayer = function ()
	{
		local spawnTile;
		local settlements = this.World.EntityManager.getSettlements();
		local nearestVillage;
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(5, this.Const.World.Settings.SizeX - 5);
			local y = this.Math.rand(5, this.Const.World.Settings.SizeY - 5);

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.IsOccupied)
				{
				}
				else if (tile.Type != this.Const.World.TerrainType.Forest && tile.Type != this.Const.World.TerrainType.SnowyForest && tile.Type != this.Const.World.TerrainType.LeaveForest && tile.Type != this.Const.World.TerrainType.AutumnForest)
				{
				}
				else
				{
					local next = true;

					foreach( s in settlements )
					{
						local d = s.getTile().getDistanceTo(tile);

						if (d > 6 && d < 15)
						{
							local path = this.World.getNavigator().findPath(tile, s.getTile(), navSettings, 0);

							if (!path.isEmpty())
							{
								next = false;
								nearestVillage = s;
								break;
							}
						}
					}

					if (next)
					{
					}
					else
					{
						spawnTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", spawnTile.Coords.X, spawnTile.Coords.Y);
		this.World.Assets.updateLook(10);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		local f = nearestVillage.getFactionOfType(this.Const.FactionType.NobleHouse);
		f.addPlayerRelation(-20.0, "Heard rumors of you poaching in their woods");
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.IntroTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.rangers_scenario_intro");
		}, null);
	}

	o.onInit = function ()
	{
		this.starting_scenario.onInit();

		if (this.World.State.getPlayer() != null)
		{
			this.World.State.getPlayer().m.BaseMovementSpeed = 111;
		}
	}

});

