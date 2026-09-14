this.legend_wooden_stake <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_wooden_stake";
		this.m.Name = "Wooden Stake";
		this.m.Description = "A roughly sharpened wooden shaft, usually used for tents and carpentry. Can be applied to other more visceral tasks. Very effective against vampires.";
		this.m.IconLarge = "weapons/melee/wooden_stake_01.png";
		this.m.Icon = "weapons/melee/wooden_stake_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Dagger;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_wooden_stake_01";
		this.m.Value = 10;
		this.m.Condition = 2;
		this.m.ConditionMax = 2;
		this.m.RegularDamage = 10;
		this.m.RegularDamageMax = 15;
		this.m.ArmorDamageMult = 0.1;
		this.m.DirectDamageMult = 0.3;
		this.m.DirectDamageAdd = -0.05;
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
			_properties.DamageRegularMax += 105;
		}
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Stab);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

