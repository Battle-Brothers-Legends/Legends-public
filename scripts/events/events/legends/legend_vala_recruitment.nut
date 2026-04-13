this.legend_vala_recruitment <- this.inherit("scripts/events/event", {
	m = {
		Vala = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.legend_vala_recruitment";
		this.m.Title = "From the bushes...";
		this.m.Cooldown = 60 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_vala_recruitment.png[/img]The forests of the north are a primeval place, the span of a life is measured in months and the climate is a perpetual state of autumn or winter where the wildlife is as deadly as the weather. Walking through these forests is humbling — the trees here have outlived but the gods themselves, or so some would say.\nYour thoughts begin to wander further as the bridle path begins to feel endless and the trees curl inwards. The pressure builds in your head as you fall to the ground.\n The brush parts for a woman clad in furs holding a staff, focusing intently on you as you try to regain your balance. The noise stops and your mind clears. The woman speaks.%SPEECH_ON%Why are you here, outsider?%SPEECH_OFF%Her brow furrows and she hums, but her lips part again.%SPEECH_ON%I know what you are, and I know what you have done. Not just in this life — but the ones that have come before.%SPEECH_OFF%Her gaze lifts as she loses focus with you and looks down the path, deep in contemplation. The weight in your mind begins to lift as a tide ebbs before it comes crashing back. However, as she fixes her gaze with yours, the wave doesn\'t come crashing back. It is still there, at the back of your head — restrained like a warhound on a chain%SPEECH_ON%Something is changing outsider — something is coming that we can\'t stand alone and face. I do not care for your work, your motivations or hardships. I care about stopping the cataclysm of what is to come.%SPEECH_OFF% She purses her lips %SPEECH_ON%Shall we begin?%SPEECH_OFF%The humming stops — the pain lifts as fast as it came. Despite what the people of the south say, the grip of the old gods remains firm here.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Welcome to the %companyname%.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Vala);
						this.World.getTemporaryRoster().clear();
						_event.m.Vala.onHired();
						_event.m.Vala = null;
						return 0;
					}
				},
				{
					Text = "Keep your distance!",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Vala = null;
						return 0;
					}
				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Vala = roster.create("scripts/entity/tactical/player");
				if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
				{
					_event.m.Vala.getFlags().add("PlayerSkeleton");
					_event.m.Vala.getFlags().add("undead");
					_event.m.Vala.getFlags().add("skeleton");
				}

				_event.m.Vala.setStartValuesEx([
					"legend_vala_background"
				]);

				if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
				{
					::Legends.Traits.grant(_event.m.Vala, ::Legends.Trait.RacialSkeleton);
					::Legends.Traits.grant(_event.m.Vala, ::Legends.Trait.LegendFleshless);
				}
				else
				{
					::Legends.Traits.grant(_event.m.Vala, ::Legends.Trait.Loyal);
				}

				this.Characters.push(_event.m.Vala.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		// allow this event only for legion
		if (this.World.Assets.getOrigin().getID() != "scenario.legend_risen_legion")
			return;

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
			return;

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town = null;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach (t in towns) {
			if (t.getTile().getDistanceTo(playerTile) <= 7 && !t.isIsolatedFromRoads()) {
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
			return;

		if (playerTile.SquareCoords.Y < this.World.getMapSize().Y * 0.7)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local totalbrothers = 0;
		local brotherlevels = 0;
		foreach (bro in brothers)
		{
			if (bro.getBackground().getID() == "background.legend_vala")
				return;
			totalbrothers += 1;
			brotherlevels += bro.getLevel();
		}

		if (totalbrothers < 1 || brotherlevels < 30)
			return;

		this.m.Town = town;
		this.m.Score = 20.0 + ((brotherlevels / totalbrothers * 10.00) / this.Const.LevelXP.len());
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Vala = null;
		this.m.Town = null;
	}
});
