this.legend_halberd <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_halberd";
		this.m.Name = "Halberd";
		this.m.Description = "A pike-like weapon with a spike for stabbing over some distance and an axe blade for delivering devastating strikes.";
		this.m.IconLarge = "weapons/melee/legend_halberd_01.png";
		this.m.Icon = "weapons/melee/legend_halberd_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Polearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_halberd_01";
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

	function onEquip()
	{
		this.weapon.onEquip();		
		::Legends.Actives.grant(this, ::Legends.Active.LegendHalberdSmite);
		local impale = this.new("scripts/skills/actives/impale");
		impale.m.Icon = "skills/legend_halberd_impale.png";
		impale.m.IconDisabled = "skills/legend_halberd_impale_bw.png";
		impale.m.Overlay = "legend_halberd_impale";
		impale.m.IsIgnoredAsAOO = true; 		
		this.addSkill(impale);
	}

});

