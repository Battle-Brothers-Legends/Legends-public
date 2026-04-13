this.legend_named_goblin_staff <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variants = [1, 2];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.ID = "weapon.legend_named_goblin_staff";
		this.m.Name = "Adorned Gnarly Staff";
		this.m.Description = "A gnarly staff carved from old and hard wood, decorated with a menacing skull, feathers and small bones. The runes on the head are intricate and tell a story that only the goblins can read.";
		this.m.WeaponType = this.Const.Items.WeaponType.Staff | this.Const.Items.WeaponType.MagicStaff | this.Const.Items.WeaponType.Polearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.IsSellable = true;
		this.m.Value = 10000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -3;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 0.7;
		this.m.DirectDamageMult = 0.4;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/named_goblin_staff_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/named_goblin_staff_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_named_goblin_staff_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Bash, function (_skill) {
			_skill.m.Icon = "skills/staff_bash_gnarled.png";
			_skill.m.IconDisabled = "skills/staff_bash_gnarled_bw.png";
			_skill.m.IsStaffBash = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.KnockOut, function (_skill) {
			_skill.m.Icon = "skills/staff_knock_out_gnarled.png";
			_skill.m.IconDisabled = "skills/staff_knock_out_gnarled_bw.png";
			_skill.m.IsStaffKnockOut = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendStaffRiposte);
	}
});
