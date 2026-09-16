::mods_hookExactClass("items/helmets/cultist_hood", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.addItemType(::Const.Items.ItemType.Cultist);
	}
});
