::mods_hookExactClass("items/weapons/named/named_fencing_sword", function(o) {

	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_fencing_sword_effect"];
	o.m.EffectBounds <- [ [4, 12] ];

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
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
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.EffectChanceOrBonus+ "%[/color] Initiative"
			});
		}
		return result;
	}
});
