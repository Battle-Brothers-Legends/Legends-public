this.legend_shovel <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 10
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_shovel";
		this.m.Name = "Shovel";
		this.m.Description = "A tool meant for digging holes, not maiming men. A shovel\'s wide blade lends accuracy when aiming for the head, but almost anything else would be better.";
		this.m.IconLarge = "weapons/melee/legend_shovel_01.png";
		this.m.Icon = "weapons/melee/legend_shovel_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Mace;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsDoubleGrippable = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_shovel_01";
		this.m.Value = 50;
		this.m.Condition = 32.0;
		this.m.ConditionMax = 32.0;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 20;
		this.m.RegularDamageMax = 30;
		this.m.ArmorDamageMult = 0.45;
		this.m.DirectDamageMult = 0.4;
		this.m.DirectDamageAdd = -0.2;
		this.m.ChanceToHitHead = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Bash, function (_skill) {
			_skill.m.Icon = "skills/shovel_bash.png";
			_skill.m.IconDisabled = "skills/shovel_bash_bw.png";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.KnockOut);
	}

});

