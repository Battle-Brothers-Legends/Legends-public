::mods_hookExactClass("items/helmets/legendary/mask_of_davkul", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Cultist;
	}
});
