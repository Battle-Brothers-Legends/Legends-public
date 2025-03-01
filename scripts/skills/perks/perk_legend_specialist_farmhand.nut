this.perk_legend_specialist_farmhand <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistFarmhand);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IconMini = "perk_spec_bitchfork_mini.png";
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return this.getDefaultSpecialistSkillDescription("Polearms and Farming Tools");
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
			id = 6,
			type = "text",
			icon = "ui/icons/armor_damage.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + actor.calculateSpecialistBonus(25, _specialistWeapon) + "%[/color] Bonus Armor Damage"
		}]);
		if (actor.getCurrentProperties().IsSpecializedInPolearms)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(9, _specialistWeapon) + "-" + actor.calculateSpecialistBonus(24, _specialistWeapon) + "[/color] Damage"
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
			case !(item.isWeaponType(this.Const.Items.WeaponType.Polearm) || item.isItemType(this.Const.Items.ItemType.Pitchfork)):
				return this.getNoSpecialistWeaponTooltip();
			case item.isItemType(this.Const.Items.ItemType.Pitchfork):
				specialistWeapon = true;
		}

		return this.specialistWeaponTooltip(specialistWeapon);
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;

		switch (true) 
		{
			case item == null:
			case !(item.isWeaponType(this.Const.Items.WeaponType.Polearm) || item.isItemType(this.Const.Items.ItemType.Pitchfork)):
				return;
			case item.isItemType(this.Const.Items.ItemType.Pitchfork):
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		_properties.DamageArmorMult += actor.calculateSpecialistBonus(0.25, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInPolearms)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(9, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(24, specialistWeapon);
		}
	}
});
