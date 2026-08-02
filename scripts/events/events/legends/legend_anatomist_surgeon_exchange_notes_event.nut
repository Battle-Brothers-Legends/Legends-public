this.legend_anatomist_surgeon_exchange_notes_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Surgeon = null
	},
	function create() {
		this.m.ID = "event.legend_anatomist_surgeon_exchange_notes";  //— \n |
		this.m.Title = "During camp...";
		this.m.Cooldown = 55.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_63.png[/img]At a break on the road, you find %anatomist% and %surgeon% in deep conversation about something. The conversations seems to have been going on for quite some time. %SPEECH_ON%...and that is the problem, you don't need to take samples with a knife — if you don't require the speciman whole, you can saw off what you need and stick it into a boling pot for a few hours. Aside from the consistency the results are mostly the same, and you don't spend hours peeling it off the bone.%SPEECH_OFF%%anatomist% crosses their arms and seems quite satisfied, while %surgeon% makes notes. %SPEECH_ON%In this case, you would only need roughly half a pound of ghoul flesh for this method — in turn meaning you could distil the gut lining with far less time and effort than before.%SPEECH_OFF% The Surgeon makes some final calculations based on the cut.%SPEECH_ON%So yes, I think your theroy on using ghoul gut lining as a subsitute for a bowstring would indeed work if you boiled it as sinew and made the correct cuts here, here... and, here.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "The first man to build their weapons from body parts gets a flogging.",
				getResult = @(_event) 0
			}],
			function start(_event)
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Surgeon.getImagePath());

				this.List.push(::Legends.EventList.changeMood(_event.m.Anatomist, 1.0, "Had some theories reaffirmed by " + _event.m.Surgeon.getName()));
				this.List.push(::Legends.EventList.changeMeleeSkill(_event.m.Anatomist, ::Math.rand(3, 5)));

				this.List.push(::Legends.EventList.changeMood(_event.m.Surgeon, 1.0, "Learned some new cutting techniques from " + _event.m.Anatomist.getName()));
				this.List.push(::Legends.EventList.changeBravery(_event.m.Surgeon, ::Math.rand(2, 4)));

				_event.m.Anatomist.getSkills().update();
				_event.m.Surgeon.getSkills().update();
			}
		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local Anatomist_candidates = [];
		foreach (bro in brothers)
		{
			if (::Legends.Backgrounds.has(bro, ::Legends.Background.Anatomist))
			{
				Anatomist_candidates.push(bro);
			}
		}

		if (Anatomist_candidates.len() == 0) {
			return;
		}

		local Surgeon_candidates = [];
		foreach (bro in brothers)
		{
			if (::Legends.Backgrounds.has(bro, ::Legends.Background.LegendSurgeon))
			{
				Surgeon_candidates.push(bro);
			}
		}

		if (Surgeon_candidates.len() == 0) {
			return;
		}

		this.m.Anatomist = Anatomist_candidates[::Math.rand(0, Anatomist_candidates.len() - 1)];
		this.m.Surgeon = Surgeon_candidates[::Math.rand(0, Surgeon_candidates.len() - 1)];
		this.m.Score = (anatomist_candidates.len() + Surgeon_candidates.len()) * 3;
	}

	function onPrepare() {}

	function onPrepareVariables(_vars)
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getNameOnly()
		]);
		_vars.push([
			"surgeon",
			this.m.Surgeon.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Surgeon = null;
	}

});


