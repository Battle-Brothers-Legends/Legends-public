::mods_hookExactClass("items/accessory/bandage_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.StaminaModifier = -3;
	}
});