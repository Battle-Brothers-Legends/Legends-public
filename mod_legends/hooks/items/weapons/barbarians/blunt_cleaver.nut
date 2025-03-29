::mods_hookExactClass("items/weapons/barbarians/blunt_cleaver", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This cleaver is heavy and blunt, but can still cause terrible wounds.";
	}
});
