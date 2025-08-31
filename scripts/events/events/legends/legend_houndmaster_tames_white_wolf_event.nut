this.legend_houndmaster_tames_white_wolf_event <- this.inherit("scripts/events/event", {
	m = {
		Houndmaster = null
	},
	function create()
	{
		this.m.ID = "event.legend_houndmaster_tames_white_wolf";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_143.png[/img]While traversing the snowy wastelands of the realm\'s north, %houndmaster% the houndmaster has come to befriend a creature that\'s been trailing beside the company\'s march: a wolf. The houndmaster frequently remained in the rearguard, crouched low, hands at his side, locking eyes with the lone wolf for minutes on end. But today  %houndmaster% decided to go one step further. The houndmaster makes attempt to tame wild beast… ",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Now or never.",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 60 ? "B" : "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndmaster.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/legend_white_wolf.png[/img]Using a bit of leftover meat, %houndmaster%  plied the beast right into the middle of the camp. Now he squats at its side, dwarfed by its prominent, muscled withers, its pointed and attentive ears, and a lapping maw lined with mankilling canines.\n\n The rest of the men stand behind their weapons. One yells at the houndmaster to stop all of this. Another says the wolf can smell fear. Yet another throws a rock at it. The wolf winces, but doesn\'t react. Laughing, the houndmaster makes a \'tssst!\' noise and points. The wolf launches forward, picking up the stone and bringing it back to the man. %houndmaster%  rubs the beast\'s mane.%SPEECH_ON%See, easily trained, just any dog. Only bigger, faster, and stronger. Smarter, too.%SPEECH_OFF%Its eyes meet yours. The wolf lays low, almost like a man bowing. %houndmaster% laughs again.%SPEECH_ON%See? It already knows who is alpha of this pack.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A noble beast.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndmaster.getImagePath());
				local item = this.new("scripts/items/accessory/legend_white_wolf_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				this.List.push(::Legends.EventList.changeMood(_event.m.Houndmaster, 2.0, "Managed to tame a white wolf"));
			}
		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/legend_white_wolf.png[/img]The magnificent white beast doesn\'t take the bait. Runs away and most likely %houndmaster%  wont see it again.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Damn beast.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndmaster.getImagePath());
				this.List.push(::Legends.EventList.changeMood(_event.m.Houndmaster, -1.0, "Failed to tame the white wolf"));
			}

		});
	}

	function onUpdateScore()
	{

		//if (this.World.Assets.getOrigin().getID() != "scenario.legends_rangers" && this.World.Assets.getOrigin().getID() != "scenario.rangers" && this.World.Assets.getOrigin().getID() != "scenario.legends_druid")
		//{
		//	return;
		//}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Snow && currentTile.Type != this.Const.World.TerrainType.SnowyForest)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 5 && (bro.getBackground().getID() == "background.legend_commander_ranger" || bro.getBackground().getID() == "background.legend_commander_druid"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Houndmaster = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 6;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"houndmaster",
			this.m.Houndmaster.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Houndmaster = null;
	}

});

