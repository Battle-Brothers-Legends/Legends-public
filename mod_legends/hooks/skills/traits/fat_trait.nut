::mods_hookExactClass("skills/traits/fat_trait", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Excluded.extend([
			::Legends.Traits.getID(::Legends.Trait.LegendLight)
		]);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local ret = getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = "[color=%negative%]-10[/color] Initiative"
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Builds up [color=%negative%]2[/color] more fatigue for each tile traveled"
		});

		return ret;
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function (_properties) {
		onUpdate(_properties);
		_properties.MovementFatigueCostAdditional += 2;
		_properties.Initiative -= 10;
	}
});
