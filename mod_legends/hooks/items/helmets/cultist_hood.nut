::mods_hookExactClass("items/helmets/cultist_hood", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.addItemType(this.Const.Items.ItemType.Cultist);
	}
});
