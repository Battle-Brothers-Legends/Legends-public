this.legends_nomad_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_nomad";
		this.m.Name = "Nomad Tribe";
		this.m.Description = "[p=c][img]gfx/ui/events/event_170.png[/img][/p][p]Displaced from your land, take control of 4 nomads and a conscript hunted in the desert. \n[color=#bcad8c]Hunted:[/color] Start in the desert away from civilisation. City States are hostile and will always decline in favour with you while Northern Nobles will have a cold relationship with you but will not decline. The more nomads in your party the stronger this effect will be.\n[color=#bcad8c]Nomadic:[/color] Vision radius is increased by 30% on the world map. Settlements may contain Nomads and Bladedancers displaced from their lands willing to fight for you. Nomads, Muladis and Bladedancers cost 25% less to hire and upkeep.\n[color=#bcad8c]The Path of the Interloper:[/color] Nomads and Muladis gain the \'Wind Reader\' perk when recruited. Bladedancers gain the \'Dodge\' perk. Other Nomads are friendly to you.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 181;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(5);
		// this.m.RosterTierMax = this.Const.Roster.getTierForSize(22);
		this.m.StartingBusinessReputation = -50;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 5; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll(); //composed of: 1 combat wildcard | 1 elite (ranged) | 1 ranged | 2 melee

		bros[0].setPlaceInFormation(2);
		bros[0].setVeteranPerks(2);
		bros[0].getSprite("socket").setBrush("bust_base_nomads");
		::Legends.Traits.grant(bros[0], ::Legends.Trait.LegendNomad);
		::Legends.Perks.grant(bros[0], ::Legends.Perk.LegendWindReader);
		bros[0].setStartValuesEx([ // melee
			"nomad_background"
		]);
		bros[0].getBackground().m.RawDescription = "{%name% is someone who you have known since they were a child. They always had a keen eye but had more interest in shooting things point blank with their sling instead. Their discovery of maces and swords changed their world for the better.}";

		bros[1].setPlaceInFormation(3);
		bros[1].setVeteranPerks(2);
		bros[1].getSprite("socket").setBrush("bust_base_nomads");
		::Legends.Traits.grant(bros[1], ::Legends.Trait.LegendNomad);
		::Legends.Perks.grant(bros[1], ::Legends.Perk.LegendWindReader);
		bros[1].setStartValuesEx([ //melee always to prevent all ranged parties
			"nomad_background"
		]);
		bros[1].getBackground().m.RawDescription = "{%name% came from another tribe that merged with yours not too long ago. Their family was butched in the night by \'skin men\' who could travel thirty paces in a blink of the eye. While many think them unsettled by what appears to be a raid, you can\'t help but notice how they always sleep closest to the fire every night.}";

		bros[2].setPlaceInFormation(4);
		bros[2].setVeteranPerks(2);
		::Legends.Effects.grant(bros[2], ::Legends.Effect.Exhausted);
		bros[2].setStartValuesEx([ ///elite for story purposes. Always ranged. No benefit from nomad trait.
			"legend_conscript_ranged_background"
		]);
		bros[2].getBackground().m.RawDescription = "{This outsider was close to death when you found them in the sands. While they lack the mindset and resolve you have come to expect from others, their training from the City States makes %them% a useful weapon to use against them.}";

		bros[3].setPlaceInFormation(11);
		bros[3].setVeteranPerks(2);
		bros[3].getSprite("socket").setBrush("bust_base_nomads");
		::Legends.Traits.grant(bros[3], ::Legends.Trait.LegendNomad);
		::Legends.Perks.grant(bros[3], ::Legends.Perk.LegendWindReader);
		bros[3].setStartValuesEx([ //wildcard 1
			"nomad_background",
			"nomad_ranged_background"
		]);
		bros[3].getBackground().m.RawDescription = "{You know little about %name%, they prefer to stay quiet and keep to themselves. However their loyalty to the tribe has never come into question.}";

		bros[4].setPlaceInFormation(12);
		bros[4].setVeteranPerks(2);
		bros[4].getSprite("socket").setBrush("bust_base_nomads");
		::Legends.Traits.grant(bros[4], ::Legends.Trait.LegendNomad);
		::Legends.Perks.grant(bros[4], ::Legends.Perk.LegendWindReader);
		bros[4].setStartValuesEx([ //always ranged for variety
			"nomad_ranged_background"
		]);
		bros[4].getBackground().m.RawDescription = "{Be it rabbit, snake or hyena - little stands a chance against %name% who readily hits their target with all the same precision. The change to conscripts over wildlife came as a challenge at first until they realised they just needed to aim slightly lower than normal.}";

		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/dried_lamb_item"));
		// this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() + 5);
		this.World.Assets.m.Medicine = this.World.Assets.m.Medicine * 1.5;
		this.World.Assets.m.Ammo = this.World.Assets.m.Ammo * 3;
	}

	function onSpawnPlayer()
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
				}		//&& tile.Type != this.Const.World.TerrainType.Steppe
				else if (tile.Type != this.Const.World.TerrainType.Desert)
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

		local oriental = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

		foreach( n in oriental )
		{
			n.addPlayerRelation(-100.0, "You are an outlaw to the City States");
		}

		local orientalbandits = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalBandits);

		foreach( n in orientalbandits )
		{
			n.addPlayerRelation(100.0, "You walk the same path, but should not be seeing this message");
		}

		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);

		foreach( n in nobles )
		{
			n.addPlayerRelation(-30.0, "You are considered an outlaw");
		}

		this.m.StaticRelationsToFaction[this.Const.FactionType.OrientalCityState] = true;
		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", spawnTile.Coords.X, spawnTile.Coords.Y);
		this.World.Assets.updateLook(117);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/gilded_01.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legends_nomad_scenario_intro");
		}, null);
	}

	function onInit()
	{
		this.starting_scenario.onInit();

		if (this.World.State.getPlayer() != null)
		{											 //+30%
			this.World.State.getPlayer().m.VisionRadius = 670; //500 is default during daytime on normal terrain
		}
		this.updateFactionActionsDeck();
	}

	function onHiredByScenario( bro )
	{								//also contains nomad_ranged
		if (bro.getBackground().getID() == "background.nomad" || bro.getBackground().getID() == "background.legend_muladi")
		{
			bro.improveMood(1.5, "I walk with those on the path of the Interloper");
			::Legends.Traits.grant(bro, ::Legends.Trait.LegendNomad);
			bro.getSprite("socket").setBrush("bust_base_nomads");
			::Legends.Perks.grant(bro, ::Legends.Perk.LegendWindReader);
		}
		else if (bro.getBackground().getID() == "background.bladedancer")
		{
			bro.improveMood(1.5, "I walk with those on the path of the Interloper");
			::Legends.Traits.grant(bro, ::Legends.Trait.LegendNomad);
			bro.getSprite("socket").setBrush("bust_base_nomads");
			::Legends.Perks.grant(bro, ::Legends.Perk.Dodge);
		}
		else
		{
			bro.worsenMood(2.0, "Nomadic life isn\'t for me...");
		}
	}

	function onGenerateBro(bro)
	{
		if (bro.getBackground().getID() == "background.nomad" || bro.getBackground().getID() == "background.legend_muladi" || bro.getBackground().getID() == "background.bladedancer")
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.75); //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 0.75; //1.0 = default
		}
		else
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.00);
			bro.getBaseProperties().DailyWageMult *= 1.00;
			bro.getSkills().update();
		}
	}

	function onUpdateHiringRoster( _roster )
	{
		local settlement = this.getCurrentSettlement();
		if (::MSU.isKindOf(settlement, "city_state"))
		{
			this.addBroToRoster(_roster, "nomad_background", 3);
			this.addBroToRoster(_roster, "nomad_ranged_background", 3);
			this.addBroToRoster(_roster, "legend_bladedancer_background", 4);
		}
		else if (::MSU.isKindOf(settlement, "legends_steppe_fort") || (settlement.isMilitary() && this.isSteppeSettlement(settlement)))
		{
			this.addBroToRoster(_roster, "nomad_background", 3);
			this.addBroToRoster(_roster, "nomad_ranged_background", 3);
			this.addBroToRoster(_roster, "legend_bladedancer_background", 4);
		}
		else if (::MSU.isKindOf(settlement, "legends_steppe_village") || this.isSteppeSettlement(settlement))
		{
			this.addBroToRoster(_roster, "nomad_background", 4);
			this.addBroToRoster(_roster, "nomad_ranged_background", 4);
			this.addBroToRoster(_roster, "legend_bladedancer_background", 8);
		}
	}

	// Helper function specific to this origin only
	function updateFactionActionsDeck()
	{
		// Disable Drive Away Nomads contract for City State factions
		local cityStates = ::World.FactionManager.getFactionsOfType(::Const.FactionType.OrientalCityState);
		foreach (faction in cityStates)
		{
			faction.removeActionByID("drive_away_nomads_action");
		}
	}

	// Helper function to check if a settlement is adjacent to any steppe / desert / oasis tiles
	function isSteppeSettlement( _settlement )
	{
		local settlementTile = _settlement.getTile();

		for( local i = 0; i != 6; i = ++i )
		{
			if (!settlementTile.hasNextTile(i))
			{
				return false;
			}
			else
			{
				local tile = settlementTile.getNextTile(i);

				if (tile.Type == this.Const.World.TerrainType.Steppe || tile.Type == this.Const.World.TerrainType.Desert || tile.Type == this.Const.World.TerrainType.Oasis)
				{
					return true;
				}
			}
		}
		return false;
	}

});

