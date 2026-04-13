this.legend_parrying_dagger <- this.inherit("scripts/items/shields/shield", {
	m = {
		Variants = [],
		WeaponType = ::Const.Items.WeaponType.Dagger, // workaround: hardcode WeaponType since this is actually a shield
		OffHandWeaponSkills = {},
		PrimaryOffhandAttack = null,
		// for offhand weapon
		RegularDamage = 20,
		RegularDamageMax = 40,
		ArmorDamageMult = 0.7,
		DirectDamageMult = 0.2,
		DirectDamageAdd = 0.0,
		ChanceToHitHead = 0,
	},
	function getPrimaryOffhandAttack()
	{
		return m.PrimaryOffhandAttack;
	}

	function create()
	{
		this.shield.create();
		this.m.ID = "shield.legend_parrying_dagger";
		this.m.Name = "Parrying dagger";
		this.m.Description = "An offhand dagger for actively parrying an opponent.\n\n When parried or if an opponent misses you, their defences will be lowered.\n\n The \'Split Shield\' skill only does 20% damage against this dagger";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.m.ItemType = this.Const.Items.ItemType.Shield | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.Weapon;
		this.updateVariant();
		this.m.Value = 500;
		this.m.MeleeDefense = 5;
		this.m.RangedDefense = 0;
		this.m.StaminaModifier = -2;
		this.m.Condition = 36;
		this.m.ConditionMax = 36;
	}

	function updateVariant()
	{
		this.m.Sprite = "icon_legend_parrying_dagger_0" + this.m.Variant;
		this.m.SpriteDamaged = "icon_legend_parrying_dagger_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "icon_legend_parrying_dagger_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "weapons/melee/legend_parrying_dagger_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_parrying_dagger_0" + this.m.Variant + "_70x70.png";
	}

	function getTooltip()
	{
		local result = this.shield.getTooltip();
		local find;

		foreach(i, tooltip in result)
		{
			if (tooltip.id != 4 || tooltip.type != "progressbar") continue;

			find = i;
			break;
		}

		if (find != null)
		{
			if (this.m.RegularDamage > 0)
			{
				result.insert(find + 1, {
					id = 4,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "Damage of [color=%damage%]" + this.m.RegularDamage + "[/color] - [color=%damage%]" + this.m.RegularDamageMax + "[/color]"
				});
			}

			if (this.m.DirectDamageMult > 0)
			{
				result.insert(find + 2, {
					id = 64,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = "[color=%damage%]" + this.Math.floor((this.m.DirectDamageMult + this.m.DirectDamageAdd) * 100) + "%[/color] of damage ignores armor"
				});
			}

			if (this.m.ArmorDamageMult > 0)
			{
				result.insert(find + 3, {
					id = 5,
					type = "text",
					icon = "ui/icons/armor_damage.png",
					text = "[color=%damage%]" + this.Math.floor(this.m.ArmorDamageMult * 100) + "%[/color] effective against armor"
				});
			}

			if (this.m.ChanceToHitHead > 0)
			{
				result.insert(find + 4, {
					id = 9,
					type = "text",
					icon = "ui/icons/chance_to_hit_head.png",
					text = "Chance to hit head [color=%positive%]+" + this.m.ChanceToHitHead + "%[/color]"
				});
			}
		}

		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants [color=%positive%]+10%[/color] melee damage if having a dagger on your mainhand"
		});

		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play(::Const.Sound.DefaultWeaponEquip[this.Math.rand(0, ::Const.Sound.DefaultWeaponEquip.len() - 1)], this.Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
		m.OffHandWeaponSkills.clear(); // reset, it isn't bad for being too careful

		this.shield.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Stab, function (_skill) {
			this.m.OffHandWeaponSkills[_skill.m.ID] <- ::MSU.asWeakTableRef(_skill);
			this.m.PrimaryOffhandAttack = this.m.OffHandWeaponSkills[_skill.m.ID];
			_skill.m.Order = ::Const.SkillOrder.UtilityTargeted - 3;
			_skill.m.ID = _skill.m.ID + "_offhand";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Puncture, function (_skill) {
			this.m.OffHandWeaponSkills[_skill.m.ID] <- ::MSU.asWeakTableRef(_skill);
			_skill.m.Order = ::Const.SkillOrder.UtilityTargeted - 2;
			_skill.m.ID = _skill.m.ID + "_offhand";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendEnGarde);
		::Legends.Effects.grant(this, ::Legends.Effect.LegendParryingDagger, function(_effect) {
			_effect.m.Order = this.Const.SkillOrder.UtilityTargeted;
			_effect.setItem(this);
			this.m.SkillPtrs.push(_effect);
		}.bindenv(this));
		// Manually add the effect so that it will be ordered after perks in the skill container instead of before background
		// Even though this effect is being granted by equipping this weapon, we are adding it this way because of possible future plans to make legend_parrying_effect available not just by equipping this weapon.
		// Hence, making ordering it with the other effects/perks instead of the row above background (for item-granted effects) is for consistency
		::Legends.Effects.grant(this, ::Legends.Effect.LegendParrying, function(_effect) {
			_effect.m.IsFromItem = true;
			_effect.m.Order = this.Const.SkillOrder.UtilityTargeted + 2;
			_effect.setItem(this);
			this.m.SkillPtrs.push(_effect);
		}.bindenv(this));
	}

	function onUnequip()
	{
		shield.onUnequip();

		foreach (id, offhandSkill in m.OffHandWeaponSkills)
		{

			if (::MSU.isNull(offhandSkill)) {
				continue;
			}

			local mainhandSkill = getContainer().getActor().getSkills().getSkillByID(id);

			if (mainhandSkill != null)
				mainhandSkill.m.IsHidden = false; // stop hiding the main hand skills
		}

		m.OffHandWeaponSkills.clear(); // reset
		m.PrimaryOffhandAttack = null;
	}

	function onUpdateProperties( _properties )
	{
		shield.onUpdateProperties(_properties);
		local main = getContainer().getActor().getMainhandItem();

		if (main == null)
			return;

		if (main.isWeaponType(::Const.Items.WeaponType.Dagger))
			_properties.MeleeDamageMult *= 1.1;

		local shouldHidden = main.m.RegularDamageMax >= m.RegularDamageMax;
		foreach (id, offhandSkill in m.OffHandWeaponSkills)
		{
			local mainhandSkill = getContainer().getActor().getSkills().getSkillByID(id);

			if (mainhandSkill == null) {
				if (offhandSkill != null && "m" in offhandSkill) {
					offhandSkill.m.IsHidden = false;
				}
				continue;
			} else if (::MSU.isNull(offhandSkill)) {
				if (mainhandSkill != null && "m" in mainhandSkill) {
					mainhandSkill.m.IsHidden = false;
				}
				continue;
			}

			offhandSkill.m.IsHidden = shouldHidden;
			mainhandSkill.m.IsHidden = !shouldHidden;
		}
	}

	function getAmmoMax()
	{
		return 0;
	}

	// Hardcode this because the parrying dagger inherits from shield, but active skills may sometimes trigger WeaponType checks
	function isWeaponType( _t, _any = true, _only = false )
	{
		if (_any)
		{
			return _only ? this.m.WeaponType - (this.m.WeaponType & _t) == 0 : (this.m.WeaponType & _t) != 0;
		}
		else
		{
			return _only ? (this.m.WeaponType & _t) == this.m.WeaponType : (this.m.WeaponType & _t) == _t;
		}
	}

});

