this.legend_broad_warscythe <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_broad_warscythe";
		this.m.Name = "Ancient Broad Warscythe";
		this.m.Description = "A broad and heavy warscythe, characterised by a much longer blade. This weapon demands much room to use and is difficult to wield, but the havoc it can cause against attackers on both two legs or four is unparalleled.";
		this.m.IconLarge = "weapons/melee/legend_broad_warscythe_01.png";
		this.m.Icon = "weapons/melee/legend_broad_warscythe_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Polearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_broad_warscythe_01";
		this.m.Value = 1400;
		this.m.ShieldDamage = 0;
		this.m.Condition = 45.0;
		this.m.ConditionMax = 45.0;
		this.m.StaminaModifier = -18;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 105;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.05;
		this.m.ChanceToHitHead = 5;
		this.m.FatigueOnSkillUse = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendScytheCleave);
		::Legends.Actives.grant(this, ::Legends.Active.Reap);
	}

});