::mods_hookExactClass("skills/actives/darkflight", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Actives.onCreate(this, ::Legends.Active.Darkflight);
		this.m.Description = "Disapparate from your current location to quickly travel through the battlefield.";
	}
});
