this.legion_origin_buried_castle_event <- this.inherit("scripts/events/events/legends/scenario/legion/legion_event", {
	m = {
		Dude = null
	},

	function create() {
		this.m.ID = "event.legion_origin_buried_castle";
		this.m.Title = "Near the buried castle...";
		this.m.Cooldown = 10.0 * ::World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_73.png[/img]{As you patrol near the ancient fortifications, a familiar feeling passes over you, as if you had been here before some time ago. The landscape has changed significantly, but some details remain in the distance. A legionary rises from the sunken structure, and falls almost immediately into formation. | As the legion picks its way through the rubble and old siege equipment, some remains strike you as familiar — you begin to make out the faces of family, friends and neighbours from the time before on the skeletons. As you reminisce, a legionary pulls themselves from a collapsed siege tower, making great effort to not damage their armour in the process — they fall into line with %companyname%. | Near the fortifications, a great battle has raged some time ago. Under the thick clumps of soil and wreathes of grass you can hear the bones cracking of ages past. In the distance, you see a lone legionary, rising and pulling a sword lodged between their ribcage. With a nod of a skinless head %joiner% claims to be at the speartip of the Emperor\'s purpose. You nod and welcome %joiner% into the %companyname%.}",
			// Text = "[img]gfx/ui/events/event_73.png[/img]{ As you patrol near the ancient fortifications, you find a bone protruding from the weather earth. Digging through a layer of ancient debris soon reveals %joiner%, a skeleton from the old empire. Seeing your cause is in the name of the emperor, the warrior sticks to the oath and swears to serve %companyname%. | Looking out across what was once a might battle site, you make out the shambling form of %joiner%, former soldier of the emperor, who agrees to join the %companyname%. | A legionaire is standing motionless, with weapon at the ready. As you approach %joiner% and hails the emperor, and is welcomed into the %companyname%. | %joiner% scouted out your party for a time before finding it safe to approach. All it took was the mention of the emperor\'s name and the pact was made. %joiner% joins the company. | the Emperor surely watches over you as a soldier by the name of %joiner% joins the %companyname%. Stating but one purpose, and it was to find you and ensure that this world sees all that awaits it. | %joiner% rises from the dirt as you approach, chanting for the glory of the emperor and his eternal gaze that surely watches over your party whole. The %companyname% takes %joiner% back into the service. | %joiner% calls down from the battlements of a half buried castle, hailing you in the name of the emperor. %companyname% soon welcomes %joiner% back to the legion. | With a nod of a skinless head %joiner% claims to be at the speartip of the emperor\'s purpose. You nod and welcome %joiner% into the %companyname%.  | %joiner% falls in with the company and there is little argument as to why. When asked where %joiner% came from, the answer is a gesture to the ruined fortifications, and the ancient battle to defend the empire.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Yes, join us.",
					function getResult(_event) {
						::World.getPlayerRoster().add(_event.m.Dude);
						::World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}
				}
			],

			function start(_event) {
				_event.m.Dude = ::World.getTemporaryRoster().create("scripts/entity/tactical/legend_player_legion");
				_event.m.Dude.setStartValuesEx(::Const.CharacterLegionBackgrounds); //see: 'character_backgrounds' file
				this.Characters.push(_event.m.Dude.getImagePath());

				foreach (n in ::World.FactionManager.getFactionsOfType(::Const.FactionType.NobleHouse)) {
					n.addPlayerRelation(-400.0, "Grew in company strength");
				}
				foreach (n in ::World.FactionManager.getFactionsOfType(::Const.FactionType.Settlement)) {
					n.addPlayerRelation(-400.0, "Grew in company strength");
				}
				foreach (n in ::World.FactionManager.getFactionsOfType(::Const.FactionType.OrientalCityState)) {
					n.addPlayerRelation(-400.0, "Grew in company strength");
				}
				foreach (n in ::World.FactionManager.getFactionsOfType(::Const.FactionType.Undead)) {
					n.addPlayerRelation(400.0, "Grew in company strength");
				}
			}
		});
	}

	function onUpdateScore() {
		if (!this.validateLegionEvent()) {
			return;
		}

		if (::World.getPlayerRoster().getSize() >= ::World.Assets.getBrothersMax()) {
			return;
		}

		local currentTile = ::World.State.getPlayer().getTile();
		local locations = ::World.EntityManager.getLocations();
		local nearSite = false;
		foreach (v in locations) {
			if (v.getTypeID() == "location.undead_buried_castle" && v.getTile().getDistanceTo(currentTile) < 5) {
				nearSite = true;
				break;
			}
		}
		if (!nearSite) {
			return;
		}

		this.m.Score = 75;
	}

	function onPrepareVariables(_vars) {
		_vars.push([
			"joiner",
			this.m.Dude.getName()
		]);
	}

	function onClear() {
		this.m.Dude = null;
	}
});
