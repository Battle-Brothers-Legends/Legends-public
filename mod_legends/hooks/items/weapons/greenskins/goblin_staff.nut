::mods_hookExactClass("items/weapons/greenskins/goblin_staff", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.Categories = "Staff, Two-Handed";
		this.m.Description = "A gnarly staff carved from old and hard wood, adorned with bones and feathers. Can give a good wack.";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.ShieldDamage = 0;
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.StaminaModifier = -4;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 35;
		this.m.ArmorDamageMult = 0.3;
		this.m.DirectDamageMult = 0.4;
		this.m.DirectDamageAdd = -0.1;
	}

	o.updateVariant <- function ()
	{
		this.m.IconLarge = "weapons/melee/goblin_staff_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/goblin_staff_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_goblin_staff_0" + this.m.Variant;
	}

	o.onEquip = function ()
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
