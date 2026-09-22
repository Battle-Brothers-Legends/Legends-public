this.legion_origin_mass_grave_event <- this.inherit("scripts/events/events/legends/scenario/legion/legion_event", {
	m = {
		Dude = null
	},

	function create() {
		this.m.ID = "event.legion_origin_mass_grave";
		this.m.Title = "Near the ancient battle site...";
		this.m.Cooldown = 3.0 * ::World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_73.png[/img]{As %companyname% circles the battle site, a necromancer pours over the remains with a single legionary in tow. She notices you, and raises her hand as if to clutch your skull at a distance. Something twitches in the back of your primordial mind, but it ultimately lashes back at the pull of the witch. Confused, the necromancer tries again, but to even less effect. The legion is upon them now — the single enthralled legionary refuses to be commanded, instead staring blankly and watching your legion butcher the witch as a beaten dog observes the downfall of its abuser.\n\n One more life taken. One member stronger. | As you patrol near the ancient mass grave, you find a bone protruding from the weathered earth. Digging through a layer of ancient debris soon reveals %joiner%, a legionary from the old Empire. Seeing your cause is in the name of the Emperor, the warrior sticks to their oath and swears to serve %companyname%. | At the centre of the mass grave, a legionary stands sentinel over the site, still guarding a tattered and broken banner as if the battle still raged. As you approach, their gaze is drawn to your own banner — much more resplendent and complete than their own. Like a magpie chasing a coin, they quickly fall into line.}",
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
				_event.m.Dude.setStartValuesEx(::Const.CharacterLegionBackgroundsLOW);
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
			if (v.getTypeID() == "location.undead_mass_grave" && v.getTile().getDistanceTo(currentTile) < 5) {
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
