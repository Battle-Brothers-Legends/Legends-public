::mods_hookExactClass("items/shields/greenskins/orc_light_shield", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Value = 100;
		this.m.Condition = 24;
		this.m.ConditionMax = 24;
		this.m.Block = 15;
		this.m.RegularDamage = 10;
		this.m.RegularDamage = 25;
	}

	o.getTooltip <- function () {
		local result = this.shield.getTooltip();
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any ranged damage taken by [color=%negative%]15%[/color]"
		});
		return result;
	}

	o.onUpdateProperties <- function (_properties) {
		this.shield.onUpdateProperties(_properties);
		_properties.DamageReceivedRangedMult *= 0.85;
	}
});
