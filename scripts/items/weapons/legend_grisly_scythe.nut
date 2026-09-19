this.legend_grisly_scythe <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_grisly_scythe";
		this.m.Name = "Grisly Scythe";
		this.m.Description = "While looking like a regular agricultural tool from a distance, this scythe has an otherworldy aura that draws you in. Resurrects humans it kills, if they aren\'t too damaged.";
		this.m.IconLarge = "weapons/melee/legend_scythe_02.png";
		this.m.Icon = "weapons/melee/legend_scythe_02_70x70.png";
		this.m.WeaponType = ::Const.Items.WeaponType.Cleaver | ::Const.Items.WeaponType.Polearm;
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.Pitchfork;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_scythe_02";
		this.m.Value = 750;
		this.m.ShieldDamage = 20;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.StaminaModifier = -9;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 35;
		this.m.ArmorDamageMult = 0.5;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.25;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Cleave, function (_skill)
		{
			_skill.m.IsScytheCleave = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Reap);
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate, function (_skill) {
			_skill.m.IsScytheDecapitate = true;
		}.bindenv(this));
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
		this.weapon.onDamageDealt(_target, _skill, _hitInfo);

		local actor = this.getContainer().getActor();

		if (actor == null || actor.isNull())
		{
			return;
		}

		local Skills = actor.getSkills();

		if (!Skills.hasSkill(::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderNecro)) && !Skills.hasSkill(::Legends.Backgrounds.getID(::Legends.Background.LegendNecromancer)))
		{
			return;
		}

		if (!this.isKindOf(_target, "player") && !this.isKindOf(_target, "human"))
		{
			return;
		}

		if (_target.getHitpoints() > 0)
		{
			return;
		}

		if (_hitInfo.Tile.IsCorpseSpawned && _hitInfo.Tile.Properties.get("Corpse").IsResurrectable)
		{
			local corpse = _hitInfo.Tile.Properties.get("Corpse");
			corpse.Faction = ::Const.Faction.PlayerAnimals;
			corpse.Hitpoints = 1.0;
			corpse.Items = _target.getItems();
			corpse.IsConsumable = false;
			corpse.IsResurrectable = false;
			::Time.scheduleEvent(::TimeUnit.Rounds, 1, ::Tactical.Entities.resurrect, corpse);
		}
	}

});

