this.legend_bros_cure_traumatized_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {
		Monk = null,
		Drunkard = null,
		Dervish = null,
		Traumatized = null
    },

    function create() {
        this.m.Type = "encounter.legend_bros_cure_traumatized";
        this.m.Name = ::Const.Strings.randomCampEncounterName();
		this.m.Cooldown = 30 * ::World.getTime().SecondsPerDay;
	    this.createScreens();
	}

    function createScreens() {
        this.m.Screens.push({
            ID = "Start",
            Title = "In camp...",
			Text = "[img]gfx/ui/events/event_12.png[/img]{%traumatized% is hesitant in combat with a violent outburst each time someone points it out. It\'s quickly becoming impossible to talk to %them_traumatized% without walking on eggshells. | Feet always pointing towards the exit and a weak point in the shield wall, %traumatized% is becoming a liability in a fight. | The sellswords pretend not to hear, but %traumatized% is often found quietly sobbing in a far off corner in camp. Daily life becoming a burden for the damaged mercenary. | %traumatized% can barely hold a weapon, the shakes appearing each time %their_traumatized% sword arm needs to strike. Your mercenaries quickly fill the gaps, but you can tell they\'re becoming annoyed. | Skipping meals and waning physically, %traumatized% is a shell of the %person_traumatized% %they_traumatized% used to be.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "There is nothing I could do for %them_traumatized%",
					function getResult( _event )
					{
						return 0;
					}
				}
			]
			function start( _event )
			{
				if (_event.m.Drunkard != null)
				{
					this.Options.push({
						Text = "%drunkard%, I need you to fix this issue.",
						function getResult( _event )
						{
							return "Drunkard";
						}
					});
				}
				if (_event.m.Monk != null)
				{
					this.Options.push({
						Text = "%monk%, talk to %them_traumatized%.",
						function getResult( _event )
						{
							return "Monk";
						}
					});
				}
				if (_event.m.Dervish != null)
				{
					this.Options.push({
						Text = "Care to share some of that inner peace, %dervish%?",
						function getResult( _event )
						{
							return "Dervish";
						}
					});
				}
			}
		});
		this.m.Screens.push({
			ID = "Drunkard",
			Text = "[img]gfx/ui/events/event_23.png[/img]The drunkard gives a thumbs up, then with a sheepish smile aproaches %traumatized% to plant a firm arm over %their_traumatized%\'s shoulder. %traumatized% looks assaulted by the slurring and the friendliness, but also has nowhere to run. %They_traumatized% gives you a pleading look before being dragged away.\n\nYou hear little of them for days. What you do notice is that %traumatized% seems always drunk now. Not just drunk — utterly wasted, shadowing %drunkard%\'s every step like a confused apprentice.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Great, there\'s more of them. | I wonder what\'ll happen when the ale runs dry.}",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Drunkard.getImagePath());
				this.Characters.push(_event.m.Traumatized.getImagePath());
				::Legends.Traits.grant(_event.m.Traumatized, ::Legends.Trait.Drunkard);
				_event.m.Drunkard.improveMood(1.0, "Got a new drinking buddy");
				if (_event.m.Drunkard.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Drunkard.getMoodState()],
						text = _event.m.Drunkard.getName() + this.Const.MoodStateEvent[_event.m.Drunkard.getMoodState()]
					});
				}
			}
		});
		this.m.Screens.push({
			ID = "Monk",
			Text = "[img]gfx/ui/events/event_40.png[/img]You leave to tend to your tasks while the holy %person_monk% talks to %traumatized%. When you return to check on them the camp fire is already ablaze and the two are deep in conversation. Well more like a monologue because it\'s just %monk% listening with sympathy and fear. The crackle of the fire masks the whispered words while %person_monk%\'s tired eyes keep intently on the victim. You\'re curiosity almost gets the better of you and you want to listen in, but ultimately decide it\'s better to not interfere. Over the next few days %traumatized% is looking chipper, a spring to their step that was there before the incident. On the other hand the holy %person_monk% seems drained and devoid of life. It\'s almost as if the positions are exchanged.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "The old gods still offer guidance, but at what price?",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
				this.Characters.push(_event.m.Traumatized.getImagePath());
				::Legends.Effects.grant(_event.m.Monk, ::Legends.Effect.Afraid, function(_effect) {
					_effect.setHealChance(10);
				}.bindenv(this));
				local traumatized = this.new("scripts/skills/injury_permanent/traumatized_injury");

				_event.m.Trautmatized.improveMood(2.0, "Is no longer traumatized");
				_event.m.Monk.worsenMood(2.0, "Has heard terrible things and left with shaken faith");
				_event.m.Traumatized.getSkills().removeByID(traumatized.getID());
				this.List.push({
						id = 10,
						icon = traumatized.getIcon(),
						text = "Is no longer traumatized"
				});
				this.List.push({
					id = 10,
					icon = effect.getIcon(),
					text = _event.m.Monk.getName() + " is afraid"
				});
				if (_event.m.Traumatized.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Traumatized.getMoodState()],
						text = _event.m.Traumatized.getName() + this.Const.MoodStateEvent[_event.m.Traumatized.getMoodState()]
					});
				}
				if (_event.m.Monk.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Monk.getMoodState()],
						text = _event.m.Monk.getName() + this.Const.MoodStateEvent[_event.m.Monk.getMoodState()]
					});
				}
			}
		});
		this.m.Screens.push({
			ID = "Dervish",
			Text = "[img]gfx/ui/events/event_40.png[/img]The Dervish aproaches the broken %person_traumatized% and the two spend some time talking. From a distance the conversation is difficult, %traumatized% constantly looking for a way out. But then %they_traumatized% stops %themselves_traumatized% and looks %dervish% dead in the eyes hearing something that you can\'t make out from this distance.\n\nThe next day as you exit your quarters you see the two sitting crosslegged on the ground with closed eyes. The day after you see them practicing a foreign dance. And as the days pass you see %traumatized%, not looking normal or happy, but rather content, but also found begging around camp, despite %their_traumatized%\'s wages. Furious you aproach the Dervish for answers.%SPEECH_ON%%They_traumatized% has taken a vow of austerity to achieve salvation. It is a necessary sacrifice.%SPEECH_OFF%You ask how much money do they have to beg to achieve this salvation and the southerner just shrugs.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I wonder what they teach them in that desert.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dervish.getImagePath());
				this.Characters.push(_event.m.Traumatized.getImagePath());

				this.Characters.push(_event.m.Traumatized.getImagePath());
				local bg = this.new("scripts/skills/backgrounds/beggar_background");
				bg.m.IsNew = false;
				_event.m.Dude.getSkills().removeByID(_event.m.Traumatized.getBackground().getID());
				_event.m.Dude.getSkills().add(bg);
				_event.m.Dude.getBackground().m.RawDescription = "%name% has taken a vow of austerity and become a beggar willingly.";
				_event.m.Dude.getBackground().buildDescription(true);
			}
		});
	}

	function onPrepareVariables (_vars) {
		_vars.push([
			"monk",
			this.m.Monk.getName()
		]);
		_vars.push([
			"drunkard",
			this.m.Monk.getName()
		]);
		local title = this.m.Monk.getGender() == 0 ? "the Monk" : "the Nun";
		_vars.push([
			"monktitle",
			title
		]);
		_vars.push([
			"traumatized",
			this.m.Traumatized.getName()
		]);
		this.Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Traumatized.getGender(), "traumatized");
		this.Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Monk.getGender(), "monk");
		this.Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Drunkard.getGender(), "drunkard");
		this.Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Dervish.getGender(), "dervish");
	}

	function isValid(_camp) {
		if (::World.getPlayerRoster().getSize() >= 3)
			return false;


		local bros = this.World.getPlayerRoster().getAll();
		local randomBros = [];
		foreach (bro in bros)
		{
			if (bro.getSkills().hasSkill("injury.traumatized"))
			{
				this.m.Traumatized = bro;
			}
			else if (bro.getBackground().getID() == "background.monk")
			{
				this.m.Monk = bro;
			}
			else if (bro.getSkills().hasTrait(::Legends.Trait.Drunkard))
			{
				this.m.Drunkard = bro;
			}
		}
		if (this.m.Traumatized == null)
			return false;

		if ((this.m.Drunkard == null && !this.m.Traumatized.getSkills().hasTrait(::Legends.Trait.Drunkard)) || this.m.Monk == null)
			return false;

		return !this.isOnCooldown();
	}

	function onClear()
	{
		this.m.Monk = null;
		this.m.Drunkard = null;
		this.m.Traumatized = null;
	}
});
