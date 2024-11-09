::mods_hookExactClass("items/weapons/named/named_three_headed_flail", function(o) {

	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_flail_effect"];
	o.m.EffectBounds <- [ [100, 100] ];

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1, 2]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.m.Description = "An very rare weapon built from valuable and strong materials. Despite its ceremonial look it makes for a terrifying tool of destruction.";
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
				text = "Has a [color=" + this.Const.UI.Color.NegativeValue + "]100%[/color] chance to daze a target on a hit to the head"
			});
		}
		return result;
	}
});
