this.legend_military_crypt_cleaver <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_military_crypt_cleaver";
		this.m.Name = "Military Crypt Cleaver";
		this.m.Description = "A significantly hefty two-handed cleaver with a recurved end. Despite being worn and blunted, the titanic weight of this weapon makes up for it\'s age.";
		this.m.IconLarge = "weapons/melee/legend_military_crypt_cleaver.png";
		this.m.Icon = "weapons/melee/legend_military_crypt_cleaver_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsDoubleGrippable = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_military_crypt_cleaver_01";
		this.m.Value = 2800;
		this.m.ShieldDamage = 18;
		this.m.Condition = 75.0;
		this.m.ConditionMax = 75.0;
		this.m.StaminaModifier = -19;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.3;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.05;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Cleave, function (_skill) {
			_skill.m.FatigueCost = 15;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate);
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.m.FatigueCost = 5;
		}.bindenv(this));
	}
});
