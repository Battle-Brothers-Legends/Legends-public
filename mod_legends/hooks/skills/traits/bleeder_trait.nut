::mods_hookExactClass("skills/traits/bleeder_trait", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Survivor),
			::Legends.Traits.getID(::Legends.Trait.Bleeder)
		];
	}

	o.getTooltip = function () {
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/turns_left.png",
				text = "Bleeding effects applied to this character last longer"
			}
		];
	}
});
