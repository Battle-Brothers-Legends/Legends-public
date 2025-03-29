::mods_hookExactClass("items/shields/legendary/gilders_embrace_shield", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.IsIndestructible = true;
	}
});
