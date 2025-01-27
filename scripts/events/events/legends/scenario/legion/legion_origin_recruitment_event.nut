this.legion_origin_recruitment_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.legion_origin_recruitment";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 4.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_73.png[/img]{%joiner%, a wandering skeleton from the old empire, has come to join the %companyname%. The company gathers around, the stranger nods, they nod back, and just like that %joiner% is with you. | %joiner%, former soldier of the Emperor, has joined the %companyname%. | A legionnaire by the name of %joiner% arrives and hails the Emperor. %joiner% is welcomed into the %companyname%. | %joiner% stalked the company for a time before approaching you directly. All it took was the mention of the Emperor\'s name and the pact was made. %joiner% joins the company. | The Emperor surely watches over you as a soldier by the name of %joiner% joins the %companyname%. He states but one purpose, to find you and ensure that this world sees all that awaits it. | %joiner% walks beside you, chanting for the glory of the Emperor and his eternal gaze that surely watches over your party whole. The %companyname% takes %joiner% beneath its boney wing. | %joiner% finds the %companyname% on the march and joins its ranks as though no stranger at all. No one says a word and you simply direct %joiner% to the inventory where the purpose may gather teeth. | With a nod of a skinless head %joiner% claims to be at the speartip of the Emperor\'s purpose. You nod and welcome %joiner% into the %companyname%. | Marching in the name of the emperor, you were bound to find willing soldiers such as %joiner%. Keen on joining the company, in particular because you are in command of it, and more particularly due to a belief the Emperor has chosen you. | %joiner% bands with the company and there is little argument as to why. When asked where %joiner% came from, there is a shrug and talk of the old empire while nodding knowingly in your direction.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Yes, join us.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.getFlags().add("PlayerSkeleton");
				_event.m.Dude.getFlags().add("undead");
				_event.m.Dude.getFlags().add("skeleton");
				_event.m.Dude.setStartValuesEx(this.Const.CharacterBackgroundsAnimated);
				::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.RacialSkeleton);
				::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendFleshless);
				this.Characters.push(_event.m.Dude.getImagePath());
				local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);

				foreach( n in nobles )
				{
					n.addPlayerRelation(-400.0, "You are the undead, to be despised");
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.legend_risen_legion")
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		this.m.Score = 75;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"joiner",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

