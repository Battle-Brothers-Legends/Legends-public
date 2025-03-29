::mods_hookExactClass("events/events/dlc4/drunk_nobleman_event", function(o) {
	o.m.Noble <- null;
	o.m.Dude <- null;

	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "%terrainImage%{While on the march, you find a drunken nobleman tottering side to side on the path. Mussy is the name of his hair, leaves and grass and what looks like birdshit swept up in it like someone stirred the ingredients to a prank. But his clothes sweep about with the finest of silks and his fingers glisten with jewelry. He has a bottle in each hand and he swings them around as he sings gibberish pub songs.\n\nHe is in all regards the greatest magnet for a mugging you\'ve ever seen. %randombrother% purses lips and looks like a wolf staring at a fat sheep.%SPEECH_ON%I\'m not saying nothing, sir, I\'m just. I\'m just seeing it. That\'s a lot of juice. A lot of juice limping down the road. But again I ain\'t saying nothing.%SPEECH_OFF%You know what the sellsword\'s talking about.}";
				s.start <- function ( _event ) {
					if (_event.m.Servant != null) {
						this.Options.push({
							Text = "Why is he looking at %servant%?",
							function getResult( _event ) {
								return "G";
							}
						});
					}

					if (_event.m.Thief != null) {
						this.Options.push({
							Text = "Perhaps %thief% can ease his burden.",
							function getResult( _event ) {
								return "H";
							}
						});
					}

					if (_event.m.Noble != null) {
						this.Options.push({
							Text = "Hey that\'s %noble%\'s cousin.",
							function getResult( _event ) {
								return "I";
							}
						});
					}

					this.Options.push({
						Text = "Leave him be.",
						function getResult( _event ) {
							return 0;
						}
					});
				}
			}
			if (s.ID == "B") {
				s.Text = "%terrainImage%{You walk up to the man and help him sit down. He grins as one of his bottles clanks off the path and rolls away.%SPEECH_ON%Thankiicup, sir, jast, no, well, ya.%SPEECH_OFF%Nodding, you hold his hand out and spit on his fingers, then roll the jewelry off and pocket them. He merely watches as though you were a physician treating a malady. The rest of your mercenaries strip him down and throw a goatskin tarp over him and then leave him there. As you walk away he asks if you know about the drink.%SPEECH_ON%Not, not sayin\' away the secret, but, sirs, drinks are good.%SPEECH_OFF%Yes, are they ever. Unfortunately, as you rejoin the company %randombrother% reports that a kid saw everything and scampered off. You ask why the mercenary didn\'t chase after him, the bemused sellsword looks at you shrewdly.%SPEECH_ON%I\'m not the scampering sort, sir.%SPEECH_OFF%}";
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
				}
			}
			if (s.ID == "F") {
				s.Text = "%terrainImage%{You look back at the company, then unsheathe your sword as you turn around. You swing it up and clip the crossbow and the man shoots it just over your shoulder. You drive the blade down the slat of wood and cut the cords of the weapon and stab the steel into the man\'s chest. He goes down easy and you hear men shout in the distance, but they\'re scared and scampering away. Thieves like this know not to fight with sellswords. Unfortunately, the crossbow bolt that went over your shoulder struck %hurtbro%. Who\'ll survive, but it is a garish wound.}";
			}
			if (s.ID == "H") {
				s.Text = "%terrainImage%As you approach the drunkard, a sharp whistle cracks across the path. You and the drunkard both look to see %thief% the thief standing there with a weapon to the back of another man.%SPEECH_ON%That feller\'s no nobleman, and probably aint no drunk neither. They\'re working together to either ambush travelers or threaten them with blackmail. They\'re robbers, sir.%SPEECH_OFF%You look back to see the man smiling nervously. He explains with suddenly sharpened clarity.%SPEECH_ON%We\'d no interest in robbing sellswords, sir, I-I-I swear I was about to explain myself soon as I sawr yer swords.%SPEECH_OFF%%thief% yells out, asking where the cache is. You look back at the man and tell him to hand over everything he\'s stolen. He nods and asks if you\'ll gut him if he refuses. You nod and tell him the gutting will come last, and by that point it\'ll be a relief. The man puts a little pep in his step.%SPEECH_ON%Yessir gotcha sir, right this way.%SPEECH_OFF%";
			}
		}

		this.m.Screens.push({
			ID = "I",
			Text = "%terrainImage%As you approach the drunkard, he immediately recognises %noble% and runs up sobbing. %SPEECH_ON%Cousin! Oh my gentile and cultured cousin, my favourite second cousin, you would not believe the outrageous injustice perpetrated against one\'s self!%SPEECH_OFF%You look on sceptically as the obviously drunken and slightly bedraggled nobleman continues %SPEECH_ON%I was due to be wed you see, to the love of my life. It was to the richest, wealthiest, prosperous, bountiful, most affluent, most.. well endowed..%SPEECH_OFF% The noble\'s mind wanders off, as if in fantasy. You prompt again and the speach continues somewhat more deflated %SPEECH_ON%Alas it was not to be, they discovered that {I am not a marquess from the border lands but only a viscount heir | My winnings at the table were not as grand as perhaps I had let on | My horrible father disowned me for having too much fun with wine and women}. They turned me out on the road, perhaps I could come on a travelling adventure with you? %SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
			{
				Text = "Welcome to the %companyname%.",
				function getResult( _event ) {
					this.World.getPlayerRoster().add(_event.m.Dude);
					this.World.getTemporaryRoster().clear();
					_event.m.Dude.onHired();
					_event.m.Dude = null;
					return 0;
				}
			},
			{
				Text = "A pauper is no cousin of mine",
				function getResult( _event ) {
					this.World.getTemporaryRoster().clear();
					_event.m.Dude = null;
					return 0;
				}
			}
			],
			function start( _event ) {
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx(["legend_noble_commander_background"]);
				::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.Addict);
				::Legends.Effects.grant(_event.m.Dude, ::Legends.Effect.Drunk);
				this.Characters.push(_event.m.Dude.getImagePath());
			}
		});
	}

	o.onUpdateScore = function() {
		if (!this.Const.DLC.Wildmen)
			return;

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
			return;

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.2)
			return;

		if (!this.World.Assets.getStash().hasEmptySlot())
			return;

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_servant = [];
		local candidates_thief = [];
		local candidates_noble = [];
		local candidates_other = [];

		foreach( bro in brothers ) {
			if (bro.getSkills().hasTrait(::Legends.Trait.Player) && bro.getBackground().getID() != "background.legend_commander_noble")
				continue;

			if (bro.getBackground().getID() == "background.servant" || bro.getBackground().getID() == "background.slave")
				candidates_servant.push(bro);
			else if (bro.getBackground().getID() == "background.thief")
				candidates_thief.push(bro);
			else if (bro.getBackground().getID() == "background.legend_commander_noble")
				candidates_noble.push(bro);
			else
				candidates_other.push(bro);
		}

		if (candidates_other.len() == 0)
			return;

		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_servant.len() != 0)
			this.m.Servant = candidates_servant[this.Math.rand(0, candidates_servant.len() - 1)];

		if (candidates_thief.len() != 0)
			this.m.Thief = candidates_thief[this.Math.rand(0, candidates_thief.len() - 1)];

		if (candidates_noble.len() != 0)
			this.m.Noble = candidates_noble[this.Math.rand(0, candidates_noble.len() - 1)];

		this.m.Score = 10;
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars ) {
		onPrepareVariables(_vars);
		_vars.push([
			"noble",
			this.m.Noble ? this.m.Noble.getNameOnly() : ""
		]);
	}

	local onClear = o.onClear;
	o.onClear = function () {
		onClear();
		this.m.Noble = null;
		this.m.Dude = null;
	}
})
