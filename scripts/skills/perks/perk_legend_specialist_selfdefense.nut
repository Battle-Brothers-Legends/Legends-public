this.perk_legend_specialist_selfdefense <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecSelfdefense);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IconMini = "perk_spec_staff_mini.png";
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return this.getDefaultSpecialistSkillDescription("Staves and Musical Instruments");
	}

	function specialistWeaponTooltip (_specialistWeapon = false)
	{
		local actor = this.getContainer().getActor();
		if (actor.calculateSpecialistBonus(12, _specialistWeapon) == 0)
			return this.getNoSpecialistWeaponTooltip();

		local item = actor.getMainhandItem();
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(16, _specialistWeapon) + "[/color] Defense"
		});
		if (actor.getCurrentProperties().IsSpecializedInStaves)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, _specialistWeapon) + "[/color] Melee Skill"
			});
		}
		return tooltip;
	}

	function hybridWeaponTooltip (_specialistWeapon = false)
	{
		local actor = this.getContainer().getActor();
		if (actor.calculateSpecialistBonus(8, _specialistWeapon) == 0)
			return this.getNoSpecialistWeaponTooltip();

		local item = actor.getMainhandItem();
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(8, _specialistWeapon) + "[/color] Defense"
		});
		if (actor.getCurrentProperties().IsSpecializedInStaves)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(6, _specialistWeapon) + "[/color] Melee Skill"
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
				return this.getNoSpecialistWeaponTooltip();
			case item.isWeaponType(this.Const.Items.WeaponType.Staff) && item.isWeaponType(this.Const.Items.WeaponType.Sling):
			case item.isWeaponType(this.Const.Items.WeaponType.Staff) && item.isWeaponType(this.Const.Items.WeaponType.Sword):
			case item.isWeaponType(this.Const.Items.WeaponType.Musical):
				return this.hybridWeaponTooltip(false);
			case (!item.isWeaponType(this.Const.Items.WeaponType.Staff)):
				return this.getNoSpecialistWeaponTooltip();
			case (!item.isWeaponType(this.Const.Items.WeaponType.MagicStaff)):
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
				return;
			case item.isWeaponType(this.Const.Items.WeaponType.Staff) && item.isWeaponType(this.Const.Items.WeaponType.Sling):
			case item.isWeaponType(this.Const.Items.WeaponType.Staff) && item.isWeaponType(this.Const.Items.WeaponType.Sword):
			case item.isWeaponType(this.Const.Items.WeaponType.Musical):
				return handleHybrid( _properties );
			case (!item.isWeaponType(this.Const.Items.WeaponType.Staff)):
				return;
			case (!item.isWeaponType(this.Const.Items.WeaponType.MagicStaff)):
				specialistWeapon = true;
		}

		_properties.MeleeDefense += actor.calculateSpecialistBonus(16, specialistWeapon);
		_properties.RangedDefense += actor.calculateSpecialistBonus(16, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInStaves)
		{
			_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		}
	}

	function handleHybrid( _properties )
	{
		local actor = this.getContainer().getActor();
		_properties.MeleeDefense += actor.calculateSpecialistBonus(8);
		_properties.RangedDefense += actor.calculateSpecialistBonus(8);
		if (actor.getCurrentProperties().IsSpecializedInStaves)
		{
			_properties.MeleeSkill += actor.calculateSpecialistBonus(6, specialistWeapon);
		}
	}
});
