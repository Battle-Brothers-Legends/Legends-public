::mods_hookExactClass("items/helmets/cultist_leather_hood", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Cultist;
	}
});
