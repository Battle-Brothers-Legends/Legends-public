::mods_hookExactClass("items/shields/named/named_bandit_kite_shield", function(o) {
	o.randomizeValues <- function () {
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.Block = 20;
		this.m.RegularDamage = 10;
		this.m.RegularDamage = 25;
		this.named_shield.randomizeValues();
	}

	o.getTooltip <- function () {
		local result = this.shield.getTooltip();
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any ranged damage taken by [color=%negative%]30%[/color]"
		});
		return result;
	}

	o.onUpdateProperties <- function (_properties) {
		this.shield.onUpdateProperties(_properties);
		_properties.DamageReceivedRangedMult *= 0.7;
	}
});
