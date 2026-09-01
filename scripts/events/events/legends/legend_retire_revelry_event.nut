this.legend_retire_revelry_event <- this.inherit("scripts/events/event", {
m = {
		retired_brother = null
	},
	function create()
	{// Conditions:
   // Have dismissed a bro recently that was level 5 or greater.
   // Said bro was paid a severance fee.
   // Bro had ANY injury, permanent/temporary.
		this.m.ID = "legend_retire_revelry";
		this.m.Title = "On the Road...";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;   // Feel free to edit MTTH or cooldown to what you think is appropriate. I think 25 days is fine for this event, but dont know how to make the chance to happen very quickly once you have retired a bro, or how the flags for that work. :bamboozling:
		this.m.Screens.push({
			ID = "A",
			Text = "While you had recently dismissed %retired_brother% from the company, you made clear before the men that there is no ill will towards the newly made retiree, a fact you demonstrate by allowing %them_retired_brother% to tag along until they get where they\'re going. After all, just because there\'s no place for them in the ranks anymore, it doesn\'t mean you cant help a brother on the road in these dangerous times. The once-sellsword walks along the wagon in dress so divorced from their battle garb, you could mistake them for a farmer, or particularly well-scarred city labourer. Some of the men strike up talk with the freshly civilian %retired_brother%, reflecting on their times both on and off the battlefield, sharing stories of no doubt exaggerated martial brilliance. \n\nSoon, the talk turns to laughter, and the pace of the caravan slows as more men peel off from their columns to join in the growing revelry with an old battle brother. %retired_brother% offers you an inviting smile, beckoning you to join the bubbling merriment as some of the company take the opportunity to break out skins of drink and fetch stools from the wagon. You could allow the men an evening of rest – allow them to say their proper goodbyes over a good story and drink... ",
			Image = "gfx/ui/events/event_16",
			List = [],
			Options = [
				{
					Text = "They can trade tall tales on the move, we have places to be.",
					function getResult( _event ) "B"
					{
						return "";
					}

				},
				{
					Text = "Pitch tents! We\'ll make tonight a sendoff worthy of %retired_brother%\'s name!",
					function getResult( _event ) "C" // Double check this section please. Not sure on the syntaxing, but these options should lead to new pages. 
					{
						return "";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.retired_brother != null)
				{
				this.Options.push({
					Text = "They can trade tall tales on the move, we have places to be.",
					function getResult( _event )
					{
						return "";
					}
				});
				}
				this.Options.push({
					Text = "Pitch tents! We\'ll make tonight a sendoff worthy of %retired_brother%\'s name!",
					function getResult( _event )
					{
						return "";
					}
				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "A sharp whistle catches the men\'s attention, and while you\'re happy to let the sellswords shoot the shit with %retired_brother%, you can\'t afford to halt the caravan to accommodate it. Most understand with a frown, and abandon their campaign of erecting a makeshift den of revelry, but %retired_brother% reassures them by launching into a saga of %their_retired_brother% glory and achievements in battle. You figure you must have been sleeping through the myriad scraps they recount, as you can\'t remember anything quite as impressive as the shit they\'re slinging. Regardless, it\'s good fun, and much of the company is chipping in with amendments to the increasingly fantastical reminiscing. A few whoops and jeers and miles of chatter later, and the mood seems to have dimmed, the sobering reality setting in for most still listening. \n\nAfter a brief lull, %retired_brother% puts a final stitch into the tapestry of their time with the company with some last remarks. \n\n%SPEECH_ON%You know lads, you\'re a good lot. Part of me is sad to see you go, another part of me is glad to get back home and finally be free of your criminal cooking. I don\'t know if I\'ll see most of you\'s again, but I want you to know – the time I spent with the %company_name% are like to be some of my most exciting, maybe even the best of this old fart\'s life.%SPEECH_OFF%\n\nA few men chuckle and call %retired_brother% an old sap with a playful knock on the shoulder; others walk on in a muted contemplation of their own time within the company, a fork in the road fast approaching. Soon enough, %retired_brother% tells you they can handle the way forward from here. Turning off down the fork, they see the men off with a tip of %their_retired_brother% hood. \n\n%SPEECH_ON%Later, lads.%SPEECH_OFF% ",
			Image = "gfx/ui/events/event_16",
			List = [],
			Options = [
				{
					Text = "Take care of yourself, %retired_brother%.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				// Rewards
        	function start(_event) {
							foreach (bro in ::World.getPlayerRoster().getAll()) {
					if (::Math.rand(1, 100) <= 50) {
						local entry = ::Legends.EventList.changeMood(bro, -0.5, "Felt the sadness of a retired brother's parting words.");
						if (bro.getMoodState() <= this.Const.MoodState.Neutral) this.List.push(entry);
          if (::Math.rand(1, 100) >= 50) {
            local entry = ::Legends.EventList.changeMood(bro, 0.5, "Bittersweetly saw an old brother off.");
            if (bro.getMoodState() <= this.Const.MoodState.Neutral) this.List.push(entry);
          }
          } //Sorry I may have butchered the indents and brackets lol.
		});
		this.m.Screens.push({
			ID = "C",
			Text = "With a wink and nod, the company descends into a chaotic flurry not unlike that born in an ambush. They rush to set up a fire, crack open drink, set stools, fetch food, and generally move with a vigour you wish you could direct on the battlefield, for surely no foe could stop you then. In no time, they\'ve erected tents and a den of bubbling revelry as the men whet their tongues on good drink and better talk. \n\nThe company surrounds %retired_brother%, drowning %them_retired_brother% with their boisterous and merry din. Soon, the now civilian brother takes the lead slinging stories and light-hearted jibes across the campfire. Perhaps if you were a more gullible man, you might believe half the nonsense they bounce between the men around them, each story bending the truth harder until you fear the very ground beneath you will snap under the weight of the dross being spewed. It\'s hard not to join with the merriment, the mood eventually reaching a fever pitch as the men sing and cheer %retired_brother%\'s name. You imagine how this might look to an outsider, a bizarre veneration of just one %person_retired_brother% in a cacophony of brew and sweat and laughter. One might see %them_retired_brother% as some conquering hero of old. To the company though, it just looks like a group of brothers seeing one off the way they know best.\n\nLater, when most of the men had fallen into drink induced stupors, %retired_brother% approaches you and speaks with a surprising clarity considering the recent festivities. \n\n%SPEECH_ON%Captain. You didn\'t need to do this for me.%SPEECH_OFF%\n\nYou dismiss the notion and assure them it was only fitting to see them off with a good time. %retired_brother% shakes your hand, thanks you, and tells you they\'ll make their way home from here. A faint smile and nod sees %them_retired_brother% off, and soon you\'re left with your thoughts, and the groaning of men already suffering the aftershocks of their battle with drink and festivity. Regardless, it\'s time to get back on the road. ",
			Image = "gfx/ui/events/event_24",
			List = [],
			Options = [
				{
					Text = "A fine time was had.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				// Rewards
      function start(_event) {
				foreach (bro in ::World.getPlayerRoster().getAll()) {;{
						local entry = ::Legends.EventList.changeMood(bro, 1.5, "Saw a retired brother off with a bang.");
        // Also, each bro in the company has a 20% chance of receiving the Hungover status for a day.  
				this.Options.push({
					Text = "A fine time was had.",
					function getResult( _event )
					{
						return 0;
					}
				});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local currentTile = this.World.State.getPlayer().getTile();
		if (!currentTile.HasRoad) return;
		local brothers = this.World.getPlayerRoster().getAll();
		local candidate_retired_brother = [];
		foreach( bro in brothers )
		{
		
	}

	function onPrepare()
	{
	}


	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.retired_brother = null;
	}

});
