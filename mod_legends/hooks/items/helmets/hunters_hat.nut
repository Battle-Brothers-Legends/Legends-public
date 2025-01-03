::mods_hookExactClass("items/helmets/hunters_hat", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "A thick felt hat decorated with feathers as a hunter\'s trophy. Vision increased +1.";
		this.m.Condition = 35;
		this.m.ConditionMax = 35;
		this.m.Vision = 1;
	}
});
