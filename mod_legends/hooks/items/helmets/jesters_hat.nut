::mods_hookExactClass("items/helmets/jesters_hat", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Variants = [::Math.rand(1,65)];
		this.m.Condition = 35;
		this.m.ConditionMax = 35;
		this.updateVariant();
	}

	o.getTooltip <- function() {
		local result = this.helmet.getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Makes enemies much more likely to attack you"
		});

		return result;
	}

	o.onUpdateProperties <- function ( _properties ) {
		this.helmet.onUpdateProperties(_properties);
		_properties.AggroMult *= 1.8; // 1.0 = normal aggression, 0.1 = minimal aggression
	}

	o.updateVariant <- function () {
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_jester_hat_" + variant;
		this.m.SpriteDamaged = "legendhelms_jester_hat_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_jester_hat_" + variant + "_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_jester_hat_" + variant + ".png";
	}
});
