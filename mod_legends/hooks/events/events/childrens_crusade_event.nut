::mods_hookExactClass("events/events/childrens_crusade_event", function(o) {
	o.m.Doubter <- null;
	o.m.Shieldmaiden <- null;

	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.start <- function ( _event ) {
					if (_event.m.Monk != null) {
						this.Options.push({
							Text = "%monk%, you speak for the old gods. What say you?",
							getResult = @(_event) "Monk"
						});
					}

					if (_event.m.Shieldmaiden != null) {
						this.Options.push({
							Text = "%shieldmaiden%, why don\'t you show these runts what war really feels like.",
							getResult = @(_event) "Shieldmaiden"
						});
					}

					if (_event.m.Doubter != null) {
						this.Options.push({
							Text = "%doubter%, you\'ve travelled up there. Say something.",
							getResult = @(_event) "Doubter"
						});
					}

					if (_event.m.Traveller != null) {
						this.Options.push({
							Text = "%walker%, you\'ve travelled up there. Say something.",
							getResult = @(_event) "Traveller"
						});
					}

					this.Options.push({
						Text = "I\'ll save you the long walk and rid you of any valuables right here.",
						getResult = @(_event) "C"
					});

					this.Options.push({
						Text = "Good luck, I guess. (Decrease Moral Reputation)",
						function getResult( _event ) {
							this.World.Assets.addMoralReputation(-1);
							return 0;
						}
					});
				}
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_97.png[/img]You tell the kids to go home to their parents. The leader laughs and the others follow suit, like little \'uns easily impressed by their big brother. He shakes his head.%SPEECH_ON%Why do you think we\'ve come this far? Our parents know right where we are, and they know where we are is truthfully right. The old gods need to be known throughout the land! Now, make way!%SPEECH_OFF%The kids press forth. A little banner flaps past you and there is much clinking and clanking of their little weapons, mostly bottles and sling shots and tableware.\n\n No doubt they are marching toward certain doom. Raiders and vagabonds are sure to prey upon them, like hawks upon lemmings, and slaves don\'t mind making ostensibly orphaned children \'disappear.\' Were they to get further than those threats, the northern wastes will provide for them a frozen coffin to die in. \n\n [img]gfx/ui/icons/asset_moral_reputation.png[/img] The company\'s Moral reputation increases slightly";
			}
			if (s.ID == "Monk") {
				s.Text = "[img]gfx/ui/events/event_97.png[/img]%monk% the holy steps forward and brings the children to a huddle. They instantly respect the religious figure, representing in part the very cause they wish to promote. %monk% bends a knee.%SPEECH_ON%Was it the old gods who told you to come out and do this?%SPEECH_OFF%The little leader nods.%SPEECH_ON%They spoke to me in my sleep.%SPEECH_OFF%The monk nods back, hand rubbing chin, mulling it over and then patting the boy on his head.%SPEECH_ON%The old gods speak to me and I for them. Interpreting their message requires years of study, let me tell you! Are you certain that it was you, little one, that was meant to carry this burden? Perhaps you were to be the messenger, no? See us, we\'re warriors. Fit, fighting folk who can kill those who despise and demark the old gods. You are not yet like us, but you have a strong voice and the command of a true leader yet. I believe the old gods wanted to use you for your charisma, not your muscles.%SPEECH_OFF%The monk gives the boy a playful push. He smiles, realizing the truth of what the friar has to say. The little leader tells his party that they are to return home as the monk is assuredly right. Some men are thankful that these kids were talked out of going to a certain doom.";
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases"
					});
				}
			}
			if (s.ID == "Traveller") {
				s.Text = "[img]gfx/ui/events/event_97.png[/img]Taking off well worn boots, %walker%\'s feet reveal battered soles to the children. They recoil, gagging and covering their mouths. A little girl lets out a long \'ewww\' to really drive the point home. %walker% wags a foot around, showing off disgustingly calloused skin.%SPEECH_ON%I spent years on the road and most of them without a good shoe to step with. I know what it\'s like out there. I\'ve seen the dangers. People stabbing one another in their sleep. Killing for a bite of a biscuit. Strangers befriend ya so they can betray ya. And all that is when it\'s going well! When it goes bad, it gets... well, it gets real bad. You kids got no business being out here. You\'ll be raped, murdered, enslaved, tortured, fed to dogs, eaten by boars, bears, wolves, all things that look at ya like it\'s lunchtime on two legs. Go home. The lot of you.%SPEECH_OFF%The band of children murmurs amongst themselves. One announces he\'s going back to his mom. A little girl states that she didn\'t even want to be out here anyway and never got the treats she was promised. Sensing a morale break, the little leader tries to corral the children, but it\'s no use. The group breaks apart and, thankfully, starts going home. Some of the mercenaries are relieved as they did not wish to see the little ones continue their doomed journey.";
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases"
					});
				}
			}
			if (s.ID == "C") {
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases greatly"
					});
				}
			}
		}

		this.m.Screens.push({
			ID = "Shieldmaiden",
			Text = "[img]gfx_ui/events/event_50.png[/img]%Shieldmaiden% the shieldmaiden looks alarmingly eager as she steps up to the gaggle of little soldiers. She barks at them with such menace that you almost flinch, and it sends a few children physically reeling.%SPEECH_ON%Right then, \'crusaders\'. Let me see your technique, show me how you resist a real charge from a real enemy. Form up- into position!%SPEECH_OFF%She turns her back to the startled albeit enthusiastic horde of kids. She takes a few steps towards you, reveals a wicked smile, then spins on her heels. With a primal howl and mighty rap of her shield, she charges into the mass of flesh, sending a ripple through the meagre formation that sends some children crashing into the muck, with others immediately shattering and turning tail. A few shoves, hollers, and feinted strikes later, and the crusade had been thoroughly killed in its crib- children lay amongst the dirt groaning, others begin to snivel and loudly doubt their holy mission. %shieldmaiden% ends her assault almost as quick as she started it, planting her shield to the floor to offer a hand to the leader of the now broken army. Lifting him up, the ranks begin to reform around your now placated shieldmaiden, and she continues.%SPEECH_ON%See, my brave warriors. Such foes are not to be trifled with at such a tender age. Savages would not show mercy as I have, nor would they give such warning. Together, we can beat them, but for now you would all do better to go home and train, grow- become strong! In time, perhaps I will find you in my shieldwall, side to side as we bring the old gods to that godless land.%SPEECH_OFF%The leader, at first crestfallen from his troop\'s blistering destruction, is renewed with a vigour that could only be childlike naivety. He turns to his host and echoes the shieldmaiden, telling the children that they will serve the old gods in time, but for now they need to practice and prepare themselves. Like a horde of ants, the children begin to spill away in their singular purpose back down the road. %shieldmaiden% returns to you, visibly pleased with her instruction, although perhaps she just enjoyed the mock beatdown. A few of the company applaud her \'hands on\' lesson, others muse at how long such a rabble would have lasted had she not scared them off. Regardless, %shieldmaiden%\'s fierce assault has left her in a markedly better mood- after all, it\'s not everyday you can beat up kids and feel like the good guy.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "You\'ve been waiting for a moment like that, haven\'t you?"
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Shieldmaiden.getImagePath());
				this.World.Assets.addMoralReputation(1);
				this.List.extend([{
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases greatly"
					},
					::Legends.EventList.changeMeleeSkill(_event.m.Shieldmaiden, 2),
					::Legends.EventList.changeInitiative(_event.m.Shieldmaiden, ::Math.rand(1, 3)),
					::Legends.EventList.changeMood(_event.m.Shieldmaiden, 1.0, "Roughhoused kids out of the suicidal crusade")
				]);
			}
		});

		this.m.Screens.push({
			ID = "Doubter",
			Text = "[img]gfx/ui/events/legend_doubter_kids.png[/img]Looking grizzled and sad %doubter% approaches the kids, gets on a knee down at their level and speaks directly. He encourages them to march on, saying that the heartless fires of war needed their bodies as kindling. He speaks of the inevitability of death, the gruesome horrors of violence, the certainty of injury, a lifetimes of disability for the victors, and the endless entropy which tears at the bodies and souls of fragile humans.  The children stare mouths agape in horror, one cries and another runs. Their crusade is over.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Always the life of the party.",
				getResult = @(_event) 0
			}],
			function start( _event )
			{
				this.Characters.push(_event.m.Doubter.getImagePath());
				this.World.Assets.addMoralReputation(1);
				local resolve = this.Math.rand(1, 2);
				_event.m.Doubter.getBaseProperties().Bravery += resolve;
				_event.m.Doubter.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Doubter.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] Resolve"
				});
				_event.m.Doubter.improveMood(1.0, "Saved some children from certain doom");

				if (_event.m.Doubter.getMoodState() >= this.Const.MoodState.Neutral) {
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Doubter.getMoodState()],
						text = _event.m.Doubter.getName() + this.Const.MoodStateEvent[_event.m.Doubter.getMoodState()]
					});
				}
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases"
				});

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers ) {
					if (bro.getID() != _event.m.Doubter.getID() && this.Math.rand(1, 100) <= 25) {
						bro.worsenMood(1.0, "Remembers what " + _event.m.Doubter.getName() + " said about certain doom");

						if (bro.getMoodState() <= this.Const.MoodState.Neutral) {
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					if (bro.getID() != _event.m.Doubter.getID() && this.Math.rand(1, 100) <= 25) {
						bro.improveMood(0.5, "Glad that " + _event.m.Doubter.getName() + " saved children from certain doom");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral) {
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
	}

	o.onUpdateScore = function () {
		if (this.World.FactionManager.isGreaterEvil())
			return;

		if (!this.World.getTime().IsDaytime)
			return;

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
			return;

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y < this.World.getMapSize().Y * 0.2)
			return;

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
			if (t.getTile().getDistanceTo(currentTile) <= 5)
				return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_monk = [];
		local candidates_doubter = [];
		local candidates_traveller = [];
		local candidates_shieldmaiden = [];

		foreach( bro in brothers ) {
			if (bro.getBackground().getID() == "background.monk")
				candidates_monk.push(bro);
			else if (bro.getBackground().getID() == "background.messenger" || bro.getBackground().getID() == "background.vagabond" || bro.getBackground().getID() == "background.refugee" || bro.getBackground().getID() == "background.legend_commander_ranger")
				candidates_traveller.push(bro);
			else if (bro.getBackground().getID() == "background.legend_shieldmaiden")
				candidates_shieldmaiden.push(bro);
			else if (bro.getSkills().hasTrait(::Legends.Trait.LegendDoubleTongued))
				candidates_doubter.push(bro);
		}

		if (candidates_monk.len() != 0)
			this.m.Monk = candidates_monk[this.Math.rand(0, candidates_monk.len() - 1)];

		if (candidates_traveller.len() != 0)
			this.m.Traveller = candidates_traveller[this.Math.rand(0, candidates_traveller.len() - 1)];

		if (candidates_doubter.len() != 0)
			this.m.Doubter = candidates_doubter[this.Math.rand(0, candidates_doubter.len() - 1)];

		if (candidates_shieldmaiden.len())
			this.m.Shieldmaiden = candidates_shieldmaiden[this.Math.rand(0, candidates_shieldmaiden.len() - 1)];

		this.m.Score = 5;
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function (_vars) {
		onPrepareVariables(_vars);
		_vars.push([
			"doubter",
			this.m.Doubter != null ? this.m.Doubter.getName() : ""
		]);
		if (this.m.Shieldmaiden) {
			_vars.push(["shieldmaiden", this.m.Shieldmaiden.getName()]);
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Shieldmaiden.getGender(), "shieldmaiden");
		}
	}

	local onClear = o.onClear;
	o.onClear = function () {
		onClear();
		this.m.Doubter = null;
		this.m.Shieldmaiden = null;
	}

})
