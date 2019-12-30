this.legion_origin_mass_grave_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.legion_origin_mass_grave";
		this.m.Title = "Near the ancient battle site...";
		this.m.Cooldown = 7.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_73.png[/img]{ As you patrol near the ancient battle field, you find a bone protruding from the weather earth. Digging through a layer of ancient debris soon reveals %joiner%, a skeleton from the old empire. Seeing your cause is in the name of the emporer, the warrior sticks to the oath and swears to serve %companyname%. | Looking out across what was once a might battle site, you make out the shambling form of %joiner%, former soldier of the emporer, who agrees to join the %companyname%. | A legionaire is standing motionless, with weapon at the ready. As you approach %joiner% and hails the emporer, and is welcomed into the %companyname%. | %joiner% scouted out your party for a time before finding it safe to approach. All it took was the mention of the emporer\'s name and the pact was made. %joiner% joins the company. | the Emporer surely watches over you as a soldier by the name of %joiner% joins the %companyname%. Stating but one purpose, and it was to find you and ensure that this world sees all that awaits it. | %joiner% rises from the dirt as you approach, chanting for the glory of the emporer and his eternal gaze that surely watches over your party whole. The %companyname% takes %joiner% beneath its boney wing. | %joiner% finds the %companyname% on the march and joins its ranks as though no stranger at all. No one says a word and you simply direct %joiner% to the inventory where the purpose may gather teeth. | With a nod of a skinless head %joiner% claims to be at the speartip of the emporer\'s purpose. You nod and welcome %joiner% into the %companyname%.  | %joiner% falls in with the company and there is little argument as to why. When asked where %joiner% came from, the answer is a gesture to the ground beneath you, and talk of an ancient battle for the empire.}",
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
				
				_event.m.Dude.getTags().add("PlayerSkeleton");
				_event.m.Dude.getTags().add("undead");
				_event.m.Dude.getTags().add("skeleton");
				_event.m.Dude.add(this.new("scripts/skills/racial/skeleton_racial"));
				_event.m.Dude.add(this.new("scripts/skills/injury_permanent/legend_fleshless"));
				_event.m.Dude.setStartValuesEx(this.Const.CharacterBackgroundsAnimated);
				this.Characters.push(_event.m.Dude.getImagePath());

			}

		});
	}

	function onUpdateScore()
	{


		if (this.World.Assets.getOrigin().getID() != "scenario.legend_risen_legion")
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local locations = this.World.EntityManager.getLocations();

		foreach( v in locations )
		{
			if (v.getTypeID() == "location.undead_mass_grave")
			{
				if (v.getTile().getDistanceTo(currentTile) > 5)
				{
					return;
				}
			}
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

