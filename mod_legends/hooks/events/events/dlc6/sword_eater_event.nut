::mods_hookExactClass("events/events/dlc6/sword_eater_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.Options[0].Text = "Impressive skill";
			}
		}
	}
})
