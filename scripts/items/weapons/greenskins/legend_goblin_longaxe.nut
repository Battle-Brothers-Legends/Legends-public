this.legend_goblin_longaxe <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.longaxe";
		this.m.Name = "Goblin Longaxe";
		this.m.Description = "A relatively small blade on a very long shaft used for devastating cutting attacks over some distance, and to render shields unusable from behind the frontline.";
		this.m.Categories = "Axe, Two-Handed";
		this.m.IconLarge = "weapons/melee/legend_goblin_longaxe.png";
		this.m.Icon = "weapons/melee/legend_goblin_longaxe_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_goblin_weapon_05";
		this.m.Value = 1200;
		this.m.ShieldDamage = 16;
		this.m.Condition = 62.0;
		this.m.ConditionMax = 62.0;
		this.m.StaminaModifier = -12;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Strike, function (_skill) {
			_skill.m.Icon = "skills/active_79.png";
			_skill.m.IconDisabled = "skills/active_79_sw.png";
			_skill.m.Overlay = "active_79";
			_skill.setApplyAxeMastery(true);
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.m.Icon = "skills/active_67.png";
			_skill.m.IconDisabled = "skills/active_67_sw.png";
			_skill.m.Overlay = "active_67";
			_skill.setApplyAxeMastery(true);
		}.bindenv(this));
	}

});

