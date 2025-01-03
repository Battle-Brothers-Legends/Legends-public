::mods_hookExactClass("events/events/walkers_bond_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_16.png[/img]{Folk of the road, %walker1% and %walker2% share stories of their travels with one another. You don\'t really understand what\'s so rich about walking about, but the two do bond over their tales and that\'s good enough for you. | %walker1% and %walker2% have seen much of the world. They\'ve spent years on the road, and now they\'re telling tales of those years to one another.\n\nTheir appreciation for each other rises, and your appreciation for not listening to boring travel stories also increases. | Most people find the task of walking about to be pretty simple, but those who do little else but walk about find more interest in the affair. Unsurprisingly, %walker1% and %walker2% have come to bond of their tales of... walking around.}";
			}
		}
	}
})
