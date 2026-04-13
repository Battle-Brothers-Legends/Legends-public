this.legend_orc_throwing_spear <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_orc_throwing_spear";
		this.m.Name = "Crude Throwing Spear";
		this.m.Description = "Crudely made light throwing spear, this weapon is intended to be thrown over short distances. The tip will bend on impact, potentially rendering shields unusable. Can be used against unshielded opponents as well for great effect.";
		this.m.Categories = "Throwing Weapon/Spear, One-Handed";
		this.m.IconLarge = "weapons/ranged/legend_orc_throwing_spear.png";
		this.m.Icon = "weapons/ranged/legend_orc_throwing_spear_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Tool;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_orc_weapon_03";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.OneHanded;
		this.m.Value = 400;
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 6;
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 6;
		this.m.RangeMin = 1;
		this.m.RangeMax = 4;
		this.m.RangeIdeal = 4;
		this.m.StaminaModifier = -6;
		this.m.ShieldDamage = 35;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 1.3;
		this.m.DirectDamageMult = 0.4;
		this.m.IsDroppedAsLoot = true;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Requires 6 ammunition to replenish after battle"
		});
		return result;
	}

	function isAmountShown() {
		return true;
	}

	function getAmountString() {
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	function setAmmo( _a )
	{
		this.weapon.setAmmo(_a);

		if (this.m.Ammo > 0)
		{
			this.m.Name = "Throwing Spear";
			this.m.IconLarge = "weapons/ranged/legend_orc_throwing_spear.png";
			this.m.Icon = "weapons/ranged/legend_orc_throwing_spear_70x70.png";
			this.m.ShowArmamentIcon = true;
		}
		else
		{
			this.m.Name = "Throwing Spear (Used)";
			this.m.IconLarge = "weapons/ranged/javelins_01_bag.png";
			this.m.Icon = "weapons/ranged/javelins_01_bag_70x70.png";
			this.m.ShowArmamentIcon = false;
		}

		this.updateAppearance();
	}

	function isDroppedAsLoot()
	{
		return this.weapon.isDroppedAsLoot() && (this.m.LastEquippedByFaction == this.Const.Faction.Player || this.getCurrentSlotType() != this.Const.ItemSlot.Bag);
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.ThrowSpear);
	}

});

