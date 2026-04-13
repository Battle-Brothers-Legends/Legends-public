this.legend_decorated_rhomphaia <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		Bravery = 5
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_decorated_rhomphaia";
		this.m.Name = "Decorated Rhomphaia";
		this.m.Description = "A long curved blade adorned with gold inlays depicting a variety of subjects from harvests to battles. It is a much lighter weapon than expected and clearly served a ceremonial purpose.";
		this.m.IconLarge = "weapons/melee/legend_decorated_rhompaia_01.png";
		this.m.Icon = "weapons/melee/legend_decorated_rhompaia_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsDoubleGrippable = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_decorated_rhompaia_01";
		this.m.Value = 1800;
		this.m.ShieldDamage = 0;
		this.m.Condition = 38.0;
		this.m.ConditionMax = 38.0;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 45;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.2;
		this.m.DirectDamageAdd = 0.15;
		this.m.ChanceToHitHead = 5;
	}

	function onUpdateProperties ( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		if (::World.Assets.getOrigin() != null && ::World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			_properties.Bravery += this.m.Bravery;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Slash, function (_skill) {
			_skill.m.IsGreatBreachSlash = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Split);
		::Legends.Actives.grant(this, ::Legends.Active.Swing);
		::Legends.Actives.grant(this, ::Legends.Active.LegendIntoTheFray);
	}
});
