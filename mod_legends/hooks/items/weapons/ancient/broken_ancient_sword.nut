::mods_hookExactClass("items/weapons/ancient/broken_ancient_sword", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
	}

});
