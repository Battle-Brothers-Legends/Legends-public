::mods_hookBaseClass("events/event", function (o)
{
	while(!("ID" in o.m)) o=o[o.SuperName];

	o.setScreen = function ( _screen )
	{
		if (_screen == null)
		{
			return;
		}

		this.m.ActiveScreen = clone _screen;
		this.m.ActiveScreen.Options = [];

		foreach( option in _screen.Options )
		{
			this.m.ActiveScreen.Options.push(clone option);
		}

		if ("List" in this.m.ActiveScreen)
		{
			this.m.ActiveScreen.List = [];
		}
		else
		{
			this.m.ActiveScreen.List <- [];
		}

		if ("Characters" in this.m.ActiveScreen)
		{
			this.m.ActiveScreen.Characters = [];
		}

		if ("Banner" in this.m.ActiveScreen)
		{
			this.m.ActiveScreen.Banner = [];
		}

		if(("start" in this.m.ActiveScreen) == false) 	// Prevents errors when Events forget the start() function
		{
			this.m.ActiveScreen.start <- function(_start) {};
		}

		this.m.ActiveScreen.start(this);
		this.m.ActiveScreen.Text = this.buildText(this.m.ActiveScreen.Text);

		foreach( option in this.m.ActiveScreen.Options )
		{
			option.Text = this.buildText(option.Text);
			option.Event <- this;
		}
	}
	o.buildText = function ( _text )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local brother1;
		local brother2;
		local notnagel;
		local slaves = [];

		local bro1;
		local bro2;

		for( local i = 0; i < brothers.len(); i = ++i )
		{
			if (brothers[i].getSkills().hasSkill("trait.player"))
			{
				notnagel = brothers[i];

				if (brothers.len() > 1)
				{
					brothers.remove(i);
				}
			}
			else if (brothers.len() > 1 && brothers[i].getBackground().getID() == "background.slave")
			{
				slaves.push(brothers[i]);
				brothers.remove(i);
			}
		}

		local r = this.Math.rand(0, brothers.len() - 1);
		bro1 = brothers[r];
		brother1 = bro1.getName();
		brothers.remove(r);

		if (brothers.len() != 0)
		{
			bro2 = brothers[this.Math.rand(0, brothers.len() - 1)];
		}
		else if (slaves.len() != 0)
		{
			bro2 = slaves[this.Math.rand(0, slaves.len() - 1)];
		}
		else if (notnagel != null)
		{
			bro2 = notnagel;
		}
		else
		{
			bro2 = bro1;
		}

		brother2 = bro2.getName();

		local villages = this.World.EntityManager.getSettlements();
		local nobleHouses = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local citystates = [];
		local northern = [];

		for( local i = 0; i < villages.len(); i = ++i )
		{
			if (this.isKindOf(villages[i], "city_state"))
			{
				citystates.push(villages[i]);
			}
			else
			{
				northern.push(villages[i]);
			}
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!this.World.getTime().IsDaytime)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_33.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.Snow)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_143.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.SnowyForest)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_08.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.Plains)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_16.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.Forest)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_25.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.LeaveForest)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_128.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.AutumnForest)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_127.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.Swamp)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_09.png[/img]";
		}
		else if (currentTile.TacticalType == this.Const.World.TerrainTacticalType.DesertHills)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_150.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.Hills)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_36.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.Tundra)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_126.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.Steppe)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_66.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.Desert)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_161.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.Oasis)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_161.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.Mountains)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_42.png[/img]";
		}
		else
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_76.png[/img]";
		}

		if (("Town" in this.m) && this.m.Town != null)
		{
			if (this.m.Town.isSouthern())
			{
				this.m.TownImage = "[img]gfx/ui/events/event_163.png[/img]";
			}
			else if (this.m.Town.isMilitary())
			{
				this.m.TownImage = "[img]gfx/ui/events/event_31.png[/img]";
			}
			else if (this.m.Town.getSize() <= 2)
			{
				this.m.TownImage = "[img]gfx/ui/events/event_79.png[/img]";
			}
			else
			{
				this.m.TownImage = "[img]gfx/ui/events/event_20.png[/img]";
			}
		}

		local text;
		local vars = [
			[
				"SPEECH_ON",
				"\n\n[color=#bcad8c]\""
			],
			[
				"SPEECH_START",
				"[color=#bcad8c]\""
			],
			[
				"SPEECH_OFF",
				"\"[/color]\n\n"
			],
			[
				"OOC",
				"[color=#f6eedb]"
			],
			[
				"OOC_OFF",
				"[/color]"
			],
			[
				"companyname",
				this.World.Assets.getName()
			],
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomnoble",
				this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]
			],
			[
				"randomnoblehouse",
				nobleHouses[this.Math.rand(0, nobleHouses.len() - 1)].getName()
			],
			[
				"randombrother",
				brother1
			],
			[
				"they1",
				this.Const.LegendMod.getPronoun(bro1.getGender(), "they")
			],
			[
				"them1",
				this.Const.LegendMod.getPronoun(bro1.getGender(), "them")
			],
			[
				"their1",
				this.Const.LegendMod.getPronoun(bro1.getGender(), "their")
			],
			[
				"theirs1",
				this.Const.LegendMod.getPronoun(bro1.getGender(), "theirs")
			],
			[
				"themselves1",
				this.Const.LegendMod.getPronoun(bro1.getGender(), "themselves")
			],
			[
				"They1",
				this.Const.LegendMod.getPronoun(bro1.getGender(), "They")
			],
			[
				"Them1",
				this.Const.LegendMod.getPronoun(bro1.getGender(), "Them")
			],
			[
				"Their1",
				this.Const.LegendMod.getPronoun(bro1.getGender(), "Their")
			],
			[
				"Theirs1",
				this.Const.LegendMod.getPronoun(bro1.getGender(), "Theirs")
			],
			[
				"Themselves1",
				this.Const.LegendMod.getPronoun(bro1.getGender(), "Themselves")
			],
			[
				"randombrother2",
				brother2
			],
			[
				"they2",
				this.Const.LegendMod.getPronoun(bro2.getGender(), "they")
			],
			[
				"them2",
				this.Const.LegendMod.getPronoun(bro2.getGender(), "them")
			],
			[
				"their2",
				this.Const.LegendMod.getPronoun(bro2.getGender(), "their")
			],
			[
				"theirs2",
				this.Const.LegendMod.getPronoun(bro2.getGender(), "theirs")
			],
			[
				"themselves2",
				this.Const.LegendMod.getPronoun(bro2.getGender(), "themselves")
			],
			[
				"They2",
				this.Const.LegendMod.getPronoun(bro2.getGender(), "They")
			],
			[
				"Them2",
				this.Const.LegendMod.getPronoun(bro2.getGender(), "Them")
			],
			[
				"Their2",
				this.Const.LegendMod.getPronoun(bro2.getGender(), "Their")
			],
			[
				"Theirs2",
				this.Const.LegendMod.getPronoun(bro2.getGender(), "Theirs")
			],
			[
				"Themselves2",
				this.Const.LegendMod.getPronoun(bro2.getGender(), "Themselves")
			],
			[
				"randomtown",
				northern[this.Math.rand(0, northern.len() - 1)].getNameOnly()
			],
			[
				"randomcitystate",
				citystates.len() != 0 ? citystates[this.Math.rand(0, citystates.len() - 1)].getNameOnly() : ""
			],
			[
				"terrainImage",
				this.m.TerrainImage
			],
			[
				"townImage",
				this.m.TownImage
			]
		];
		this.onPrepareVariables(vars);
		return this.buildTextFromTemplate(_text, vars);
	}

	o.onPrepareVariables <- function ( _vars ) {}

	o.addPronounVars <- function ( _vars, _bro, _suffix )
	{
		if (_suffix == "1" || _suffix == "2")
		{
			this.logError ("addPronounVars: Cannot use 1 or 2 as suffix");
			return;
		}

		_vars.extend([
			[
				"they" + _suffix,
				this.Const.LegendMod.getPronoun(_bro.getGender(), "they")
			],
			[
				"them" + _suffix,
				this.Const.LegendMod.getPronoun(_bro.getGender(), "them")
			],
			[
				"their" + _suffix,
				this.Const.LegendMod.getPronoun(_bro.getGender(), "their")
			],
			[
				"theirs" + _suffix,
				this.Const.LegendMod.getPronoun(_bro.getGender(), "theirs")
			],
			[
				"themselves" + _suffix,
				this.Const.LegendMod.getPronoun(_bro.getGender(), "themselves")
			],
			[
				"They" + _suffix,
				this.Const.LegendMod.getPronoun(_bro.getGender(), "They")
			],
			[
				"Them" + _suffix,
				this.Const.LegendMod.getPronoun(_bro.getGender(), "Them")
			],
			[
				"Their" + _suffix,
				this.Const.LegendMod.getPronoun(_bro.getGender(), "Their")
			],
			[
				"Theirs" + _suffix,
				this.Const.LegendMod.getPronoun(_bro.getGender(), "Theirs")
			],
			[
				"Themselves" + _suffix,
				this.Const.LegendMod.getPronoun(_bro.getGender(), "Themselves")
			]
		]);
	}
	o.canFire <- function ()
	{
		return true;
	}
});
