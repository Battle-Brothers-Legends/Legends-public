::mods_hookExactClass("skills/traits/strong_trait", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "This character is exceptionally muscled and capable of impressive feats of strength";
		this.m.Excluded.extend([
			::Legends.Traits.getID(::Legends.Trait.LegendLight)
		]);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local ret = getTooltip();
		ret.push({
			id = 16,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Offsets Weight Initiative penalties by [color=%positive%]10[/color]"
		});
		return ret;
	}
});
