this.legend_blacksmith_fix_equipment <- this.inherit("scripts/events/event", {
	m = {
		Blacksmith = null
	},
	function create()
	{
		this.m.ID = "event.legend_blacksmith_fix_equipment";
		this.m.Title = "During camp...";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_82.png[/img]While setting up for a camp %blacksmith% takes you aside, the staunch musclebound man looking unusually concerned.%SPEECH_ON%Sir, this equipment of ours is in really bad shape! It\'s a disgrace to be seen fighting in this. It is high time we bring it back to working condition!%SPEECH_OFF% The brute of a man rolls up his sleeves and swings around his hammer, seemingly eager to spend a whole night working his anvil.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Do what you think is best...",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 70)
						{
							return "Good";
						}
						else
						{
							return "Bad";
						}
					}

				},
				{
					Text = "I need you fighting fit, sleep instead!.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Good",
			Text = "[img]gfx/ui/events/event_82.png[/img]{%blacksmith% spends a whole night in his workshop working his anvil. He pulls steel together and works his magic on his own, mending the weapons back into excellent condition. After the work is done he walks out, wiping a huge torrent of sweat from his brow. %SPEECH_ON%It is done, as best as I can do in these conditions.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Nice work!",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Blacksmith.getImagePath());

				this.List.push(::Legends.EventList.changeMood(_event.m.Blacksmith, -0.5, "Stayed up all night working"));

				local stash = this.World.Assets.getStash().getItems();
				local items = 0;

				foreach( item in stash )
				{
					if (item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && item.getCondition() < item.getConditionMax())
					{
						item.setCondition(item.getRepairMax());
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "Your " + item.getName() + " is repaired"
						});
						items = ++items;

						if (items > 4)
						{
							break;
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "Bad",
			Text = "[img]gfx/ui/events/event_13.png[/img]{While you leave %blacksmith% to start working on the equipment, you hear a crack and a loud scream. You rush to the smithy to see what happen only to find the blacksmith bleeding from a fresh impact wound. It seems too long off the tools has left him rusty. }",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Get him Patched up!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Blacksmith.getImagePath());
				this.List.push(::Legends.EventList.changeMood(_event.m.Blacksmith, -1.0, "Accidentally injured himself"));
				local injury = _event.m.Blacksmith.addInjury(this.Const.Injury.Helping);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Blacksmith.getName() + " suffers " + injury.getNameOnly()
				});
				_event.m.Blacksmith.addLightInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.Blacksmith.getName() + " suffers light wounds"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_blacksmith = [];

		foreach( b in brothers )
		{
			if (b.getBackground().getID() == "background.legend_blacksmith")
			{
				candidates_blacksmith.push(b);
			}
		}

		if (candidates_blacksmith.len() < 1)
		{
			return;
		}
		else
		{
			this.m.Blacksmith = candidates_blacksmith[this.Math.rand(0, candidates_blacksmith.len() - 1)];
		}

		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"blacksmith",
			this.m.Blacksmith.getName()
		]);
	}

	function onClear()
	{
		this.m.Blacksmith = null;
	}

});

