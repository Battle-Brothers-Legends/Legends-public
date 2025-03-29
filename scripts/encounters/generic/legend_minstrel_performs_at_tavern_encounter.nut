this.legend_minstrel_performs_at_tavern_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {
		Minstrel = null
    },
    function create() {
        this.createScreens();
        this.m.Type = "encounter.legend_minstrel_performs_at_tavern_encounter";
        this.m.Name = "Minstrel wants to perform.";
    }

    function createScreens() {
        this.m.Screens.extend([
		{
            ID = "Task",
            Title = "Strolling around the city...",
            Text = "Wandering around the town you spot your company gathered around a crackling fire. The familiar sounds of your mercenaries—laughing, drinking, and sharpening blades. %minstrel%, a quiet figure strumming his lute by the fire\'s edge, he spots you and approaches. %SPEECH_ON%Tonight, I\'d like to perform.%SPEECH_OFF% You look up, raising an eyebrow. %SPEECH_ON%Perform? For who?%SPEECH_OFF% %minstrel% smiles at you. %SPEECH_ON%The tavern, the locals could use some cheering up. And the coin\'s always good.%SPEECH_OFF%",
            Image = "",
            List = [],
			Characters = [],
            Options = [
            {
                Text = "Go",
                function getResult(_event) {
					local r = ::Math.rand(0, 3);
					if (r != 0)
                    	return "Success";
					return "Failed";
                }
            },
            {
                Text = "Not now",
                function getResult(_event) {
                    return 0;
                }
            }
            ],
            function start(_event) {
				this.Characters.push(_event.m.Minstrel.getImagePath());
			}
        },
		{
            ID = "Success",
            Title = "At the tavern",
            Text = "The tavern is packed with locals, the air thick with the smell of roasted meat and spilled ale. You stand near the door, watching as %minstrel% steps onto the makeshift stage, lute in hand. The chatter dies down, and with a few practiced strums, begins. The song fills the room—rich, smooth, and powerful—telling tales of heroic deeds of your company. The crowd listens, some swaying to the melody, others caught in the enchantment of his words. By the time the last note rings out, the room erupts into applause. The barkeep, a burly man with a wide grin, slaps a coin on the table, nodding at you. %SPEECH_ON%That was worth more than a tankard of ale!%SPEECH_OFF% %minstrel% smiles, accepting the praise with humility, and you watch as the tavern fills with laughter and cheer, the energy of the crowd lighter than it had been all day.",
            Image = "",
            List = [],
            Options = [
            {
                Text = "Well done %minstrel%!",
                function getResult(_event) {
                    return 0;
                }
            }
            ],
            function start(_event) {
				::World.Assets.addMoney(250);
				this.List.push({
					id = 1,
					icon = "ui/icons/money.png",
					text = "You gain 250 crowns."
				})
			}
        },
		{
			ID = "Failed",
			Title = "At the tavern",
			Text = "%minstrel%\'s lighthearted tune fills the tavern, but is quickly interrupted by a drunken patron. %SPEECH_ON%Is this a tavern or a bloody opera?%SPEECH_OFF% Laughter erupts from his table, and soon insults start flying. The minstrel keeps playing, but the jeers escalate.\n Suddenly, one man stumbles up, shoving another. %SPEECH_ON%Shut it!%SPEECH_OFF% he bellows, and before you know it, a full-blown fistfight erupts. Chairs crash, mugs shatter, and the room is chaos. You draw your blade, ready to end it, while %minstrel% steps back, shaking head with a grin. %SPEECH_ON%Next time, I\'ll sing quieter.%SPEECH_OFF% You and your men move in to break it up.",
			Image = "",
			List = [],
			Options = [
			{
				Text = "Tough crowd.",
				function getResult(_event) {
					return 0;
				}
			}
			],
			function start(_event) {
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers ) {
					if (this.Math.rand(1, 100) <= 33) {
						bro.improveMood(0.5, "Had a good brawl");

						if (bro.getMoodState() > this.Const.MoodState.Neutral) {
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}

					if (this.Math.rand(1, 100) <= 33) {
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = bro.getName() + " suffers light wounds"
						});
					}
				}
			}
		}]);
    }

    function isValid(_settlement) {
		if (!_settlement.hasBuilding("building.tavern"))
			return false;

		local brothers = ::World.getPlayerRoster().getAll();
		if (brothers.len() < 3)
			return false;

		local candidates = [];
		foreach(bro in brothers) {
			if (bro.getBackground().getID() == "background.minstrel")
				candidates.push(bro);
		}
		if (candidates.len() == 0)
			return false;

		this.m.Minstrel = candidates[::Math.rand(0, candidates.len() - 1)];

        return !isOnCooldown();
    }

	function onPrepareVariables( _vars ) {
		_vars.push(["minstrel", this.m.Minstrel != null ? this.m.Minstrel.getNameOnly() : ""]);
	}

	function onClear() {
		this.m.Minstrel = null;
	}
})
