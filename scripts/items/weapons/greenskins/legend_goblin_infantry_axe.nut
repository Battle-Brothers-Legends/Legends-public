this.legend_goblin_infantry_axe <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create() {
		this.weapon.create();
		this.m.ID = "weapon.goblin_infantry_axe";
		this.m.Name = "Goblin Harrier Axe";
		this.m.Description = "A relatively small blade on a very long shaft used to deliver quick devastating attacks.";
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
		this.m.Value = 1950;
		this.m.ShieldDamage = 24;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceToHitHead = 10;
	}

	function onEquip() {
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Chop, function (_skill) {
			_skill.m.Icon = "skills/active_79.png";
			_skill.m.IconDisabled = "skills/active_79_sw.png";
			_skill.m.Overlay = "active_79";
			_skill.m.IsHack = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendHaftstrike);
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.m.Icon = "skills/active_67.png";
			_skill.m.IconDisabled = "skills/active_67_sw.png";
			_skill.m.Overlay = "active_67";
			_skill.m.ActionPointCost = 4;
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
		}.bindenv(this));
	}

});

