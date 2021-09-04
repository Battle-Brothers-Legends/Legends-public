this.legends_rangers_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_rangers";
		this.m.Name = "Ranger";
		this.m.Description = "[p=c][img]gfx/ui/events/event_115.png[/img][/p][p]Originally hailing from far afield, the rangers are sworn to protect their ancestral woodlands. Increasing intrusions have led the rangers to these lands. \n\n[color=#bcad8c]Outdoorsmen:[/color] Not everyone is cut out for the Rangers, some love nature and are eager to join, others will need more coin to convince. Outdoor recruits gain Pathfinder.\n[color=#bcad8c]Expert Scouts:[/color] You move faster on the campaign map and can always get a scouting report for any enemies near you.\n[color=#bcad8c]Guardians:[/color] If your ranger and druid die, its game over.[/p]";
		this.m.Difficulty = 1;
		this.m.Order = 230;
		this.m.IsFixedLook = true;
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 2; i = i ) //party size = 2 and bust for starters
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
 			bro.getSprite("socket").setBrush("bust_base_wildmen_01");
			bro.getSprite("miniboss").setBrush("bust_miniboss");
			bro.m.HireTime = this.Time.getVirtualTimeF();

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
			i = ++i;
		}

		local bros = roster.getAll(); //starting party
		local talents;
		bros[0].setStartValuesEx([
			"legend_ranger_commander_background"
		]);
		bros[0].getBackground().m.RawDescription = "{%name% grew up in the rangers and was taught the ways of the forest by veteran foresters. Running through the woods for a lifetime has made %name% particularly good at tracking enemies, or tumbling into the homes of wild druids trying to escape from the modern world}";
		bros[0].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_pathfinder"));
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_footwork"));
		bros[0].improveMood(1.5, "Narrowly escaped a bear");
		bros[0].addLightInjury();
		bros[0].getFlags().set("IsPlayerCharacter", true);
		bros[0].setPlaceInFormation(3);
		bros[0].setVeteranPerks(2);

		bros[1].setStartValuesEx([
			"legend_druid_commander_background"
		]);
		bros[1].getBackground().m.RawDescription = "{%name% was the bastard of a noblewoman who left them in a ditch at the edge of the forest to be taken by wolves. It worked, but instead left %name% being cared for by a wolfmother with no cubs of her own. When the she-wolf was slain by vengeful poachers %name% took it upon themselves to be as far away from society as possible. Right up until a certain ranger fell headfirst into their hovel}";
		bros[1].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bros[1].getSkills().add(this.new("scripts/skills/perks/perk_pathfinder"));
		bros[1].getSkills().add(this.new("scripts/skills/perks/perk_legend_roots"));
		bros[1].worsenMood(1.5, "Had my home destroyed by an idiot");
		bros[1].getFlags().set("IsPlayerCharacter", true);
		bros[1].setPlaceInFormation(4);
		bros[1].setVeteranPerks(2);
		this.World.Assets.m.BusinessReputation = 50;
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/cured_venison_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/furs_item"));
		this.World.Assets.m.ArmorParts = this.World.Assets.m.ArmorParts / 2;
		this.World.Assets.m.Ammo = this.World.Assets.m.Ammo * 2;
	}

	function onSpawnPlayer() //forest spawn
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
		this.World.Assets.updateLook(103);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		local f = nearestVillage.getFactionOfType(this.Const.FactionType.NobleHouse);
		f.addPlayerRelation(-20.0, "Heard rumors of you poaching in their woods");
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.IntroTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_ranger_scenario_intro");
		}, null);
	}

	function onInit()
	{
		this.starting_scenario.onInit();

		if (this.World.State.getPlayer() != null)
		{
			this.World.State.getPlayer().m.BaseMovementSpeed = 111;
		}

		this.m.RosterTier = 1;
		this.World.Flags.set("IsLegendsHunter", true);
		this.World.Flags.set("IsLegendsDruid", true);
	}

	function onCombatFinished()
	{
		local roster = this.World.getPlayerRoster().getAll();
		local rangers = 0;

		foreach( bro in roster )
		{
			if (bro.getFlags().get("IsPlayerCharacter"))
			{
				rangers = ++rangers;
			}
		}

		if (rangers == 1 && !this.World.Flags.get("rangersOriginDeath1"))
		{
			this.World.Flags.set("rangersOriginDeath1", true);

			foreach( bro in roster )
			{
				if (bro.getFlags().get("IsPlayerCharacter"))
				{
					bro.getBackground().m.RawDescription = "{We didn\'t start on the best of terms but I feel as if I have lost a part of myself. The forest is quiet and the nights are darker without my companion...}";
					bro.getBackground().buildDescription(true);
				}
			}
		}

		return rangers != 0;
	}

	function onUpdateDraftList( _list, _gender )
	{
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			_list.push("poacher_background");
		}

		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			_list.push("wildwoman_background");
		}

		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			_list.push("wildman_background");
		}

		local r;
		r = this.Math.rand(0, 9);

		if (r == 0)
		{
			_list.push("hunter_background");
		}

		local r;
		r = this.Math.rand(0, 9);

		if (r == 0)
		{
			_list.push("legend_herbalist_background");
		}

		local r;
		r = this.Math.rand(0, 999);

		if (r == 0)
		{
			_list.push("legend_ranger_background");
		}

		local r;
		r = this.Math.rand(0, 999);

		if (r == 0)
		{
			_list.push("legend_druid_background");
		}
	}

	function onHiredByScenario( bro ) //give pathfinder
	{
		//needs to be fixed
		if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Druid | this.Const.BackgroundType.Ranger))
		{
			bro.improveMood(1.0, "Supports the ranger cause");
			bro.getSkills().add(this.new("scripts/skills/perks/perk_pathfinder"));
			bro.getSprite("socket").setBrush("bust_base_beasts");
		}
		else
		{
			bro.worsenMood(2.0, "Does not like sleeping in the woods");
		}
	}

	function onUpdateHiringRoster( _roster )
	{
		local bros = _roster.getAll();

		foreach( i, bro in bros )
		{
			//needs to be fixed
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Druid | this.Const.BackgroundType.Ranger))
			{
				bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 0.75);
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.75);
			}
			else
			{
				bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 1.25);
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.25);
			}
		}
	}

	function onBuildPerkTree( _tree )
	{
		if (_tree == null)
		{
			return;
		}

		_tree[0].push(this.Const.Perks.PerkDefs.Pathfinder);
	}

});

