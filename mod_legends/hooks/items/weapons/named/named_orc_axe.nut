::mods_hookExactClass("items/weapons/named/named_orc_axe", function(o) {
	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_axe_effect"];
	o.m.EffectBounds <- [ [15, 35] ];

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.AmmoCost = 5;
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
	}

	o.randomizeValues <- function ()
	{
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		named_weapon.randomizeValues();
	}

	o.getAmmo <- function() {
		return this.m.Ammo;
	}

	o.getAmmoMax <- function() {
		return this.m.AmmoMax;
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
				text = "[color=%positive%]+" + this.m.EffectChanceOrBonus + "%[/color] Damage to Head"
			});
		}
		return result;
	}

	local onEquip = o.onEquip;
	o.onEquip = function()
	{
		onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.ThrowAxe, function (_skill) {
			_skill.m.IsBackupAxe = true;
		}.bindenv(this));
	}
});
