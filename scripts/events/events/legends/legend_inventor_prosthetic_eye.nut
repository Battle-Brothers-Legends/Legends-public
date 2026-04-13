this.legend_inventor_prosthetic_eye <- this.inherit("scripts/events/event", {
	m = {
		Inventor = null,
		Noeye = null
	},
	function create()
	{
		this.m.ID = "event.legend_inventor_prosthetic_eye";
		this.m.Title = "During camp...";
		this.m.Cooldown = 30 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_inventor_general.png[/img]As you plant your behind on the ground to get some rest, you notice %inventor% darting back and forth between the company, inspecting their eyes. Before long they come running up to you as well.\n%SPEECH_ON%Captain! May I have a look at your eyes?%SPEECH_OFF%Not actually waiting for you to reply, they hastily shift up close to you, grabbing your head and inspecting your eyes from every possible angle.\n%SPEECH_ON%Yes, yes... Yes! I think I\'ve figured out how to do it...%SPEECH_OFF%You\'re just about to ask him what on earth they\'re talking about.\n%SPEECH_ON%Do what, you might wonder. Well, you see, %noeye% over there has been feeling down ever since the incident and I haven\'t been able to stop thinking about his situation. I think I can help him!%SPEECH_OFF%They smile broadly while staring intently at you.\n%SPEECH_ON%I just need a few tools and some coin to make what I need — but this could be dangerous...%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Sounds good. Here\'s 600 crowns for the expenses. Take 5 tools from the cart.",
					function getResult( _event )
					{
							return this.Math.rand(1, 100) <= 85 ? "C" : "D";
					}
				},
				{
					Text = "We can\'t spare resources on this right now.",
					function getResult( _event )
					{
						return "E";
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Inventor.getImagePath());
				this.Characters.push(_event.m.Noeye.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/legend_inventor_general.png[/img]As you plant your behind on the ground to get some rest, you notice %inventor% darting back and forth between the company, inspecting their eyes. Before long they come running up to you as well.%SPEECH_ON%Captain! May I have a look at your eyes?%SPEECH_OFF%Not actually waiting for you to reply, they hastily shift up close to you, grabbing your head and checks your eyes from every possible angle.%SPEECH_ON%Yes, yes. Yes! I think I\'ve figured out how to do it.%SPEECH_OFF%You\'re just about to ask him what on earth he\'s talking about when he continues.%SPEECH_ON%Do what, you might wonder. Well, you see, %noeye% over there has been feeling down ever since the incident and I haven\'t been able to stop thinking about his situation. I think I can help him!%SPEECH_OFF%He smiles broadly while staring intently at you.%SPEECH_ON%For some mere coin I can procure what items I need.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Sounds good. Here\'s 600 crowns for the expenses.",
					function getResult( _event )
					{
							return "C";
					}
				},
				{
					Text = "We can\'t spare resources on this right now.",
					function getResult( _event )
					{
						return "E";
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Inventor.getImagePath());
				this.Characters.push(_event.m.Noeye.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/legend_inventor_general.png[/img]%inventor% runs off and starts working on.. whatever it is, so you lean back and let the resting begin. An hour or so passes by before %inventor% comes back, dragging %noeye% behind him.%SPEECH_ON%It\'s completed, captain. Watch.%SPEECH_OFF%The enthusiastic inventor faces %noeye%, tells him to lift his head up and then proceeds to stick something into his eye.%SPEECH_ON%Look at him! It fits perfectly. This new eye of his will surely bring his confidence back in no time!%SPEECH_OFF%Before you can say anything, %inventor% has already lept away and continued on some other project, %noeye% still standing in front of you looking very confused.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You look.. good?",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Inventor.getImagePath());
				this.Characters.push(_event.m.Noeye.getImagePath());
				this.World.Assets.addMoney(-600);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]600[/color] Crowns"
				});

				this.World.Assets.addArmorParts(-5);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_supplies.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]5[/color] Tools and Supplies"
				});

				local trait = ::Legends.Traits.grant(_event.m.Noeye, ::Legends.Trait.LegendProstheticEye, function (_trait) {
					this.List.push({
						id = 10,
						icon = _trait.getIcon(),
						text = _event.m.Noeye.m.Name + " receives a " + _trait.m.Name
					});
				}.bindenv(this));

				local missing_eye_bye = this.new("scripts/skills/injury_permanent/missing_eye_injury");
				_event.m.Noeye.getSkills().removeByID("injury.missing_eye");
				_event.m.Noeye.getSprite("permanent_injury_4").Visible = false;
				this.List.push({
						id = 10,
						icon = missing_eye_bye.getIcon(),
						text = _event.m.Noeye.m.Name + " no longer has a " + missing_eye_bye.m.Name
				});

				_event.m.Inventor.improveMood(2.0, "Created a " + trait.m.Name + " for " + _event.m.Noeye.m.Name);
				_event.m.Noeye.improveMood(2.0, "Received a " + trait.m.Name + " from " + _event.m.Inventor.m.Name);
			}
		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/legend_inventor_general.png[/img]%inventor% runs off and starts working on.. whatever it is, so you lean back and let the resting begin. An hour or so passes by before %inventor% comes back, dragging %noeye% behind him.%SPEECH_ON%It\'s completed, captain. Watch.%SPEECH_OFF%The enthusiastic inventor faces %noeye%, tells him to lift his head up and then proceeds to stick something into his eye.%SPEECH_ON%Look at him! It fits perfectly. This new eye of his will sure--%SPEECH_OFF%He gets interrupted by %noeye% who screams out in pain as he falls to the ground, bleeding heavily from his eye.%SPEECH_ON%Oh.. I.. seem to have miscalculated. No worries, I\'m sure he\'ll be fine!%SPEECH_OFF%The inventor slinks away out of sight as %noeye% goes silent, drifting into unconsciousness.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "What have you done?!",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Inventor.getImagePath());
				this.Characters.push(_event.m.Noeye.getImagePath());
				this.World.Assets.addMoney(-600);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]600[/color] Crowns"
				});

				this.World.Assets.addArmorParts(-5);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_supplies.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]5[/color] Tools and Supplies"
				});

				if (!_event.m.Noeye.getSkills().hasSkill("injury.brain_damage"))
				{
					local brain_damage_yum = this.new("scripts/skills/injury_permanent/brain_damage_injury");
					_event.m.Noeye.getSkills().add(brain_damage_yum);
					this.List.push({
							id = 10,
							icon = brain_damage_yum.getIcon(),
							text = _event.m.Noeye.m.Name + " suffers " + brain_damage_yum.m.Name
					});
				}

				_event.m.Inventor.worsenMood(this.Const.MoodChange.PermanentInjury, "Caused " + brain_damage_yum.m.Name + " in " + _event.m.Noeye.m.Name);
				_event.m.Noeye.worsenMood(this.Const.MoodChange.PermanentInjury, "Suffered " + brain_damage_yum.m.Name + " because of " + _event.m.Inventor.m.Name);
			}
		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/legend_inventor_general.png[/img]You tell %inventor% that the %companyname% has no resources to spare for such things at this time. The inventor tilts his head at an odd angle and shrugs before he takes off.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Maybe later?",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Inventor.getImagePath());
				this.Characters.push(_event.m.Noeye.getImagePath());
			}
		});
	}

	function onUpdateScore()
	{
		this.m.Score = 0;
		return;

		local brothers = this.World.getPlayerRoster().getAll();
		local inventor_candidates = [];
		local noeye_candidates = [];


		if (this.World.Assets.getMoney() < 2000 || this.World.Assets.getArmorParts() < 40)
		{
			return;
		}


		foreach (bro in brothers)
		{
			if (bro.getSkills().hasPerk(::Legends.Perk.LegendInventorAnatomy))
			{
				inventor_candidates.push(bro);
			}
		}
		if (inventor_candidates.len() < 1)
		{
			return;
		}
		else
		{
			this.m.Inventor = inventor_candidates[this.Math.rand(0, inventor_candidates.len() - 1)];
		}


		foreach (bro in brothers)
		{
			if (bro.getSkills().hasSkill("injury.missing_eye") && !bro.getSkills().hasTrait(::Legends.Trait.LegendProstheticEye))
			{
				noeye_candidates.push(bro);
			}
		}
		if (noeye_candidates.len() < 1)
		{
			return;
		}
		else
		{
			this.m.Noeye = noeye_candidates[this.Math.rand(0, noeye_candidates.len() - 1)];
		}


		this.m.Score = 5.0 + ((this.m.Inventor.getLevel() * 10.0) / this.Const.LevelXP.len());
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"inventor",
			this.m.Inventor.m.Name
		]);
		_vars.push([
			"noeye",
			this.m.Noeye.m.Name
		]);
	}

	function onDetermineStartScreen()
	{
		if (this.m.Noeye.getSkills().hasSkill("injury.brain_damage"))
			return "B";
		return "A";
	}

	function onClear()
	{
		this.m.Inventor = null;
		this.m.Noeye = null;
	}
});
