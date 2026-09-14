this.legend_blooddrinker <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_royal_executioner";
		this.m.Name = "Blooddrinker";
		this.m.Description = "A very large double edged executioner's song with a flared blade at the top. You don't understand what kind of craftsmanship could've crafted such a blade, as despite the unwieldy length and weight it handles well. The blade sings a bitter song of mountains of beheaded corpses.";
		this.m.Categories = "Cleaver, Two-Handed";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.Legendary;
		this.m.IconLarge = "weapons/melee/legendary_greatsword.png";
		this.m.Icon = "weapons/melee/legendary_greatsword_70x70.png";
		this.m.ArmamentIcon = "icon_legendary_greatsword_01";
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 20000;
		this.m.Condition = 150.0;
		this.m.ConditionMax = 150.0;
		this.m.StaminaModifier = -20;
		this.m.RegularDamage = 100;
		this.m.RegularDamageMax = 140;
		this.m.ArmorDamageMult = 1.6;
		this.m.DirectDamageMult = 0.25;
		this.m.ChanceToHitHead = 20;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "On killing blow recovers [color=%positive%]10%[/color] of your maximum Hitpoints"
		});
		
		return result;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Effects.grant(this, ::Legends.Effect.LegendBlooddrinker);
		::Legends.Actives.grant(this, ::Legends.Active.LegendHew);
		::Legends.Actives.grant(this, ::Legends.Active.LegendHarvest);
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate, function (_skill) {
			_skill.m.IsTwoHand = true;
		}.bindenv(this));
	}
});

