::mods_hookExactClass("items/supplies/rice_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Provisions. Rice is cheap and readily available in the south. Spiced up with various herbs it becomes a tasty dish. Can be eaten in battle to provide up to 2 healing and fatigue recovery over ten turns, based on the amount remaining. Will be gradually used as provisions if left in the company stash.";
		this.m.Amount = 20.0;
	}
});