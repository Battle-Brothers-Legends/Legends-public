this.legend_wooden_pitchfork <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_wooden_pitchfork";
		this.m.Name = "Wooden pitchfork";
		this.m.Description = "A makeshift agricultural tool, barely held together but it could still poke out an eye.";
		this.m.Categories = "Polearm, Two-Handed";
		this.m.IconLarge = "weapons/melee/wooden_pitchfork_01.png";
		this.m.Icon = "weapons/melee/wooden_pitchfork_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_wooden_pitchfork_01";
		this.m.Value = 30;
		this.m.ShieldDamage = 0;
		this.m.Condition = 16.0;
		this.m.ConditionMax = 16.0;
		this.m.StaminaModifier = -8;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 10;
		this.m.RegularDamageMax = 30;
		this.m.ArmorDamageMult = 0.2;
		this.m.DirectDamageMult = 0.2;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local impale = this.new("scripts/skills/actives/impale");
		impale.m.Icon = "skills/active_57.png";
		impale.m.IconDisabled = "skills/active_57_sw.png";
		impale.m.Overlay = "active_57";
		this.addSkill(impale);
		local repel = this.new("scripts/skills/actives/repel");
		repel.m.Icon = "skills/active_58.png";
		repel.m.IconDisabled = "skills/active_58_sw.png";
		repel.m.Overlay = "active_58";
		this.addSkill(repel);
	}

});
