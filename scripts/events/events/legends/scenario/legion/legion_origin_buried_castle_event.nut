this.legion_origin_buried_castle_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.legion_origin_buried_castle";
		this.m.Title = "Near the buried castle...";
		this.m.Cooldown = 10.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({ //—
			ID = "A",
			Text = "[img]gfx/ui/events/event_73.png[/img]{As you patrol near the ancient fortifications, a familiar feeling passes over you, as if you had been here before some time ago. The landscape has changed significantly, but some details remain in the distance. A legionary rises from the sunken structure, and falls almost immediately into formation. | As the legion picks its way through the rubble and old siege equiment, some remains strike you as familiar — you begin to make out the faces of family, friends and neighbours from the time before on the skeletons. As you reminisce, a legionary pulls themselves from a collapsed siege tower, making great effort to not damage their armour in the process — they fall into line with %companyname%. | Near the fortifications, a great battle has raged some time ago. Under the thick clumps of soil and wreathes of grass you can hear the bones cracking of ages past. In the distance, you see a lone legionary, rising and pulling a sword lodged between their ribcage. With a nod of a skinless head %joiner% claims to be at the speartip of the Emperor\'s purpose. You nod and welcome %joiner% into the %companyname%.}",
			// Text = "[img]gfx/ui/events/event_73.png[/img]{ As you patrol near the ancient fortifications, you find a bone protruding from the weather earth. Digging through a layer of ancient debris soon reveals %joiner%, a skeleton from the old empire. Seeing your cause is in the name of the emperor, the warrior sticks to the oath and swears to serve %companyname%. | Looking out across what was once a might battle site, you make out the shambling form of %joiner%, former soldier of the emperor, who agrees to join the %companyname%. | A legionaire is standing motionless, with weapon at the ready. As you approach %joiner% and hails the emperor, and is welcomed into the %companyname%. | %joiner% scouted out your party for a time before finding it safe to approach. All it took was the mention of the emperor\'s name and the pact was made. %joiner% joins the company. | the Emperor surely watches over you as a soldier by the name of %joiner% joins the %companyname%. Stating but one purpose, and it was to find you and ensure that this world sees all that awaits it. | %joiner% rises from the dirt as you approach, chanting for the glory of the emperor and his eternal gaze that surely watches over your party whole. The %companyname% takes %joiner% back into the service. | %joiner% calls down from the battlements of a half buried castle, hailing you in the name of the emperor. %companyname% soon welcomes %joiner% back to the legion. | With a nod of a skinless head %joiner% claims to be at the speartip of the emperor\'s purpose. You nod and welcome %joiner% into the %companyname%.  | %joiner% falls in with the company and there is little argument as to why. When asked where %joiner% came from, the answer is a gesture to the ruined fortifications, and the ancient battle to defend the empire.}",
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
				_event.m.Dude.setStartValuesEx(this.Const.CharacterLegionBackgrounds); //see: 'character_backgrounds' file
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

		local currentTile = this.World.State.getPlayer().getTile();

		//see 'static_fucntions' ::Legends.S.humansOnly for more details.
		if (::World.Assets.getOrigin().getID() != "scenario.legend_risen_legion") {
			return;
		}

		local hasSkeleton = false;
		foreach (bro in ::World.getPlayerRoster().getAll()) {
    		if (bro.getFlags().has("PlayerSkeleton")) {
				hasSkeleton = true;
				break;
			}
		}

		if (!hasSkeleton) {
    		return; 
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}


		local locations = this.World.EntityManager.getLocations();
		local nearSite = false;
		foreach( v in locations )
		{
			if (v.getTypeID() == "location.undead_buried_castle" && v.getTile().getDistanceTo(currentTile) < 5)
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

