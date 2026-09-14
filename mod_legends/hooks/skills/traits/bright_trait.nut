::mods_hookExactClass("skills/traits/bright_trait", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Excluded.extend([
			::Legends.Traits.getID(::Legends.Trait.LegendPredictable)
		]);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local ret = getTooltip();
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Doesn't get as irritated while reading"
		});
		return ret;
	}
});
