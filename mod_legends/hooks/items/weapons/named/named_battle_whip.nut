::mods_hookExactClass("items/weapons/named/named_battle_whip", function(o) {

	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_whip_bleed_effect", "scripts/skills/effects/legend_named_whip_feint_effect"];
	o.m.EffectBounds <- [ [30, 50], [20, 35] ]

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Categories = "Cleaver, Whip, One-Handed";
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Cultist;
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.EffectChanceOrBonus + "%[/color] to Bleed Target on Hit"
			});
		}
		if (this.m.PossibleEffectIdx == 1)
		{
			result.push({
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.EffectChanceOrBonus + "%[/color] to Feint Target on Hit"
			});
		}
		return result;
	}
});
