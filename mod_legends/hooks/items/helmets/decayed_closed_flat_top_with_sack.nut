::mods_hookExactClass("items/helmets/decayed_closed_flat_top_with_sack", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.addItemType(this.Const.Items.ItemType.Cultist);
	}
});
