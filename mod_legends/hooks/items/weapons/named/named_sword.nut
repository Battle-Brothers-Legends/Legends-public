::mods_hookExactClass("items/weapons/named/named_sword", function(o) {

	// o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_sword_riposte_effect"];
	// o.m.EffectBounds <- [ [8, 13] ];

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.Variants = [1, 2, 3, 4, 5, 6, 7, 8];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
	}

	// o.getTooltip <- function ()
	// {
	// 	local result = this.named_weapon.getTooltip();
	// 	if (this.m.PossibleEffectIdx == 0)
	// 	{
	// 		result.push({
	// 			id = 12,
	// 			type = "text",
	// 			icon = "ui/icons/melee_skill.png",
	// 			text = "[color=%positive%]+" + this.m.EffectChanceOrBonus + "%[/color] Chance to Riposte on Turn Start"
	// 		});
	// 	}
	// 	return result;
	// }

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Puncture, function (_skill) {
			_skill.m.IsHalfsword = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Hammer, function (_skill) {
			_skill.m.IsMordhau = true;
		}.bindenv(this));
	}
});
