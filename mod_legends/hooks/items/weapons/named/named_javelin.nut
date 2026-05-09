::mods_hookExactClass("items/weapons/named/named_javelin", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3];
		this.m.Categories = "Throwing Weapon/Spear, One-Handed";
		this.m.WeaponType = this.Const.Items.WeaponType.Throwing | this.Const.Items.WeaponType.Spear;
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.OneHanded;
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.randomizeValues <- function ()
	{
		this.m.Ammo = 6;
		this.m.AmmoMax = 6;
		named_weapon.randomizeValues();
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHeartseekerJavelin);
		::Legends.Actives.grant(this, ::Legends.Active.LegendPiercingJavelin);
	}

	// o.setAmmo = function ()
	// {
	// 	this.named_weapon.setAmmo(_a);
	// 	this.updateVariant();
	// 	this.updateAppearance();
	// }
});
