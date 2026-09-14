::mods_hookExactClass("skills/actives/darkflight", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Description = "Disapparate from your current location and reappear on the other side of the battlefield.";
	}
});
