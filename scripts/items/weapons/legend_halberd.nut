this.legend_halberd <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_halberd";
		this.m.Name = "Halberd";
		this.m.Description = "A pike-like weapon with a spike for stabbing over some distance and an axe blade for delivering devastating strikes.";
		this.m.Variant = this.Math.rand(1, 2);
		this.updateVariant();
		this.m.WeaponType = this.Const.Items.WeaponType.Polearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 2900;
		this.m.ShieldDamage = 0;
		this.m.Condition = 85.0;
		this.m.ConditionMax = 85.0;
		this.m.StaminaModifier = -16;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 1.5;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 5;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/legend_halberd_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_halberd_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_legend_halberd_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHalberdSmite);
		::Legends.Actives.grant(this, ::Legends.Active.Impale, function (_skill) {
			_skill.m.Icon = "skills/legend_halberd_impale.png";
			_skill.m.IconDisabled = "skills/legend_halberd_impale_bw.png";
			_skill.m.Overlay = "legend_halberd_impale";
			_skill.m.IsIgnoredAsAOO = true;
		}.bindenv(this));
	}

});

