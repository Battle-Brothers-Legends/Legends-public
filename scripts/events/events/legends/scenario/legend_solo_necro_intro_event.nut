this.legend_solo_necro_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_solo_necro_intro_event";
		this.m.IsSpecial = true;
		this.m.Screens.push({ //—
			ID = "A",
			Text = "[img]gfx/ui/events/event_29.png[/img]{The morning air is crisp and clean, the actors mumble their lines but the stumbling and jingling of bells has turned the play into a comedy. Your three patrons all howl and roil with laughter with every fumble and tumble upon the stage. Your playwright shuffles nervously next to you as you cast a smile their way, gently placing a small coin purse for their services in their lap. They feign a smile back — but you do not care. You lean closer and whisper to them. %SPEECH_ON%You have created something truly beautiful here today, it took many days of work but with my labour and your talent we could bring this masterpiece to the greatest cities across the land%SPEECH_OFF% The crowd jeers and one calls out. %SPEECH_ON%HIT \'IM! HIT \'IM!%SPEECH_OFF% The actor, accepts the improvisation and swings at the other with the wrong end of their staff, sending them tumbling off stage to the cheers, clapping and whistles of the crowd\n\n The playwright shifts nervously on the bench, fiddling with the coin purse. %SPEECH_ON%You know — when you came to me and said you could find me actors willing to work for cheap, this is not what I had in mind...%SPEECH_OFF% The crowd raises and claps their hands, the actor knocked from the stage clumsily rises to their feet and performs a mockery of a bow, the Jester\'s hat slipping from their matted hair and falling with a jingle on the damp grass. You applaud in a more conservative manner and suddenly snatch the bard\'s wrist. %SPEECH_ON%Don\'t be a fool. Together we\'ll make each other rich!%SPEECH_OFF% Your eyes seer in pain briefly, the redness of them reflecting back at you in the bard\'s own, dilated pupils. The actors spring to attention and lock onto the bard — ready to hunt at your command.\n\n The patrons gather their things and come to you, expressing their desire to stay on and help with the show.\n\n With them now in your employ you have new demands to meet, a playwright to keep paying and two very hungry mouths to keep feeding — perhaps it is time to find more lucrative work? You doubt anyone else would appreciate the kind of art you are creating here..\n...although, you could be proven wrong on that...}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A new pet, with many more on the way...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.logInfo("What's the fine for necrophilia in this part of Tamriel?");
				// this.World.FactionManager.makeZombiesFriendlyToPlayer(); //we ignore undead hunting contracts in the scenario file of this origin (legends_solo_necro_scenario)
			}
		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "The Greatest Show Across All The Land";
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});
