::mods_hookExactClass("items/helmets/barbarians/leather_helmet", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Cultist;
	}
});
