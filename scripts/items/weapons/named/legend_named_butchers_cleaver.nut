this.legend_named_butchers_cleaver <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		PossibleEffects = ["scripts/skills/effects/legend_named_cleaver_effect"],
		EffectBounds = [ [10, 20] ]
	},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_butchers_cleaver";
		this.m.NameList = this.Const.Strings.CleaverNames;
		this.m.Name = "Butcher\'s Bone Cleaver";
		this.m.Description = "A superbly crafted tool with a thick rectangular blade used for hacking through meat and bone.";
		this.m.IconLarge = "weapons/melee/cleaver_02_named.png";
		this.m.Icon = "weapons/melee/cleaver_02_named_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_cleaver_02_named";
		this.m.ShieldDamage = 0;
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.StaminaModifier = -6;
		this.m.Value = 1100;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.25;
		this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.named_weapon.getTooltip();
		if (this.m.PossibleEffectIdx == 0)
		{
			result.push({
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.EffectChanceOrBonus + "%[/color] Fatality Chance"
			});
		}
		return result;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Cleave, function (_skill) {
			_skill.m.Icon = "skills/active_68.png";
			_skill.m.IconDisabled = "skills/active_68_sw.png";
			_skill.m.Overlay = "active_68";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate);
	}

});

