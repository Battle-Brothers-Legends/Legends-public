this.legion_origin_mass_grave_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.legion_origin_mass_grave";
		this.m.Title = "Near the ancient battle site...";
		this.m.Cooldown = 3.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({ //—
			ID = "A",
			Text = "[img]gfx/ui/events/event_73.png[/img]{As %companyname% circles the battle site, a necromancer pours over the remains with a single legionary in tow. She notices you, and raises her hand as if to clutch your skull at a distance. Something twitches in the back of your primordial mind, but it ultimately lashes back at the pull of the witch. Confused, the necromancer tries again, but to even less effect. The legion is upon them now — the single enthralled legionary refuses to be commanded, instead staring blankly and watching your legion butcher the witch as a beaten dog observes the downfall of its abuser.\n\n One more life taken. One member stronger. | As you patrol near the ancient mass grave, you find a bone protruding from the weathered earth. Digging through a layer of ancient debris soon reveals %joiner%, a legionary from the old Empire. Seeing your cause is in the name of the Emperor, the warrior sticks to their oath and swears to serve %companyname%. | At the centre of the mass grave, a legionary stands sentinel over the site, still guarding a tattered and broken banner as if the battle still raged. As you approach, their gaze is drawn to your own banner — much more resplendent and complete than their own. Like a magpie chasing a coin, they quickly fall into line.}",
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
				_event.m.Dude.setStartValuesEx(this.Const.CharacterLegionBackgroundsLOW);
				::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.RacialSkeleton);
				::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendFleshless);
				this.Characters.push(_event.m.Dude.getImagePath());

				local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
				local settlement = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Settlement);
				local oriental = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);
				local skellies = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Undead);

				foreach( n in nobles )
				{
					n.addPlayerRelation(-400.0, "Grew in company strength");
				}
				foreach( n in settlement )
				{
					n.addPlayerRelation(-400.0, "Grew in company strength");
				}
				foreach( n in oriental )
				{
					n.addPlayerRelation(-400.0, "Grew in company strength");
				}
				foreach( n in skellies )
				{
					n.addPlayerRelation(400.0, "Grew in company strength");
				}
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
		local nearSite = false;
		local currentTile = this.World.State.getPlayer().getTile();

		foreach( v in locations )
		{
			if (v.getTypeID() == "location.undead_mass_grave" && v.getTile().getDistanceTo(currentTile) < 5)
			{
				nearSite = true;
				break;
			}
		}

		if (!nearSite)
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

