::mods_hookExactClass("items/weapons/named/named_polemace", function(o) {

	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_mace_stagger_effect"];
	o.m.EffectBounds <- [ [15, 25] ];

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
	}

	o.getTooltip <- function ()
	{
		local result = this.named_weapon.getTooltip();
		if (this.m.PossibleEffectIdx == 0)
		{
			result.push({
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.EffectChanceOrBonus + "%[/color] Stagger Chance"
			});
		}
		return result;
	}
});
