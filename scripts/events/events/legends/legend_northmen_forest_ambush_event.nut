this.legend_northmen_forest_ambush_event <- this.inherit("scripts/events/event", {
	m = {
		Barbarian = null,
		Wildman = null,
		MasterArcher = null,
		Assassin = null
		// Rewarditems = 0
	},
	function create()
	{
		this.m.ID = "event.legend_northmen_forest_ambush";
		this.m.Title = "In the forest...";
		this.m.Cooldown = 80.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_55.png[/img]{The forests are a quiet place where civilisation gives way to nature — but also to those cast away from society or wish to exclude themselves from it.\n It would not be the first time you ran into {a troupe of otherwise peaceful poachers trying to make ends meet | a lone knight armed to the breeches with a variety of weapons and plate | a wildman completely naked with only their weapon for comfort | two-dozen cultists running about the hills screaming at the top of their lungs about this and that | a group of sickly explorers asking for directions | a well regulated militia | three imposing figures clad in gold | a group of well organised and terrifying cultists}. The world gets much stranger out here — but also much more dangerous.\n\n From the treeline, you hear voices and branches cracking.\n\n You hear the chanting of northmen.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Form up and be ready!",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 65)
						{
							return "Lightpatrol";
						}
						else if (r <= 35)
						{
							return "Heavypatrol";
						}
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Barbarian != null)
				{
					this.Options.push({
						Text = "{Our barbarian, %barbarian% wants to talk to them.}",
						function getResult( _event )
						{
							return "Barbarian";
						}

					});
				}

				if (_event.m.Wildman != null)
				{
					this.Options.push({
						Text = "{%wildman% is about to break into a berserk fury...}",
						function getResult( _event )
						{
							return "Wildman";
						}

					});
				}

				if (_event.m.MasterArcher != null)
				{
					this.Options.push({
						Text = "{It seems that our master archer, %masterarcher% has a plan.}",
						function getResult( _event )
						{
							return "MasterArcher";
						}

					});
				}

				if (_event.m.Assassin != null)
				{
					this.Options.push({
						Text = "Our assassin, %assassin% has an idea...",
						function getResult( _event )
						{
							return "Assassin";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Lightpatrol",
			Text = "[img]gfx/ui/events/event_135.png[/img]{You hold your ground as the party approaches, thankfully smaller than it sounded at a distance.\n The group sees your formation and weighs their options before streaming out from the secluded path they were once on towards you.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "To arms!",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.BarbarianTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Barbarians, this.Math.rand(75, 110) * _event.getReputationToDifficultyLightMult(), this.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Heavypatrol",
			Text = "[img]gfx/ui/events/event_135.png[/img]{You hold your ground and brace for a fight — the group you heard arrives into view and quickly retreats.\n\n As you wait to see if they left for good, another, much larger group looms over the hill and charges through the trees.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Oh fark.",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.BarbarianTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Barbarians, this.Math.rand(110, 140) * _event.getReputationToDifficultyLightMult(), this.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Barbarian",
			Text = "[img]gfx/ui/events/event_139.png[/img]{%barbarian% comes forward and asks for your permission to go parlay with the group of northmen. You approve and %barbarian% lays down their weapons and approaches the group. They speak in a tongue that you can\'t make out — but sounds almost ancient in nature. Words are exchanged between %barbarian% and the raid leader, who barely move between words while the rest of the warparty twitch and pace nervously near the two negotiators.\n\n Soon the raid leader slaps %barbarian% on the shoulder and beams a smile, but not before handing them a small wooden chest wrapped in leather.\n The raiding party departs in another direction, to which the northmen resume their chanting as they march. %barbarian% jogs back to you with the chest under their bulging arm as if they had stolen it. %SPEECH_ON%They\'re traders — or so they say. They have been walking around this patch of forest for hours now trying to find a camp of bandits that took out one of their caravans. I think they mistook you for the bandits.%SPEECH_OFF% %barbarian% taps the chest under their arm. %SPEECH_ON% However, it wasn\'t a total waste. They gave us this as said to be on our way. They didn\'t say sorry but believe me — we got off lightly...%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Well done.",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);
						return 0;
					}

				}
			],
			function start( _event ) //im simplifying this - it is far too complex (yes i know i wrote this months ago shut up)
			{
				this.Characters.push(_event.m.Barbarian.getImagePath());
				local item = this.new("scripts/items/loot/looted_valuables_item");
				this.List.push(::Legends.EventList.changeResolve(_event.m.Barbarian, ::Math.rand(2, 4)));
				this.List.push(::Legends.EventList.changeMood(_event.m.Barbarian, 1.0, "prevented a bloodbath in the woods"));
				_event.m.Barbarian.getSkills().update();

				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});

				// _event.m.Rewarditems.getItems().transferToStash(this.World.Assets.getStash());

				// if (_event.m.Barbarian.getMoodState() >= this.Const.MoodState.Neutral)
				// {
				// 	this.List.push({
				// 		id = 10,
				// 		icon = this.Const.MoodStateIcon[_event.m.Barbarian.getMoodState()],
				// 		text = _event.m.Barbarian.getName() + this.Const.MoodStateEvent[_event.m.Barbarian.getMoodState()]
				// 	});
				// }

				// this.List.push({
				// 	id = 10,
				// 	icon = "ui/icons/asset_moral_reputation.png",
				// 	text = "The company\'s moral reputation increases slightly for talking it out rather than resorting to violence"
				// });
			}

		});
		this.m.Screens.push({
			ID = "Wildman",
			Text = "[img]gfx/ui/events/event_86.png[/img]{%wildman% surges forward like a dog unshackled and runs toward the noise. A forward scout crests the treeline and immediately receives a rock to the temple for their efforts. %wildman% begins to scream, or rather, continue to scream but louder as he beats the scout to death with a tree bough.\n\n A handful of warriors come over the crest in an attempt to figure out what kind of animal was dying to make such a noise. The first has their jaw broken by the now splintered tree bough while the second is wrestled to the floor by %wildman% and has their eyes gouged for good measure.\n\n The rest of %companyname% do not know whether to cheer or run but continue to watch in awe at the frenzied monster clubbing the third northman to death with a sharp rock.\n\n The rest of the patrol finally assemble and %wildman% regains their wits and beats a hasty retreat back to your formation. One of their victims was much better armoured than the rest and you suspect %wildman% just accidently killed their leader before the battle has even begun.\n The patrol\'s numbers have been thinned and your wildling has only a few scratches to show for it!}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We better go help now.",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.BarbarianTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Barbarians, this.Math.rand(60, 75) * _event.getReputationToDifficultyLightMult(), this.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
				this.List.push(::Legends.EventList.changeResolve(_event.m.Wildman, ::Math.rand(4, 6)));
				this.List.push(::Legends.EventList.addLightInjury(_event.m.Wildman));
				this.List.push(::Legends.EventList.changeMood(_event.m.Wildman, 2.0, "Had a good time"));
				_event.m.Wildman.getSkills().update();
			}

		});
		this.m.Screens.push({
			ID = "MasterArcher",
			Text = "[img]gfx/ui/events/event_86.png[/img]{%masterarcher% drops into a low crouch and whistles to you. They point with their eyes and motion with their head to a small clearing from an old path off the trail. You order %companyname% and the wagons to be moved into the pathway and any bright colours to be removed from their clothing and armour. The company complies and quietly funnels into the offshoot and down into a deep ditch behind the treeline.\n\n The ditch is damp and cold, but you can hear the patrol passing overhead — stomping and chanting as they make their way along the road. For a moment you think they have found the path, but it turns out a few of the raiding party chose to relieve themselves in the bushes nearby rather than invesigate further.\n After a short time later, the noise dies down and the company moves out, all while %masterarcher% is grinning ear to ear.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Nicely done.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.MasterArcher.getImagePath());
				this.List.push(::Legends.EventList.changeResolve(_event.m.MasterArcher, ::Math.rand(2, 5)));
				this.List.push(::Legends.EventList.changeInitiative(_event.m.MasterArcher, ::Math.rand(3, 6)));
				this.List.push(::Legends.EventList.changeMood(_event.m.MasterArcher, 1.0, "Evaded a patrol"));
				_event.m.MasterArcher.getSkills().update();
			}

		});
		this.m.Screens.push({
			ID = "Assassin",
			Text = "[img]gfx/ui/events/event_76.png[/img]{%assassin% appears behind you — almost quite literally as you did not detect they were there until they spoke into your ear. %SPEECH_ON% The northmen are a ragged bunch and don\'t take any caution when announcing their presence. They rely on that fear you see, the idea that they come as a wave and there is nothing you can do to stop them. But the predator often does not take the caution it should because it does not expected to be hunted by something bigger...%SPEECH_OFF% %assassin% was being their usual strange self again. But you nod and play along for now. %SPEECH_ON% ...all we need is to take a wide angle around the forward scouts and come up on them from behind. We can steadily pick them off and encircle them.%SPEECH_OFF% You approve, and %companyname% splits into groups or single entities ordered to attack for a specific direction. %assassin% orchestrates between all the groups and you follow them as part of the plan.\n\n %assassin% brings down some of the more armoured opponents with ease, while you do the same in a messier manner. After a short time the scouts have all been dealt with and the barbarians that have wandered from the column are also picked off and hidden in the brush.\n After a time the group has noticed most of their force has gone, but at this point it is too late to react as the rest find themselves hopelessly encircled — much to the enjoyment of your assassin.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "To arms!",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.BarbarianTracks;
						properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						properties.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Center;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Barbarians, this.Math.rand(60, 70) * _event.getReputationToDifficultyLightMult(), this.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

					function onEntityPlaced( _entity, _tag )
					{
						_entity.setMoraleState(this.Const.MoraleState.Fleeing);
						_entity.getBaseProperties().Bravery = 50;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Assassin.getImagePath());
				this.List.push(::Legends.EventList.changeResolve(_event.m.Assassin, ::Math.rand(4, 7)));
				this.List.push(::Legends.EventList.changeInitiative(_event.m.Assassin, ::Math.rand(3, 6)));
				this.List.push(::Legends.EventList.changeMood(_event.m.Assassin, 1.0, "Outsmarted a raiding party"));
				_event.m.Assassin.getSkills().update();
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 5)
		{
			return;
		}

		if (this.World.getTime().Days < 40)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.SnowyForest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local candidates_barbarian = [];
		local candidates_wildman = [];
		local candidates_masterarcher = [];
		local candidates_assassin = [];

		foreach( b in brothers )
		{
			if (b.getBackground().getID() == "background.barbarian" || b.getBackground().getID() == "background.raider")
			{
				candidates_barbarian.push(b);
			}
			else if (b.getBackground().getID() == "background.wildman" || b.getBackground().getID() == "background.legend_berserker")
			{
				candidates_wildman.push(b);
			}
			else if (b.getBackground().getID() == "background.poacher" || b.getBackground().getID() == "background.hunter" || b.getBackground().getID() == "background.legend_master_archer")
			{
				candidates_masterarcher.push(b);
			}
			else if (b.getBackground().getID() == "background.assassin" || b.getBackground().getID() == "background.assassin_southern")
			{
				candidates_assassin.push(b);
			}
		}

		if (candidates_barbarian.len() != 0)
		{
			this.m.Barbarian = candidates_barbarian[this.Math.rand(0, candidates_barbarian.len() - 1)];
		}

		if (candidates_wildman.len() != 0)
		{
			this.m.Wildman = candidates_wildman[this.Math.rand(0, candidates_wildman.len() - 1)];
		}

		if (candidates_masterarcher.len() != 0)
		{
			this.m.MasterArcher = candidates_masterarcher[this.Math.rand(0, candidates_masterarcher.len() - 1)];
		}

		if (candidates_assassin.len() != 0)
		{
			this.m.Assassin = candidates_assassin[this.Math.rand(0, candidates_assassin.len() - 1)];
		}

		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"barbarian",
			this.m.Barbarian != null ? this.m.Barbarian.getName() : ""
		]);
		_vars.push([
			"wildman",
			this.m.Wildman != null ? this.m.Wildman.getName() : ""
		]);
		_vars.push([
			"masterarcher",
			this.m.MasterArcher != null ? this.m.MasterArcher.getName() : ""
		]);
		_vars.push([
			"assassin",
			this.m.Assassin != null ? this.m.Assassin.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Barbarian = null;
		this.m.Wildman = null;
		this.m.MasterArcher = null;
		this.m.Assassin = null;
		// this.m.Rewarditems = null;
	}

});

