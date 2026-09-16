this.legend_named_heavy_javelin <- inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function isAmountShown()
	{
		return true;
	}

	function getAmountString()
	{
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_heavy_javelin";
		this.m.Variants = [1];
		this.m.PrefixList = ::Const.Strings.BarbarianPrefix;
		this.m.SuffixList = ::Const.Strings.BarbarianPrefix;
		this.m.NameList = ::Const.Strings.JavelinNames;
		this.m.Description = "A jagged harpoon, that flies true despite it\'s weight and size. Harder to throw and hit with, but more impactful.";
		this.m.Categories = "Throwing Weapon/Spear, One-Handed";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Throwing | ::Const.Items.WeaponType.Spear;
		this.m.ItemType = ::Const.Items.ItemType.Named | ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.RangedWeapon | ::Const.Items.ItemType.Ammo | ::Const.Items.ItemType.Defensive | ::Const.Items.ItemType.OneHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 1800;
		this.m.Ammo = 4;
		this.m.AmmoMax = 4;
		this.m.RangeMin = 1;
		this.m.RangeMax = 4;
		this.m.RangeIdeal = 4;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.45;
		this.m.ShieldDamage = 0;
		this.m.IsDroppedAsLoot = true;
		this.m.AdditionalAccuracy = -5;
		this.m.DirectDamageAdd = 0.1;
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.randomizeValues();
	}

	function updateVariant()
	{
		if (this.m.Ammo > 0)
		{
			this.m.IconLarge = "weapons/ranged/javelins_heavy_01_named_0" + this.m.Variant + ".png";
			this.m.Icon = "weapons/ranged/javelins_heavy_01_named_0" + this.m.Variant + "_70x70.png";
			this.m.ArmamentIcon = "icon_named_javelins_heavy_0" + this.m.Variant;
			this.m.ShowArmamentIcon = true;
		}
		else
		{
			this.m.IconLarge = "weapons/ranged/javelins_01_bag.png";
			this.m.Icon = "weapons/ranged/javelins_01_bag_70x70.png";
			this.m.ArmamentIcon = "icon_named_javelins_heavy_0" + this.m.Variant;
			this.m.ShowArmamentIcon = false;
		}
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.ThrowJavelin);
		::Legends.Actives.grant(this, ::Legends.Active.LegendPiercingJavelin);
	}

	function onPutIntoBag()
	{
		this.item.onPutIntoBag();
		if (this.m.Name.len() == 0)
		{
			if (::Math.rand(1, 100) <= 25)
			{
				this.setName(this.getContainer().getActor().getName() + "\'s " + this.m.NameList[::Math.rand(0, this.m.NameList.len() - 1)]);
			}
			else
			{
				this.setName(this.createRandomName());
			}
		}
	}

	function setAmmo(_a)
	{
		this.weapon.setAmmo(_a);
		this.updateVariant();
		this.updateAppearance();
	}
});
