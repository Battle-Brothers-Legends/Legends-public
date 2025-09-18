::mods_hookExactClass("events/events/supposed_witch_event", function(o) {
	o.m.Dude <- null;

	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Good") {
				s.Options = [{
					Text = "Alright, we\'ll take you.",
					function getResult( _event ) {
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}
				}, {
					Text = "I hope she finds somewhere safe to be.",
					function getResult( _event ) {
						return 0;
					}
				}];
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(3);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases"
					});
					local brothers = this.World.getPlayerRoster().getAll();

					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
					{
						_event.m.Dude.getFlags().add("PlayerSkeleton");
						_event.m.Dude.getFlags().add("undead");
						_event.m.Dude.getFlags().add("skeleton");
						_event.m.Dude.setStartValuesEx(
							this.Const.SupposedWitchBackgrounds, true, 1
						);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.RacialSkeleton);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendFleshless);
					}
					else
					{
						_event.m.Dude.setStartValuesEx(
							this.Const.SupposedWitchBackgrounds, true, 1
						);
					}

					_event.m.Dude.setTitle("the Roasted");
					_event.m.Dude.getBackground().m.RawDescription = "While visiting the local village you found %name% tied to a stake and set her free, now she fights with you and for her freedom";
					_event.m.Dude.getBackground().buildDescription(true);
					this.Characters.push(_event.m.Dude.getImagePath());

					foreach( bro in brothers ) {
						if (this.Math.rand(1, 100) <= 25) {
							if (this.Math.rand(1, 100) <= 66) {
								local injury = bro.addInjury(this.Const.Injury.Brawl);
								this.List.push({
									id = 10,
									icon = injury.getIcon(),
									text = bro.getName() + " suffers " + injury.getNameOnly()
								});
							} else {
								bro.addLightInjury();
								this.List.push({
									id = 10,
									icon = "ui/icons/days_wounded.png",
									text = bro.getName() + " suffers light wounds"
								});
							}
						}

						if (this.Math.rand(1, 100) <= 25 && bro.getBackground().getID() != "background.witchhunter") {
							bro.improveMood(1.0, "You saved a woman from being burned at the stake");
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
			}
			if (s.ID == "Bad") {
				s.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases"
				});
			}
			if (s.ID == "Witchhunter") {
				s.start <- function ( _event )
				{
					this.Characters.push(_event.m.Witchhunter.getImagePath());
					local resolve = 2;
					local initiative = 1;
					_event.m.Witchhunter.getBaseProperties().Bravery += resolve;
					_event.m.Witchhunter.getBaseProperties().Initiative += initiative;
					_event.m.Witchhunter.getSkills().update();
					_event.m.Witchhunter.improveMood(2.0, "Killed an evil spirit");

					if (_event.m.Witchhunter.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Witchhunter.getMoodState()],
							text = _event.m.Witchhunter.getName() + this.Const.MoodStateEvent[_event.m.Witchhunter.getMoodState()]
						});
					}

					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Witchhunter.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] Resolve"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/initiative.png",
						text = _event.m.Witchhunter.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative + "[/color] Initiative"
					});
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers )
					{
						if (bro.getID() != _event.m.Witchhunter.getID() && (this.Math.rand(1, 100) <= 25 || bro.getBackground().getID() == "background.witchhunter" || bro.getBackground().getID() == "background.monk"  || bro.getSkills().hasTrait(::Legends.Trait.Superstitious)))
						{
							bro.improveMood(1.0, "Saw an evil spirit meet its end");

							if (bro.getMoodState() >= this.Const.MoodState.Neutral)
							{
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						}
					}
				}
			}
			if (s.ID == "Monk") {
				s.Text = "[img]gfx/ui/events/event_79.png[/img]The holy one, %monk%, sits with the town\'s own friar and talks for a time. When they are done, a nod is given to the torchman who sets the wooden pallets aflame. The woman screams for mercy, but the flames have none for her, slowly working up feet first. It is a horrific sight and only when the smoke is a choking cloud does the dying woman go silent. The fire consumes her entirely as the rest of the town claps and cheers. %monk% states that she was clearly a witch and had to be done away with. You\'re not sure. All you saw was a woman burned alive, but you trust that they know more than you about the war between the old gods and the evils of sorcery.";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Monk.getImagePath());
					local resolve = this.Math.rand(2, 4);
					_event.m.Monk.getBaseProperties().Bravery += resolve;
					_event.m.Monk.getSkills().update();
					_event.m.Monk.improveMood(2.0, "Had a witch burned");

					if (_event.m.Monk.getMoodState() >= this.Const.MoodState.Neutral)
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Monk.getMoodState()],
							text = _event.m.Monk.getName() + this.Const.MoodStateEvent[_event.m.Monk.getMoodState()]
						});

					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Monk.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] Resolve"
					});
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getID() != _event.m.Monk.getID() && (bro.getBackground().getID() == "background.witchhunter" || bro.getBackground().getID() == "background.monk" || bro.getSkills().hasTrait(::Legends.Trait.Superstitious))) {
							bro.improveMood(1.0, "Saw a witch burning at the stake");

							if (bro.getMoodState() >= this.Const.MoodState.Neutral)
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
						}
					}
				}
			}
			if (s.ID == "Cultist") {
				s.Text = "[img]gfx/ui/events/event_79.png[/img]%cultist% steps forward and looks the villagers up and down, with a slowing shaking head.%SPEECH_ON%You all should kill yourselves.%SPEECH_OFF%The town monk rustles up his cloak.%SPEECH_ON%E-excuse me?%SPEECH_OFF%The cultist starts to cut the woman down. A few of your mercenaries step forward to stop anyone from protesting. When she\'s free and sent running for her own safety, %cultist% speaks again.%SPEECH_ON%Kill yourselves. Each of you. Tonight. You\'ve angered Davkul and his rage is a debt you\'d do best to pay yourself.%SPEECH_OFF%The monk opens his mouth to say something, but his nose cracks as though indented by an invisible stone. He lurches, blood spewing from his nostrils. %cultist% nods.%SPEECH_ON%Hmm, he is angrier than I had thought. Davkul awaits us all, but he is now on your doorstep.%SPEECH_OFF%Screaming, the monk falls to the ground as his jaw sickeningly cracks open, his mouth left permanently ajar. The villagers scream and disperse like rabbits beneath the shadow of a hawk.";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Cultist.getImagePath());
					local resolve = 2;
					_event.m.Cultist.getBaseProperties().Bravery += resolve;
					_event.m.Cultist.getSkills().update();
					_event.m.Cultist.improveMood(2.0, "Witnessed Davkul\'s power");

					if (_event.m.Cultist.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Cultist.getMoodState()],
							text = _event.m.Cultist.getName() + this.Const.MoodStateEvent[_event.m.Cultist.getMoodState()]
						});
					}

					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Cultist.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] Resolve"
					});
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getID() != _event.m.Cultist.getID() && (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist))) {
							bro.improveMood(1.0, "Witnessed Davkul\'s power");

							if (bro.getMoodState() >= this.Const.MoodState.Neutral)
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
						} else if (bro.getBackground().getID() == "background.witchhunter" || bro.getBackground().getID() == "background.monk"  || bro.getSkills().hasTrait(::Legends.Trait.Superstitious)) {
							bro.worsenMood(1.0, _event.m.Cultist.getName() + " freed a witch");

							if (bro.getMoodState() < this.Const.MoodState.Neutral)
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
						}
					}
				}
			}
		}
	}

	o.onUpdateScore = function () {
		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
			return;

		if (this.World.getTime().Days <= 15)
			return;

		if (!this.World.getTime().IsDaytime)
			return;

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
			return;

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.2)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidate_witchhunter = [];
		local candidate_monk = [];
		local candidate_cultist = [];

		foreach( bro in brothers ) {
			if (bro.getBackground().getID() == "background.witchhunter")
				candidate_witchhunter.push(bro);
			else if (bro.getBackground().getID() == "background.monk")
				candidate_monk.push(bro);
			else if (bro.getSkills().hasPerk(::Legends.Perk.LegendScholar)) //maybe add this here?
				candidate_monk.push(bro);
			else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist))
				candidate_cultist.push(bro);
		}

		if (candidate_witchhunter.len() != 0)
			this.m.Witchhunter = candidate_witchhunter[this.Math.rand(0, candidate_witchhunter.len() - 1)];

		if (candidate_monk.len() != 0)
			this.m.Monk = candidate_monk[this.Math.rand(0, candidate_monk.len() - 1)];

		if (candidate_cultist.len() != 0)
			this.m.Cultist = candidate_cultist[this.Math.rand(0, candidate_cultist.len() - 1)];

		this.m.Score = 5;
	}

	local onClear = o.onClear;
	o.onClear = function  () {
		this.m.Dude = null;
		onClear();
	}

})
