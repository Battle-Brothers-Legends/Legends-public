::mods_hookExactClass("items/weapons/named/named_orc_cleaver", function(o) {

	// o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_cleaver_effect"];
	// o.m.EffectBounds <- [ [10, 20] ];

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	// o.getTooltip <- function ()
	// {
	// 	local result = this.named_weapon.getTooltip();
	// 	if (this.m.PossibleEffectIdx == 0)
	// 	{
	// 		result.push({
	// 			id = 12,
	// 			type = "text",
	// 			icon = "ui/icons/special.png",
	// 			text = "[color=%positive%]+" + this.m.EffectChanceOrBonus + "%[/color] Fatality Chance"
	// 		});
	// 	}
	// 	return result;
	// }
});
