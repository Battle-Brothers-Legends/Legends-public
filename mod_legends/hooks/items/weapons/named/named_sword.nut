::mods_hookExactClass("items/weapons/named/named_sword", function(o) {

	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_sword_riposte_effect"];
	o.m.EffectBounds <- [ [8, 13] ];

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3,4,5,6,7]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		local s = this.new("scripts/skills/actives/bash");
		s.m.IsSwordBash = true;
		this.addSkill(s);
		onEquip();
	}

	o.getTooltip <- function ()
	{
		local result = this.named_weapon.getTooltip();
		if (this.m.PossibleEffectIdx == 0)
		{
			result.push({
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.EffectChanceOrBonus + "%[/color] Chance to Riposte on Turn Start"
			});
		}
		return result;
	}
});
