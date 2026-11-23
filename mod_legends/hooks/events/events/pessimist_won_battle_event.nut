::mods_hookExactClass("events/events/pessimist_won_battle_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_64.png[/img]Ever the downer, %pessimist% mopes around, wallowing in victory as good as any pissy pessimist could. %They_pessimist% throws a dismissive hand out.%SPEECH_ON%We have tasted victory and what of it? Our victory was their defeat, so it very well may be that one day someone else\'s victory is going to come at our expense, don\'t you see? Let us not put the cart in front of the horse lest the shadows of morrow sneak upon us whilst we bask in this supposedly glorious light.%SPEECH_OFF%A few sellswords tell %them_pessimist% to stop being such a prick, but %their_pessimist% brunt realism tempers the zeal of others.";
			}
		}
	}
});
