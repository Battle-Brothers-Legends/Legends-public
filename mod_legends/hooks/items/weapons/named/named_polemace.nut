::mods_hookExactClass("items/weapons/named/named_polemace", function(o) {

	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_mace_stagger_effect"];
	o.m.EffectBounds <- [ [15, 25] ];

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.WeaponType = this.Const.Items.WeaponType.Mace | this.Const.Items.WeaponType.Polearm;
		this.setCategories("Mace/Polearm, Two-Handed");
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
				text = "[color=%positive%]+" + this.m.EffectChanceOrBonus + "%[/color] Stagger Chance"
			});
		}
		return result;
	}
});
