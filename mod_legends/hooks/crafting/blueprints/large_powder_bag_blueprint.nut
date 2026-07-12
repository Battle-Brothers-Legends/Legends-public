::mods_hookExactClass("crafting/blueprints/large_powder_bag_blueprint", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Type = this.Const.Items.ItemType.Ammo;
		this.initSkills([::Legends.Professions.new(::Legends.Profession.LegendLeatherworking)]);
	}
});
