this.legend_battle_glaive <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_battle_glaive";
		this.m.Name = "Battle Glaive";
		this.m.Description = "A long and sturdy glaive built for heavy combat, used to thrust, deal sweeping strikes over some distance and slashes in close range.";
		this.m.Variant = this.Math.rand(1, 2);
		this.updateVariant();
		this.m.WeaponType = this.Const.Items.WeaponType.Polearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 950;
		this.m.StaminaModifier = -14;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 75;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.3;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/legend_battle_glaive_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_battle_glaive_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_legend_battle_glaive_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Strike, function (_skill) {
			_skill.m.IsGlaiveStrike = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendSkewer);
	}
});
