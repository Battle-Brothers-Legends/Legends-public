::mods_hookExactClass("events/events/dlc4/crisis/undead_boy_who_cried_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "Accept1A", function (_screen) {
			local start = _screen.start;
			_screen.start <- function (_event) {
				start(_event);
				this.List.push(::Legends.EventList.changeMoralReputation(1, false));
			}
		});
		::Legends.Screens.hook(this, "Accept2A", function (_screen) {
			local start = _screen.start;
			_screen.start <- function (_event) {
				start(_event);
				this.List.push(::Legends.EventList.changeMoralReputation(1, false));
			}
		});
		::Legends.Screens.hook(this, "Accept3A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_97.png[/img]{Warily, you return to the boy\'s home. The second you open the door, you see the family enjoying a game of cards, so without further ado you turn around and grab the kid by his throat and slam him against the wall. You kick the door closed so no one can see. The father gets up and tells you that\'s his son you\'re manhandling. You tell the father to give you the switch used to beat his boy. Cautiously, he does as told. This time, you punish the kid yourself and when you\'re finished he\'s a welted, weeping mess.\n\nYou throw the switch at the crumpled child and tell the parents to pay you for your time, informing them that a \'sellsword never works for free.\'}";
		});
		::Legends.Screens.hook(this, "Accept3B", function (_screen) {
			local start = _screen.start;
			_screen.start <- function (_event) {
				start(_event);
				this.List.push(::Legends.EventList.changeMoralReputation(1, false));
			}
		});
	}
})
