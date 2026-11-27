::mods_hookExactClass("skills/traits/arena_fighter_trait", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Hearing a crowd chant your name can be addicting. This character is starting to enjoy the deadly fights of the arena and dispatching %their% opponents in a way that entertains the crowds.";
	}
});
