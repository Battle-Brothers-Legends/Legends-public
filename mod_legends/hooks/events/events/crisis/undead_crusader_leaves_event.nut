::mods_hookExactClass("events/events/crisis/undead_crusader_leaves_event", function(o) {
	o.onUpdateScore = function () {
		// no leaving alive!
	}
})
