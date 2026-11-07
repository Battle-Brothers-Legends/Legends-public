::mods_hookExactClass("items/helmets/decayed_closed_flat_top_with_sack", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Cultist;
	}
});
