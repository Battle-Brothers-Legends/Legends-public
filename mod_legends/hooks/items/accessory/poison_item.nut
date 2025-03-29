::mods_hookExactClass("items/accessory/poison_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A flask of poison used by goblins. Can be used to coat your weapons and arrowtips.";
	}
});