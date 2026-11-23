::mods_hookExactClass("events/events/dlc6/desert_bugbite_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_161.png[/img]{While standing around looking at maps and taking inventory, %bitbro% suddenly yells out and falls over in the sand. %They_someguy% slaps at %their_someguy% legs and a black scorpion goes soaring. Another sellsword screams and chops the bug in half with the sort of ferocity you\'ve never even seen him use on the battlefield. %bitbro% clenches %their_someguy% teeth as %they_someguy% takes off %their_someguy% boots. It looks like someone jammed a nail into %their_someguy% ankle. %They_someguy% says %they're_someguy% feeling woozy, but it\'s not too serious.}";
		});
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.lone_wolf") {
			return;
		}
		onUpdateScore();
	}
});
