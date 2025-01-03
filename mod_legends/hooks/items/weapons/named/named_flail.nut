::mods_hookExactClass("items/weapons/named/named_flail", function(o) {

	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_flail_effect"];
	o.m.EffectBounds <- [ [100, 100] ];

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1, 2, 3]
	}

	o.randomizeValues <- function ()
	{
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;

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
				icon = "ui/icons/armor_head.png",
				text = "Has a [color=" + this.Const.UI.Color.NegativeValue + "]100%[/color] chance to daze a target on a hit to the head"
			});
		}
		return result;
	}
});
