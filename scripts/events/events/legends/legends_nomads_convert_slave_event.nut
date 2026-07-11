this.legends_nomads_convert_slave_event <- this.inherit("scripts/events/event", {
	m = {
		slave = null
	},
	function create()
	{
		this.m.ID = "event.legends_nomads_convert_slave";
		this.m.Title = "During camp...";
		this.m.Cooldown = 28.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_166.png[/img]%slave% has been with you for some time — regardless of where they came from, they have fully embraced the path of the interloper in both blood and spirit. The concept of keeping someone of their kind is an uneasy one for you. They have served in the tribe without much graditude or fair treatment. Perhaps it is time to cut the shackles and bring them into the fold?",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It is time.",
					function getResult( _event )
					{
						return "B"; //accept
					}

				},
				{
					Text = "They are not ready.",
					function getResult( _event )
					{
						return "D"; //Decline
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.slave.getImagePath());
			}

		});
		this.m.Screens.push({ //accept
			ID = "B",
			Text = "[img]gfx/ui/events/event_166.png[/img]While %slave%, unsurprisingly, welcomes their new freedom. There are several directions within the path of the interloper they could travel towards. But once the jurney is started, there is no going back...",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Ask how they feel about fighting in the line with the other nomads.", //Become Nomad
					function getResult( _event )
					{
						return "C1";
					}
				},
				{
					Text = "Test their skill with a sling and bow.", //nomad ranged
					function getResult( _event )
					{
						return "C2";
					}
				},
				{
					Text = "Maybe they wish to travel the northern lands?", //Become Muladi
					function getResult( _event )
					{
						return "C3";
					}
				},
				{
					Text = "Perhaps they are ready to become a true protector of the tribe?", //Become blade dancer
					function getResult( _event )
					{
						return "C4";
					}
				}
			],
			function start( _event )
			{
			}
		});
		this.m.Screens.push({ //—
			ID = "C1",
			Text = "[img]gfx/ui/events/event_156.png[/img]%slave% has been tested in the frontline more than most, and has found great company with those in the melee. After further consideration, they agree their new family is at the heart of the fighting with their nomad brothers — bloody saif in hand.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "They will do well here",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event ) //nomad melee
			{
				this.Characters.push(_event.m.slave.getImagePath());
				local bg = this.new("scripts/skills/backgrounds/nomad_background");
				bg.m.IsNew = false;
				local oldPerkTree = _event.m.slave.getBackground().m.CustomPerkTree;
				_event.m.slave.getSkills().removeByID("background.slave");
				_event.m.slave.getSkills().add(bg);
				_event.m.slave.getBackground().m.RawDescription = "Previously a slave, %name% found a new home in your tribe with the first line of defense, further cementing their place as a true and fearless nomad.";
				_event.m.slave.getBackground().buildDescription(true);
				_event.m.slave.getBackground().rebuildPerkTree(oldPerkTree);
				_event.m.slave.resetPerks();
				_event.m.slave.improveMood(2.0, "Escaped a long life of servitude");

				if (_event.m.slave.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.slave.getMoodState()],
						text = _event.m.slave.getName() + this.Const.MoodStateEvent[_event.m.slave.getMoodState()]
					});
				}

				_event.m.slave.getBaseProperties().MeleeSkill += 15;
				_event.m.slave.getBaseProperties().Bravery += 20;
				_event.m.slave.getBaseProperties().MeleeDefense += 7;
				_event.m.slave.getBaseProperties().Hitpoints += 5;
				_event.m.slave.getBaseProperties().Initiative += 5;
				_event.m.slave.getSkills().update();

				this.List.push({
					id = 16,
					icon = "ui/icons/health.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+5[/color] Hitpoints"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+20[/color] Resolve"
				});

				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+10[/color] Melee Skill"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_defense.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+7[/color] Melee Defense"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+5[/color] Initiative"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/special.png",
					text = _event.m.slave.getName() + " is now paid a wage as a nomad"
				});
			}
		});
		this.m.Screens.push({ //—
			ID = "C2",
			Text = "[img]gfx/ui/events/event_170.png[/img]Their cruelty at the hands of their masters has made %slave% seek bloodshed from a distance. What their masters mistook for cowardice you realise is a quiet cunning as they visually dissect their prey before comitting to the killing blow.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "They will do well here",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event ) //nomad ranged
			{
				this.Characters.push(_event.m.slave.getImagePath());
				local bg = this.new("scripts/skills/backgrounds/nomad_ranged_background");
				bg.m.IsNew = false;
				local oldPerkTree = _event.m.slave.getBackground().m.CustomPerkTree;
				_event.m.slave.getSkills().removeByID("background.slave");
				_event.m.slave.getSkills().add(bg);
				_event.m.slave.getBackground().m.RawDescription = "Previously a slave, %name% adjusted well enough in your tribe to become one of the elite few of nomad marksmen.";
				_event.m.slave.getBackground().buildDescription(true);
				_event.m.slave.getBackground().rebuildPerkTree(oldPerkTree);
				_event.m.slave.resetPerks();
				_event.m.slave.improveMood(2.0, "Escaped a long life of servitude");

				if (_event.m.slave.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.slave.getMoodState()],
						text = _event.m.slave.getName() + this.Const.MoodStateEvent[_event.m.slave.getMoodState()]
					});
				}

				_event.m.slave.getBaseProperties().RangedSkill += 20;
				_event.m.slave.getBaseProperties().RangedDefense += 8;
				_event.m.slave.getBaseProperties().Initiative += 25;
				_event.m.slave.getSkills().update();

				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_skill.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+20[/color] Ranged Skill"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_defense.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+8[/color] Ranged Defense"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+25[/color] Initiative"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/special.png",
					text = _event.m.slave.getName() + " is now paid a wage as a nomad"
				});
			}

		});
		this.m.Screens.push({
			ID = "C3",
			Text = "[img]gfx/ui/events/event_170.png[/img]While %slave% has shown committment to the cause, you often catching them drawn to your northern cousins — ever seeking out crownlings and asking them about their work and homes. Perhaps this is what you will all eventually arrive at, a life between the worlds of the cold north and harsh south...",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "They seem happy enough",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event ) //muladi
			{
				this.Characters.push(_event.m.slave.getImagePath());
				local bg = this.new("scripts/skills/backgrounds/legend_muladi_background");
				bg.m.IsNew = false;
				local oldPerkTree = _event.m.slave.getBackground().m.CustomPerkTree;
				_event.m.slave.getSkills().removeByID("background.slave");
				_event.m.slave.getSkills().add(bg);
				_event.m.slave.getBackground().m.RawDescription = "Previously a slave, %name% became much more interested in the northerners than your own culture.";
				_event.m.slave.getBackground().buildDescription(true);
				_event.m.slave.getBackground().rebuildPerkTree(oldPerkTree);
				_event.m.slave.resetPerks();
				_event.m.slave.improveMood(2.0, "Escaped a long life of servitude");

				if (_event.m.slave.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.slave.getMoodState()],
						text = _event.m.slave.getName() + this.Const.MoodStateEvent[_event.m.slave.getMoodState()]
					});
				}

				_event.m.slave.getBaseProperties().MeleeSkill += 5;
				_event.m.slave.getBaseProperties().RangedSkill += 5;
				_event.m.slave.getBaseProperties().MeleeDefense += 3;
				_event.m.slave.getBaseProperties().RangedDefense += 3;
				_event.m.slave.getBaseProperties().Hitpoints += 5;
				_event.m.slave.getBaseProperties().Bravery += 10;
				_event.m.slave.getBaseProperties().Stamina += 10;
				_event.m.slave.getBaseProperties().Initiative += 8;
				_event.m.slave.getSkills().update();

				this.List.push({
					id = 16,
					icon = "ui/icons/health.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+5[/color] Hitpoints"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+10[/color] Resolve"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/fatigue.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+10[/color] Max Fatigue"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+5[/color] Melee Skill"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_skill.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+5[/color] Ranged Skill"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_defense.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+3[/color] Melee Defense"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_defense.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+3[/color] Ranged Defense"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+8[/color] Initiative"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/special.png",
					text = _event.m.slave.getName() + " is now paid a wage as a Muladi"
				});
			}
		});
		this.m.Screens.push({
			ID = "C4",
			Text = "[img]gfx/ui/events/event_156.png[/img]%slave% has shown great speed and precision in every battle so far — always been near the heart of battle and being deft enough to avoid danger thus far. Their new charge as a protector of the tribe suits them perfectly.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Gloriously Swift!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event ) //blade dancer
			{
				this.Characters.push(_event.m.slave.getImagePath());
				local bg = this.new("scripts/skills/backgrounds/legend_background_bladedancer");
				bg.m.IsNew = false;
				local oldPerkTree = _event.m.slave.getBackground().m.CustomPerkTree;
				_event.m.slave.getSkills().removeByID("background.slave");
				_event.m.slave.getSkills().add(bg);
				_event.m.slave.getBackground().m.RawDescription = "Previously a slave, %name% earned their place in the nomadic tribe as an elite Bladedancer";
				_event.m.slave.getBackground().buildDescription(true);
				_event.m.slave.getBackground().rebuildPerkTree(oldPerkTree);
				_event.m.slave.resetPerks();
				_event.m.slave.improveMood(2.0, "Escaped a long life of servitude");

				if (_event.m.slave.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.slave.getMoodState()],
						text = _event.m.slave.getName() + this.Const.MoodStateEvent[_event.m.slave.getMoodState()]
					});
				}

				_event.m.slave.getBaseProperties().MeleeSkill += 20;
				_event.m.slave.getBaseProperties().MeleeDefense += 8;
				_event.m.slave.getBaseProperties().Bravery += 8;
				_event.m.slave.getBaseProperties().Stamina += 12;
				_event.m.slave.getBaseProperties().Initiative += 35;
				_event.m.slave.getSkills().update();

				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+8[/color] Resolve"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/fatigue.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+12[/color] Max Fatigue"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+20[/color] Melee Skill"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_defense.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+8[/color] Melee Defense"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.slave.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+35[/color] Initiative"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/special.png",
					text = _event.m.slave.getName() + " is now paid a wage as a Bladedancer"
				});
			}
		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_150.png[/img]You sense it is not the time yet, %slave% still has much to learn and there will always be another opportunity...",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Soon. But not now.",
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
	}

	function onUpdateScore()
	{
		if (!this.World.Assets.getOrigin().getID() == "scenario.legends_nomad")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local slave_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.slave") //Indebted, both normal, north and south.
			{
				slave_candidates.push(bro);
			}
		}

		if (slave_candidates.len() == 0)
		{
			return;
		}

		this.m.slave = slave_candidates[this.Math.rand(0, slave_candidates.len() - 1)];
		this.m.Score = (slave_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"slave",
			this.m.slave.getName()
		]);
	}

	function onClear()
	{
		this.m.slave = null;
	}
});

