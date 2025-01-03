::mods_hookExactClass("events/events/dlc4/deserter_origin_volunteer_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
	}
})
