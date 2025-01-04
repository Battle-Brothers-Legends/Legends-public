::mods_hookExactClass("items/helmets/barbarians/leather_helmet", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.addItemType(this.Const.Items.ItemType.Cultist);
	}
});
