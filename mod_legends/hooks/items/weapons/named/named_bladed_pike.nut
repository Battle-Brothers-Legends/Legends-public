::mods_hookExactClass("items/weapons/named/named_bladed_pike", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ID = "weapon.named_bladed_pike";
	}
});
