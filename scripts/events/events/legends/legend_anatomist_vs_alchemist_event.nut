this.legend_anatomist_vs_alchemist_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Alchemist = null
	},
	function create() {
		this.m.ID = "event.legend_anatomist_vs_alchemist";  //— \n |
		this.m.Title = "During camp...";
		this.m.Cooldown = 55.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_63.png[/img]At a break on the march, you find %anatomist% and %alchemist% have set aside from the rest of the camp more than usual. You follow the assortment of dropped pans, vials and similar equipment to a tent staked at the periphery of camp. You enter the flap to a heady smell of fumes — of which both seem completely immunised.%SPEECH_ON%Captain! You're just in time!%SPEECH_OFF% The Alchemist grins and pours one liquid into another. Your anatomist is busy focusing on a simple apparatus, two vials oppose on another with a tube connecting the two. The neck of each vial has been securly wound several times over. %anatomist% makes some final notes as if they were %their% last — %alchemist% does the same and, with great precision, takes two steps backward. %anatomist% grimaces and upturns one vial onto the other in a quick but steady fashion. \n\nNothing happens, except the liquid now converges into the bottom vial and turns a threatening green hue. \n\nBoth exhale sharply, and exchange a solumn handshake with one another. The Anatomist finally notices your presence.%SPEECH_ON%Here scapegrace, you of all people should know what to do with this.%SPEECH_OFF% They hand you the vial and wipe their hands on their apron. You inquire briefly about what could've happened. %anatomist% shrugs and says not much, while %alchemist% in tandem says %SPEECH_ON%About fifty-fifty%SPEECH_OFF% You decide it may be best never to find out.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Right.",
				getResult = @(_event) 0
			}],
			function start(_event)
			{
				this.Characters.push(_event.m.anatomist.getImagePath());
				this.Characters.push(_event.m.alchemist.getImagePath());

				this.List.push(::Legends.EventList.changeMood(_event.m.Anatomist, 1.0, "Had a perplexing conundrum solved with help from " + _event.m.Alchemist.getName()));
				this.List.push(::Legends.EventList.changeBravery(_event.m.Anatomist, ::Math.rand(1, 4)));

				this.List.push(::Legends.EventList.changeMood(_event.m.Alchemist, 1.0, "Managed to help " + _event.m.Anatomist.getName()));
				this.List.push(::Legends.EventList.changeBravery(_event.m.Alchemist, ::Math.rand(1, 4)));

				_event.m.Anatomist.getSkills().update();
				_event.m.Alchemist.getSkills().update();

				this.List.extend(::Legends.EventList.addItems([
					::Const.World.Common.pickItem([
						[1, "misc/anatomist/apotheosis_potion_item"], //leaving like this for now because I'm thinking about adding more into this list later. - Luft
					], "scripts/items/")
				]), ::World.Assets.getStash());
			}
		});
	}

	function onUpdateScore() {
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

		if (Anatomist_candidates.len() == 0)
		{
			return;
		}

		local Alchemist_candidates = [];
		foreach (bro in brothers)
		{
			if (::Legends.Backgrounds.has(bro, ::Legends.Background.LegendAlchemist))
			{
				Alchemist_candidates.push(bro);
			}
		}

		if (Alchemist_candidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = Anatomist_candidates[::Math.rand(0, Anatomist_candidates.len() - 1)];
		this.m.Alchemist = Alchemist_candidates[::Math.rand(0, Alchemist_candidates.len() - 1)];
		this.m.Score = (Anatomist_candidates.len() + Alchemist_candidates.len()) * 3;
	}

	function onPrepare() {}

	function onPrepareVariables(_vars)
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getNameOnly()
		]);
		_vars.push([
			"alchemist",
			this.m.Alchemist.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Alchemist = null;
	}
});


