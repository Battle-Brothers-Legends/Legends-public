::mods_hookExactClass("items/weapons/named/named_orc_axe", function(o) {
	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_axe_effect"];
	o.m.EffectBounds <- [ [15, 35] ]

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3]
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
		//this.addSkill(this.new("scripts/skills/actives/legend_harvest_tree_skill"));
	}
});
