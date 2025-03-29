::mods_hookExactClass("items/helmets/legendary/mask_of_davkul", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.addItemType(this.Const.Items.ItemType.Cultist);
	}
});
