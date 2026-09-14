this.legend_named_halberd <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variants = [1,2,3];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.ID = "weapon.legend_named_halberd";
		this.m.NameList = this.Const.Strings.BillNames;
		this.m.Description = "A pike-like weapon with a spike for stabbing over some distance and an axe blade for delivering devastating strikes.";
		this.m.WeaponType = this.Const.Items.WeaponType.Polearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 3800;
		this.m.ShieldDamage = 0;
		this.m.Condition = 85.0;
		this.m.ConditionMax = 85.0;
		this.m.StaminaModifier = -14;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 1.5;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 5;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/legend_halberd_01_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_halberd_01_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_legend_halberd_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHalberdSmite);
		::Legends.Actives.grant(this, ::Legends.Active.Impale, function (_skill) {
			_skill.m.Icon = "skills/legend_halberd_impale.png";
			_skill.m.IconDisabled = "skills/legend_halberd_impale_bw.png";
			_skill.m.Overlay = "legend_halberd_impale";
			_skill.m.IsIgnoredAsAOO = true;
		}.bindenv(this));
	}

});

