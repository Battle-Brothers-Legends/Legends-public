this.legend_hand_crossbow <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		IsLoaded = true
	},
	function isLoaded()
	{
		return this.m.IsLoaded;
	}

	function setLoaded( _l )
	{
		this.m.IsLoaded = _l;
	}

	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_hand_crossbow";
		this.m.Name = "Hand Crossbow";
		this.m.Description = "A miniature pull-lever crossbow that can propel bolts over medium distances and be held in the off hand. The small size reduces damage and it requires almost a full turn to reload.";
		this.m.IconLarge = "weapons/ranged/legend_hand_crossbow_01.png";
		this.m.Icon = "weapons/ranged/legend_hand_crossbow_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Crossbow;
		this.m.SlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive| this.Const.Items.ItemType.OneHanded;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_hand_crossbow_01";
		this.m.Value = 1500;
		this.m.RangeMin = 1;
		this.m.RangeMax = 5;
		this.m.RangeIdeal = 4;
		this.m.StaminaModifier = -8;
		this.m.Condition = 30.0;
		this.m.ConditionMax = 30.0;
		this.m.RegularDamage = 20;
		this.m.RegularDamageMax = 40;
		this.m.ArmorDamageMult = 0.4;
		this.m.DirectDamageMult = 0.5;
	}

	function getAmmoID()
	{
		return "ammo.bolts";
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();

		if (!this.m.IsLoaded)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Must be reloaded before firing again[/color]"
			});
		}

		return result;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(this.new("scripts/skills/actives/shoot_bolt"));
		this.addSkill(this.new("scripts/skills/actives/legend_piercing_bolt_skill"));

		if (!this.m.IsLoaded)
		{
			this.addSkill(this.new("scripts/skills/actives/reload_bolt"));
		}
	}

	function onCombatFinished()
	{
		this.weapon.onCombatFinished();
		this.setLoaded(true);
	}

});

