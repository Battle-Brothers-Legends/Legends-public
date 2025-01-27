this.legend_saw <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_saw";
		this.m.Name = "Handsaw";
		this.m.Description = "A toothed blade attached to a wooden grip used to saw through timber. While it is difficult to cut through flesh, the teeth leave a nasty gash.";
		this.m.IconLarge = "weapons/melee/legend_saw_01.png";
		this.m.Icon = "weapons/melee/legend_saw_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_saw_01";
		this.m.ShieldDamage = 0;
		this.m.Condition = 20.0;
		this.m.ConditionMax = 20.0;
		this.m.StaminaModifier = -5;
		this.m.Value = 45;
		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 20;
		this.m.ArmorDamageMult = 0.4;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = -0.1;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local cleave = this.new("scripts/skills/actives/cleave");
		cleave.m.Icon = "skills/active_68.png";
		cleave.m.IconDisabled = "skills/active_68_sw.png";
		cleave.m.Overlay = "active_68";
		this.addSkill(cleave);
		local decapitate = this.new("scripts/skills/actives/decapitate");
		this.addSkill(decapitate);
		//::Legends.Actives.grant(this, ::Legends.Active.LegendHarvestTree);
	}

});

