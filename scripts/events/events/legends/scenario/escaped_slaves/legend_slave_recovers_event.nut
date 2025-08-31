this.legend_slave_recovers_event <- this.inherit("scripts/events/event", {
	m = {
		Recovered = null
	},
	function create()
	{
		local EventText1 = "{There is a particular way that former slaves carry themselves, like a weight that they can never shed hangs upon their shoulders. | Life as a slave leaves its mark upon a person, inflicting scars both inside and out. | Many Indebted spend their lives forever debilitated, a despondent resignation of a life forever lost hovering over them like a cloud. | The frailty imparted to Indebted seems to never leave them, as though the scars refuse to fully heal. | Common amongst the slaves you\'ve known is a look of death, the vacant gaze of a quenched fire and a life lost.}";
		local EventText2 = " As you look at %recovered%, however, you see a face carrying no such signs. ";
		local EventText3 = "{The former slave\'s shoulders seem broader, posture straighter, head held higher than before. | %recovered%\'s gaze has a renewed purpose and clarity, filled with a fire you\'ve not seen there before. | Where before scars seemed to wrap around %recovered%\'s body, now they seem stretched and faded, unable to contain the might underneath. | %recovered%\'s stride is full of confidence and speed, the slump and weariness you used to see gone without a trace. | The mercenary\'s actions seem full of a boundless energy, as though weariness is the station of lesser folk and holds no grip over %recovered%.}";
		local EventText4 = "\n\nYou go over the man, noting his newfound vigor, and ask him how he\'s doing. He looks to the horizon at something you can\'t quite make out.";
		local EventText5 = "{%SPEECH_ON%You know I used to have a family, cap\'n? With a kid and everything. That life always seemed so far away, but close at the same time, you know? Like I couldn\'t get away from it, like there weren\'t no point to going on cause I\'d already done what folks ought to get done in life. I\'m sure they\'ve died or moved on, but I never could.%SPEECH_OFF%He pauses.%SPEECH_ON%I think I finally managed to, though. Something about being here, with the company, it\'s give me purpose again, made me feel like there\'s something still worth doing with my life.%SPEECH_OFF% | %SPEECH_ON%I still remember my first lashing. I\'d never known pain like that before. It never went away, really. I could always feel it, right there underneath the skin. It was... was like a manacle I couldn\'t see or touch or break, telling me I\'d been marked, that I\'d always be a slave.%SPEECH_OFF%Calloused hands rub at %recovered%\'s wrists.%SPEECH_ON%Lately, though, the feelin\'s started to fade. Hell, maybe I\'m just getting old, but I think something about being in the company has helped. I\'ve started believing it don\'t matter so much who I used to be, that I should just focus on what comes next.%SPEECH_OFF% | %SPEECH_ON%I still remember what it was like, before, you know... I remember feeling like I never had any choice. My life was laid out in front of me, and if I didn\'t like it, too bad. I suppose it was a slavery of a kind too, being bound to a life dictated by who\'s child you were or where you were born, and not anything you chose for yourself.%SPEECH_OFF%He spits.%SPEECH_ON%Well, I\'ve decided I\'ve had my fill of both. I used to think about returning to that life, but after my time in the company, I\'ve come to realize this is the closest to freedom I\'ve ever been.%SPEECH_OFF%}";
		local EventText6 = "%recovered% turns to you.%SPEECH_ON%It feels good, cap\'n.%SPEECH_OFF%";

		this.m.ID = "event.legend_slave_recovers";
		this.m.Title = "During camp...";
		this.m.Cooldown = 3.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]" + EventText1 + EventText2 + EventText3 + EventText4 + EventText5 + EventText6,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Glad you\'re feeling like yourself again.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local dude = _event.m.Recovered;
				this.Characters.push(dude.getImagePath());
				dude.getFlags().set("legend_recovered_slave", true);
				local rolls = [];
				rolls.push(this.Math.rand(8,12));
				rolls.push(this.Math.rand(4,8));
				rolls.push(this.Math.rand(4,8));
				rolls.push(this.Math.rand(4,8));

				local r = this.Math.rand(0, rolls.len() - 1);
				local healthRoll = rolls[r] + 2;
				rolls.remove(r);

				r = this.Math.rand(0, rolls.len() - 1);
				local fatigueRoll = rolls[r];
				rolls.remove(r);

				r = this.Math.rand(0, rolls.len() - 1);
				local resolveRoll = rolls[r] + 2;
				rolls.remove(r);

				r = this.Math.rand(0, rolls.len() - 1);
				local initiativeRoll = rolls[r] + 5;
				rolls.remove(r);


				this.List.push(::Legends.EventList.changeHitpoints(dude, healthRoll));
				this.List.push(::Legends.EventList.changeFatigue(dude, fatigueRoll));
				this.List.push(::Legends.EventList.changeResolve(dude, resolveRoll));
				this.List.push(::Legends.EventList.changeInitiative(dude, initiativeRoll));
				this.List.push(::Legends.EventList.changeMood(dude, 1.0, "Has found a sense of purpose in life"));

				dude.getSkills().update();
			}
		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() != "scenario.legend_escaped_slaves")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		local recovered_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 8 && bro.getBackground().getID() == "background.slave" && !bro.getFlags().has("legend_recovered_slave"))
			{
				recovered_candidates.push(bro);
			}
		}

		if (recovered_candidates.len() == 0)
		{
			return;
		}

		this.m.Recovered = recovered_candidates[this.Math.rand(0, recovered_candidates.len() - 1)];
		this.m.Score = recovered_candidates.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"recovered",
			this.m.Recovered.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Recovered = null;
	}

});

