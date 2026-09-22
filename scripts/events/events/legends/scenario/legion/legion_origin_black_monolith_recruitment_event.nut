this.legion_origin_black_monolith_recruitment_event <- this.inherit("scripts/events/events/legends/scenario/legion/legion_event", {
	m = {
		Dude = null
	},

	function create() {
		this.m.ID = "event.legion_origin_buried_castle";
		this.m.Title = "Near the black monolith..";
		this.m.Cooldown = 14.0 * ::World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_101.png[/img]{As you patrol near the imposing Monolith, a rhythmic hum fills your skull. Soon, you come across a lone sentry, dressed well and of some previously high stature. They stare into the distance, watching for an enemy that possibly never came. They pay no attention to you, instead fixing their gaze on the horizon. As you depart, you notice that they have, without question or further interaction, begun to follow you. | Nearing the Monolith, a sensation greets you that you have not felt in some time — as if you are drowning in warm water while everything around you freezes. With little warning, a legionary of some high statue approaches your band. Quickly producing a written set of transfer orders. You notice that the page is smudged and decaying in great flakes. The transfer order is for a legion wiped out before the calamity, and you can only make out a few words, including their name — %joiner%. Regardless, %joiner% falls into place without a word. | Nearing the Monolith, you feel a faint feeling of both dread and home, as if two sides of you are fighting within. Nearby, a tree shields a campfire. On investigation with weapons drawn, your legion discovers several other legionaries, all in various states of decay. One legionary, with little pause, rises from the campfire and joins the company, feet partially charred from the open fire.}",
			// Text = "[img]gfx/ui/events/event_73.png[/img]{As you patrol near the imposing monolith, you find a bone protruding from the weathered earth. Digging through a layer of ancient debris soon reveals %joiner%, a skeleton from the old empire. Seeing your cause is in the name of the Emperor, the warrior sticks to the oath and swears to serve %companyname%. | Looking out across the scarred landscape, you make out the shambling form of %joiner%, a former soldier of the Emperor, who agrees to join the %companyname%. | A legionnaire is standing motionless, with its weapon at the ready. As you approach, %joiner% hails the Emperor and is welcomed into the %companyname%. | %joiner% scouted out your party for a time before finding it safe to approach. All it took was the mention of the Emperor\'s name and the pact was made. %joiner% joins the company. | The Emperor surely watches over you as a soldier by the name of %joiner% joins the %companyname%. He states having but one purpose, to find you and ensure that this world sees all that awaits it. | %joiner% rises from the dirt as you approach, chanting the glory of the Emperor and his eternal gaze that surely watches over your party whole. The %companyname% takes %joiner% back into the service. | %joiner% calls down from the battlements of a half buried castle, hailing you in the name of the Emperor. %companyname% soon welcomes %joiner% back into the legion. | With a nod of a skinless head %joiner% claims to be at the speartip of the Emperor\'s purpose. You nod and welcome %joiner% into the %companyname%.  | %joiner% falls in with the company and there is little argument as to why. When asked where %joiner% came from, the answer is a gesture to the ruined fortifications nearby and the ancient battle to defend the Empire.}",
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
				_event.m.Dude.setStartValuesEx(::Const.CharacterLegionBackgroundsHIGH); //see: 'character_backgrounds' file
				
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
			if (v.getTypeID() == "location.black_monolith" && v.getTile().getDistanceTo(currentTile) < 5) {
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
