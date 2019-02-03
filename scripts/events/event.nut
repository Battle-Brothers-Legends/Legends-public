this.event <- {
	m = {
		ID = "",
		Title = "",
		Cooldown = 0.0,
		CooldownUntil = 0.0,
		Score = 0,
		Screens = [],
		ActiveScreen = null,
		TerrainImage = "",
		IsSpecial = false,
		HasBigButtons = false
	},
	function getID()
	{
		return this.m.ID;
	}

	function getScore()
	{
		return this.m.Score;
	}

	function getTitle()
	{
		return this.m.Title;
	}

	function isSpecial()
	{
		return this.m.IsSpecial;
	}

	function hasBigButtons()
	{
		return this.m.HasBigButtons;
	}

	function getScreen( _id )
	{
		if (typeof _id == "table" || typeof _id == "instance")
		{
			return _id;
		}

		foreach( s in this.m.Screens )
		{
			if (s.ID == _id)
			{
				return s;
			}
		}

		this.logError("Screen \'" + _id + "\' not found for event \'" + this.m.ID + "\'.");
		return null;
	}

	function getArticle( _object )
	{
		return this.isFirstCharacter(_object, [
			"A",
			"E",
			"I",
			"O",
			"U"
		]) ? "an " : "a ";
	}

	function create()
	{
	}

	function update()
	{
		if (!this.m.IsSpecial && this.Time.getVirtualTimeF() < this.m.CooldownUntil)
		{
			return;
		}

		this.onClear();
		this.onUpdateScore();
	}

	function clear()
	{
		this.m.Score = 0;
		this.m.ActiveScreen = null;
		this.onClear();
	}

	function reset()
	{
		this.clear();
		this.m.CooldownUntil = 0;
	}

	function fire()
	{
		this.onPrepare();
		this.setScreen(this.getScreen(this.onDetermineStartScreen()));
		this.m.CooldownUntil = this.Time.getVirtualTimeF() + this.m.Cooldown;
	}

	function processInput( _option )
	{
		if (this.m.ActiveScreen == null)
		{
			return false;
		}

		if (_option >= this.m.ActiveScreen.Options.len())
		{
			return true;
		}

		local result = this.m.ActiveScreen.Options[_option].getResult(this);

		if (typeof result != "string" && result <= 0)
		{
			return false;
		}

		this.setScreen(this.getScreen(result));
		return true;
	}

	function setScreen( _screen )
	{
		if (_screen == null)
		{
			return;
		}

		this.m.ActiveScreen = clone _screen;
		this.m.ActiveScreen.Options = clone _screen.Options;

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

		this.m.ActiveScreen.start(this);
		this.m.ActiveScreen.Text = this.buildText(this.m.ActiveScreen.Text);

		foreach( option in this.m.ActiveScreen.Options )
		{
			option.Text = this.buildText(option.Text);
			option.Event <- this;
		}
	}

	function registerToShowAfterCombat( _victoryScreen, _defeatScreen )
	{
		this.World.Events.registerToShowAfterCombat(_victoryScreen, _defeatScreen);
	}

	function buildText( _text )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local brother1 = this.Math.rand(0, brothers.len() - 1);
		local brother2 = this.Math.rand(0, brothers.len() - 1);

		if (brothers.len() >= 2)
		{
			while (brother1 == brother2)
			{
				brother2 = this.Math.rand(0, brothers.len() - 1);
			}
		}

		brother1 = brothers[brother1].getName();
		brother2 = brothers[brother2].getName();
		local villages = this.World.EntityManager.getSettlements();
		local nobleHouses = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local currentTile = this.World.State.getPlayer().getTile();

		if (!this.World.getTime().IsDaytime)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_76.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.Snow || currentTile.Type == this.Const.World.TerrainType.SnowyForest)
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
		else if (currentTile.Type == this.Const.World.TerrainType.Hills)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_76.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.Highlands)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_126.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.Steppe)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_66.png[/img]";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.Mountains)
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_42.png[/img]";
		}
		else
		{
			this.m.TerrainImage = "[img]gfx/ui/events/event_76.png[/img]";
		}

		local text;
		local vars = [
			[
				"SPEECH_ON",
				"\n\n[color=#bcad8c]\""
			],
			[
				"SPEECH_OFF",
				"\"[/color]\n\n"
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
				"randombrother2",
				brother2
			],
			[
				"randomtown",
				villages[this.Math.rand(0, villages.len() - 1)].getNameOnly()
			],
			[
				"terrainImage",
				this.m.TerrainImage
			]
		];
		this.onPrepareVariables(vars);
		return this.buildTextFromTemplate(_text, vars);
	}

	function getUITitle()
	{
		return this.buildText(this.m.Title);
	}

	function getUIButtons()
	{
		local buttons = [];

		foreach( i, option in this.m.ActiveScreen.Options )
		{
			if ("Icon" in option)
			{
				buttons.push({
					id = i,
					text = option.Text,
					icon = option.Icon
				});
			}
			else
			{
				buttons.push({
					id = i,
					text = option.Text
				});
			}
		}

		return buttons;
	}

	function getUIContent()
	{
		local result = [];
		result.push({
			id = 1,
			type = "description",
			text = this.m.ActiveScreen.Text
		});
		return result;
	}

	function getUIList()
	{
		if (this.m.ActiveScreen.List.len() != 0)
		{
			local list = {
				title = "",
				items = this.m.ActiveScreen.List,
				fixed = false
			};
			return [
				list
			];
		}
		else
		{
			return [];
		}
	}

	function getUIImage()
	{
		return this.m.ActiveScreen.Image;
	}

	function getUICharacterImage( _index = 0 )
	{
		if (("Characters" in this.m.ActiveScreen) && this.m.ActiveScreen.Characters.len() > _index)
		{
			return {
				Image = this.m.ActiveScreen.Characters[_index],
				IsProcedural = true
			};
		}
		else if (("Banner" in this.m.ActiveScreen) && this.m.ActiveScreen.Banner.len() > 0 && _index > 0)
		{
			return {
				Image = this.m.ActiveScreen.Banner,
				IsProcedural = false
			};
		}
		else
		{
			return null;
		}
	}

	function getUIMiddleOverlay()
	{
		return null;
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.TerrainImage = "";
	}

	function onSerialize( _out )
	{
		_out.writeF32(this.m.CooldownUntil);
	}

	function onDeserialize( _in )
	{
		this.m.CooldownUntil = _in.readF32();
	}

	function addUnitsToCombat( _into, _partyList, _resources, _faction )
	{
		local total_weight = 0;
		local potential = [];

		foreach( party in _partyList )
		{
			if (party.Cost < _resources * 0.7)
			{
				continue;
			}

			if (party.Cost > _resources)
			{
				break;
			}

			potential.push(party);
			total_weight = total_weight + party.Cost;
		}

		local p;

		if (potential.len() == 0)
		{
			if (_partyList[_partyList.len() - 1].Cost <= _resources)
			{
				p = _partyList[_partyList.len() - 1];
			}
			else
			{
				p = _partyList[0];
			}
		}
		else
		{
			local pick = this.Math.rand(1, total_weight);

			foreach( party in potential )
			{
				if (pick <= party.Cost)
				{
					p = party;
					break;
				}

				pick = pick - party.Cost;
			}
		}

		foreach( t in p.Troops )
		{
			for( local i = 0; i != t.Num; i = ++i )
			{
				local unit = clone t.Type;
				unit.Faction <- _faction;
				_into.push(unit);
			}
		}
	}

	function getNearestNobleHouse( _originTile )
	{
		local towns = this.World.EntityManager.getSettlements();
		local town;
		local lowestDist = 9000;

		foreach( t in towns )
		{
			if (!t.isMilitary())
			{
				continue;
			}

			local d = t.getTile().getDistanceTo(_originTile);

			if (d <= lowestDist)
			{
				town = t;
				lowestDist = d;
			}
		}

		if (town != null)
		{
			return town.getOwner();
		}
		else
		{
			return null;
		}
	}

	function getReputationToDifficultyMult()
	{
		local r = this.Math.minf(4.0, this.Math.maxf(0.75, this.Math.pow(this.Math.maxf(0, 0.003 * this.World.Assets.getBusinessReputation()), 0.4)));
		local s = this.Math.maxf(0.75, this.Math.pow(0.01 * this.World.State.getPlayer().getStrength(), 0.9));
		local d = this.Math.minf(5.0, 0.4 * r + 0.6 * s + this.Math.minf(0.5, this.World.getTime().Days * 0.005));
		return d * this.Const.Difficulty.EnemyMult[this.World.Assets.getCombatDifficulty()];
	}

	function getReputationToDifficultyLightMult()
	{
		local d = 1.0 + this.Math.minf(2.0, this.World.getTime().Days * 0.0115);
		return d * this.Const.Difficulty.EnemyMult[this.World.Assets.getCombatDifficulty()];
	}

};
