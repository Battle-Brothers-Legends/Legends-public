::mods_hookExactClass("skills/perks/perk_underdog", function (o) {
	// i'm ironside
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.Underdog);
	}
});
