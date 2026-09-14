this.legend_skullsmasher <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_skullsmasher";
		this.m.Name = "Skull Smasher";
		this.m.Description = "A massive crude hammer with a head fashioned from a chunk of solid iron. Not well suited for human hands.";
		this.m.IconLarge = "weapons/melee/legend_skullsmasher_01.png";
		this.m.Icon = "weapons/melee/legend_skullsmasher_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Hammer;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_skullsmasher_01";
		this.m.Value = 1200;
		this.m.ShieldDamage = 32;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -20;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 2.25;
		this.m.DirectDamageMult = 0.5;
		this.m.ChanceToHitHead = 0;
		this.m.FatigueOnSkillUse = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Hammer);
		::Legends.Actives.grant(this, ::Legends.Active.CrushArmor);
	}
});
