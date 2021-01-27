this.legends_seer_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_seer";
		this.m.Name = "Seer";
		this.m.Description = "[p=c][img]gfx/ui/events/event_120.png[/img][/p][p]After studying alchemy and mystic secrets for years, you have set out to confront the evils of the world \n\n[color=#bcad8c]Bookworm:[/color] Educated people want to work for you, the uneducated find you boring to be around.\n[color=#bcad8c]Teacher[/color] Anyone you fight with gains the Student perk.\n[color=#bcad8c]Avatar:[/color] If your seer dies, the campaign ends.[/p]";
		this.m.Difficulty = 3;
		this.m.Order = 250;
		this.m.IsFixedLook = true;
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local bro;
		bro = roster.create("scripts/entity/tactical/player");
		bro.setStartValuesEx([
			"legend_witch_commander_background"
		]);
		bro.getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bro.getSkills().add(this.new("scripts/skills/perks/perk_legend_daze"));
		bro.getSkills().add(this.new("scripts/skills/perks/perk_legend_roster_1"));
		bro.getSkills().add(this.new("scripts/skills/perks/perk_student"));
		bro.m.PerkPointsSpent += 3;

		if (this.World.LegendsMod.Configs().LegendMagicEnabled())
		{
			bro.getSkills().add(this.new("scripts/skills/perks/perk_legend_magic_missile"));
			bro.m.PerkPointsSpent += 1;
		}

		bro.setPlaceInFormation(4);
		bro.setVeteranPerks(2);
		bro.getFlags().set("IsPlayerCharacter", true);
		bro.getSprite("miniboss").setBrush("bust_miniboss_lone_wolf");
		bro.m.HireTime = this.Time.getVirtualTimeF();
		this.World.Assets.m.BusinessReputation = 100;
		this.World.Assets.m.Ammo = 0;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3)
			{
				break;
			}

			i = ++i;
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
		this.World.Assets.updateLook(105);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/noble_02.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_seer_scenario_intro");
		}, null);
	}

	function onInit()
	{
		this.starting_scenario.onInit();
		this.World.Assets.m.BrothersMax = 2;
		this.World.Flags.set("IsLegendsSeer", true);
	}

	function onCombatFinished()
	{
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			if (bro.getFlags().get("IsPlayerCharacter"))
			{
				return true;
			}
		}

		return false;
	}

	function onUpdateDraftList( _list, _gender )
	{
		if (_list.len() < 10)
		{
			return;
		}

		_list.push("apprentice_background");
	}

	function onHiredByScenario( bro )
	{
		if (bro.getBackground().isEducatedBackground())
		{
			bro.improveMood(1.0, "Excited to study from you");
		}
		else
		{
			bro.worsenMood(1.0, "Wishes you would stop using big words");
		}

		if (bro.getSkills().hasSkill("trait.bright"))
		{
			bro.improveMood(0.5, "Keen to learn from a master");
		}

		if (bro.getSkills().hasSkill("trait.dumb"))
		{
			bro.worsenMood(0.5, "Thinks you are a boring nerd");
		}

		bro.improveMood(0.5, "Learned a new skill");
		bro.getSkills().add(this.new("scripts/skills/perks/perk_student"));
	}

	function onUpdateHiringRoster( _roster )
	{
		local garbage = [];
		local bros = _roster.getAll();

		foreach( i, bro in bros )
		{
			if (bro.getBackground().isEducatedBackground() || bro.getSkills().hasSkill("trait.bright"))
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.9);
				bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 0.9);
			}
			else if (!bro.getBackground().isEducatedBackground() || bro.getSkills().hasSkill("trait.dumb"))
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.1);
				bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 1.1);
			}
		}
	}

	function onBuildPerkTree( _tree )
	{
		if (_tree == null)
		{
			return;
		}

		_tree[0].push(this.Const.Perks.PerkDefs.Student);
	}

});

