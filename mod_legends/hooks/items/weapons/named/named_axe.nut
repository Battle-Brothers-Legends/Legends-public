::mods_hookExactClass("items/weapons/named/named_axe", function(o) {
	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_axe_effect"];
	o.m.EffectBounds <- [ [10, 25] ]

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3,4,5,6]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
	}

	o.getTooltip <- function ()
	{
		local result = this.named_weapon.getTooltip();
		if (this.m.PossibleEffectIdx == 0)
		{
			result.push({
				id = 12,
				type = "text",
				icon = "ui/icons/armor_head.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.EffectChanceOrBonus + "%[/color] Damage to Head"
			});
		}
		return result;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		//::Legends.Actives.grant(this, ::Legends.Active.LegendHarvestTree);
	}
});
