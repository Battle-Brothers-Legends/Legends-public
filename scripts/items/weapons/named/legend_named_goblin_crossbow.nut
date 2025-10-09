this.legend_named_goblin_crossbow <- this.inherit("scripts/items/weapons/named/named_weapon", {
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
		this.named_weapon.create();
		this.m.Variant = this.Math.rand(1, 2);
		this.updateVariant();
		this.m.ID = "weapon.legend_named_goblin_crossbow";
		this.m.NameList = this.Const.Strings.CrossbowNames;
		this.m.PrefixList = this.Const.Strings.GoblinWeaponPrefix;
		this.m.Description = "A large and heavy crossbow with menacing spikes in front. It's a mystery how goblins could improve upon a miniature ballista, but here we are. It shoots stakes with enough force to knock back a target hit. Deals +100 damage to vampires.";
		this.m.Categories = "Crossbow, Two-Handed";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = true;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 3200;
		this.m.Condition = 72;
		this.m.ConditionMax = 72;
		this.m.RangeMin = 1;
		this.m.RangeMax = 6;
		this.m.RangeIdeal = 6;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.5;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/ranged/goblin_crossbow_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/ranged/goblin_crossbow_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_goblin_crossbow_named_0" + this.m.Variant;
	}

	function getAmmoID()
	{
		return "ammo.bolts";
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();

		result.push({
			id = 9,
			type = "text",
			icon = "ui/tooltips/special.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]Must be reloaded before firing again[/color]"
		});

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
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.ShootStake);
		if (!this.m.IsLoaded)
		{
			::Legends.Actives.grant(this, ::Legends.Active.ReloadBolt);
		}
		::Legends.Actives.grant(this, ::Legends.Active.LegendPiercingBolt);
		::Legends.Actives.grant(this, ::Legends.Active.KnockOut, function (_skill) {
			_skill.m.IsRangedKnockOut = true;
		}.bindenv(this));
	}

	function onCombatFinished()
	{
		this.weapon.onCombatFinished();
		this.m.IsLoaded = true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		local item = _skill.getItem();

		if (!_skill.isAttack())
			return;

		if (!_skill.isRanged())
			return;

		if (item == null)
			return;

		if (item.getID() != this.getID())
			return;

		if (_targetEntity != null && (_targetEntity.getType() == this.Const.EntityType.Vampire || _targetEntity.getType() == this.Const.EntityType.LegendVampireLord))
		{
			_properties.DamageRegularMin += 100;
			_properties.DamageRegularMax += 100;
		}
	}

});

