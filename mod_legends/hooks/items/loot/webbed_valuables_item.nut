::mods_hookExactClass("items/loot/webbed_valuables_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Within the thick webs of webknechts sometimes valuables that once belonged to their unfortunate victims can be discovered - if one is brave enough to search through the sticky deathtraps.";
	}
});
