this.legend_lose_fear_dark_trait_event <- this.inherit("scripts/events/event", {
	m = {
		Darkbro = null,
		Bravebro1 = null,
		Bravebro2 = null
	},
	function create()
	{
		this.m.ID = "event.legend_lose_fear_dark_trait";
		this.m.Title = "During camp...";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_33.png[/img]You come across %bravebro1% and %bravebro2% sitting with %darkbro%. The two mercenaries are listening to %darkbro% by the fire, regaling a story of how alps almost wiped out their hamlet as a boy. %SPEECH_ON%...and after that, I never really slept right. %bravebro1% and %bravebro2% both scratch their chins in unison. %SPEECH_ON%Right, but what good does it do you to cower in a corner while everyone else gets slaughtered?%SPEECH_OFF% %bravebro2% takes a sip from their mug. %SPEECH_ON%Fark, at that point I'd rather just off me'self than live with the guilt of doin' nothin'%SPEECH_OFF% %bravebro1% acknowledges the valiant words of wisdom from %bravebro2% and directs the conversation to something more meaningful. %SPEECH_ON%What we're sayin' is that was then this is now. You have steel in your hands and us at our back - if something is going to get out from the dark you may as well go down swinging with the rest of us...%SPEECH_OFF% %bravebro2%interjects again with a giggle. %SPEECH_ON%Yeah - and if I die I'm hauntin' both of 'yers!%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Growing up to become a real sellsword after all, are we?",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Darkbro.getImagePath());
				this.Characters.push(_event.m.Bravebro1.getImagePath());
				_event.m.Darkbro.getSkills().removeByID(::Legends.Trait.LegendFearDark);
				_event.m.Darkbro.getSkills().add(this.new(::Legends.Trait.Brave));
				this.List = [
					{
						id = 10,
						icon = "ui/traits/trait_fearofdark.png",
						text = _event.m.Darkbro.getName() + " is no longer afraid of the dark"
					},
					{
						id = 10,
						icon = "ui/traits/trait_icon_37.png",
						text = _event.m.Darkbro.getName() + " is now brave"
					}
				];
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates_darkbro = [];
		local candidates_brave = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 6 && bro.getSkills().hasSkill(::Legends.Trait.LegendFearDark))
			{
				candidates_darkbro.push(bro);
			}

			else if (bro.getSkills().hasSkill(::Legends.Trait.Brave) || bro.getSkills().hasSkill(::Legends.Trait.LegendFearless))
			{
				candidates_brave.push(bro);
			}
		}

		if (candidates_darkbro.len() == 0 || candidates_brave.len() < 2)
		{
			return;
		}

		this.m.Darkbro = candidates_darkbro[this.Math.rand(0, candidates_darkbro.len() - 1)];
		this.m.Bravebro1 = candidates_brave[0];
		this.m.Bravebro2 = candidates_brave[1];
		this.m.Score = candidates_darkbro.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"darkbro",
			this.m.Darkbro.getName()
		]);
		_vars.push([
			"bravebro1",
			this.m.Bravebro1.getName()
		]);
		_vars.push([
			"bravebro2",
			this.m.Bravebro2.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Darkbro = null;
		this.m.Bravebro1 = null;
		this.m.Bravebro2 = null;
	}

});

