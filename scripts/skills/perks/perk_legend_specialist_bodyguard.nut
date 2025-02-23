this.perk_legend_specialist_bodyguard <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_bodyguard";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistBodyguard;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistBodyguard;
		this.m.Icon = "ui/perks/perk_spec_2hsword.png";
		// this.m.IconMini = "perk_spec_2hsword_mini.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription ()
	{
		return this.getDefaultSpecialistSkillDescription("Two Handed Swords");
	}

	function specialistWeaponTooltip (_specialistWeapon = false)
	{
		local actor = this.getContainer().getActor();
		if (actor.calculateSpecialistBonus(12, _specialistWeapon) == 0)
			return this.getNoSpecialistWeaponTooltip();

		local item = actor.getMainhandItem();
		local tooltip = this.skill.getTooltip();
		
		tooltip.extend([
		{
			id = 6,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, _specialistWeapon) + "[/color] Melee Skill"
		},
		{
			id = 7,
			type = "text",
			icon = "ui/icons/armor_damage.png",
			text = "[color=" + this.Const.UI.Color.DamageValue + "]" + actor.calculateSpecialistBonus(10, _specialistWeapon) + "%[/color] Armor Damage"
		},
		{
			id = 8,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "[color=" + this.Const.UI.Color.DamageValue + "]" + actor.calculateSpecialistBonus(10, _specialistWeapon) + "%[/color] Armor Penetration"
		}]);
		if (actor.getCurrentProperties().IsSpecializedInSwords)
		{
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(6, _specialistWeapon) + "-" + actor.calculateSpecialistBonus(16, _specialistWeapon) + "[/color] Damage"
			});
		}
		return tooltip;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;
		switch (true) 
		{
			case item == null:
			case !item.isItemType(this.Const.Items.ItemType.TwoHanded):
			case !item.isWeaponType(this.Const.Items.WeaponType.Sword):
				return getNoSpecialistWeaponTooltip();
			case item.getID() == "weapon.legend_longsword":
			case item.getID() == "weapon.legend_named_longsword":
			case item.getID() == "weapon.longsword":
			case item.getID() == "weapon.named_longsword":
				specialistWeapon = true;
		}

		return specialistWeaponTooltip(specialistWeapon);
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;

		switch (true) 
		{
			case item == null:
			case !item.isItemType(this.Const.Items.ItemType.TwoHanded):
			case !item.isWeaponType(this.Const.Items.WeaponType.Sword):
				return;
			case item.getID() == "weapon.legend_longsword":
			case item.getID() == "weapon.legend_named_longsword":
			case item.getID() == "weapon.longsword":
			case item.getID() == "weapon.named_longsword":
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		_properties.DamageDirectMult += 0.01 * actor.calculateSpecialistBonus(10, specialistWeapon);
		_properties.DamageArmorMult += 0.01 * actor.calculateSpecialistBonus(10, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInSwords)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}
});
