::mods_hookExactClass("items/weapons/named/named_skullhammer", function(o) {

	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_hammer_stun_effect"];
	o.m.EffectBounds <- [ [3, 7] ];
	
	o.randomizeValues <- function ()
	{
		this.m.StaminaModifier = -17;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;

		named_weapon.randomizeValues();
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.EffectChanceOrBonus + "%[/color] Stun Chance"
			});
		}
		return result;
	}
});
