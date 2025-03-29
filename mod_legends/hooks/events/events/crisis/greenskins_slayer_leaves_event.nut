::mods_hookExactClass("events/events/crisis/greenskins_slayer_leaves_event", function(o) {
	o.onUpdateScore = function () {
		// no leaving alive!
	}
})
