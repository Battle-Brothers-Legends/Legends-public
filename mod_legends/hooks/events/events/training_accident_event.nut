::mods_hookExactClass("events/events/aging_swordmaster_paycut_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Options[0].Text = "At least %they_clumsyguy% didn't kill %themselves_clumsyguy%";
			_screen.start = function (_event) {
				this.Characters.push(_event.m.ClumsyGuy.getImagePath());
				local r = ::Math.rand(1, 6);
				local injury;

				if (r == 1) {
					this.Text = "[img]gfx/ui/events/event_19.png[/img]While training, %clumsyguy%, not being the most dexterous fellow, manages to hurt %themselves_clumsyguy% with %their_clumsyguy% own weapon.";
					injury = _event.m.ClumsyGuy.addInjury(this.Const.Injury.Accident1);
					this.List = [
						{
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.ClumsyGuy.getName() + " suffers " + injury.getNameOnly()
						}
					];
				} else if (r == 2) {
					this.Text = "[img]gfx/ui/events/event_34.png[/img]Traveling, you like to keep your men fresh with the occasional training exercise. Unfortunately, while practicing a riposte, %clumsyguy% managed to stick %themselves_clumsyguy% in the foot. The %person_clumsyguy% appears even more hurt by the embarrassment.";
					_event.m.ClumsyGuy.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.ClumsyGuy.getName() + " suffers light wounds"
					});
				} else if (r == 3) {
					this.Text = "[img]gfx/ui/events/event_34.png[/img]While doing inventory, you ask %clumsyguy% to carry over a quiver of arrows. The short, simple journey ends with the %person_clumsyguy% tripping over a rock and turning %themselves_clumsyguy% into a pincushion.";
					injury = _event.m.ClumsyGuy.addInjury(this.Const.Injury.Accident2);
					this.List = [
						{
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.ClumsyGuy.getName() + " suffers " + injury.getNameOnly()
						}
					];
				} else if (r == 4) {
					this.Text = "[img]gfx/ui/events/event_34.png[/img]You find a rather drunk %clumsyguy% nursing the side of %their_clumsyguy% face. %otherguy1% explains that the idiot tried to dance over a series of rocks, only to fall and bash %themselves_clumsyguy% in the face. Great.";
					injury = _event.m.ClumsyGuy.addInjury(this.Const.Injury.Accident3);
					this.List = [
						{
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.ClumsyGuy.getName() + " suffers " + injury.getNameOnly()
						}
					];
				} else if (r == 5) {
					this.Text = "[img]gfx/ui/events/event_34.png[/img]While %otherguy1% and %otherguy2% train, %clumsyguy% comes in between them, lecturing on how to do it properly while at the same time not watching where %they're_clumsyguy% going. A wayward wooden sword crosses paths with %their_clumsyguy% face and a moment later the idiot is unconscious.";
					injury = _event.m.ClumsyGuy.addInjury(this.Const.Injury.Accident3);
					this.List = [
						{
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.ClumsyGuy.getName() + " suffers " + injury.getNameOnly()
						}
					];
				} else {
					this.Text = "[img]gfx/ui/events/event_34.png[/img]It appears %clumsyguy% got a little too much to drink before partaking in today\'s sparring. As the story was explained to you, the drunkard mistook a tree for an enemy combatant. %They_clumsyguy% then, again as the story goes, proceeded to charge said tree, knocking %themselves_clumsyguy% out in the process.";
					_event.m.ClumsyGuy.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.ClumsyGuy.getName() + " suffers light wounds"
					});
				}
			}
		});
	}
});
