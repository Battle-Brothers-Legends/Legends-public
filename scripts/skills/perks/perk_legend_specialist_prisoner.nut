this.perk_legend_specialist_prisoner <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistPrisoner);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IconMini = "perk_spec_dagger_mini.png";
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return this.getDefaultSpecialistSkillDescription("Daggers");
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
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, _specialistWeapon) + "[/color] Melee Skill"
		});
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "You acquire the Deathblow ability when wielding any dagger" 
		});
		if (actor.getCurrentProperties().IsSpecializedInDaggers)
		{
			tooltip.push({
				id = 7,
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
			case !item.isWeaponType(this.Const.Items.WeaponType.Dagger):
				return this.getNoSpecialistWeaponTooltip();
			case item.getID() == "weapon.knife" || item.getID() == "weapon.legend_shiv":
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
			case !item.isWeaponType(this.Const.Items.WeaponType.Dagger):
				return;
			case item.getID() == "weapon.knife" || item.getID() == "weapon.legend_shiv":
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

		if (!actor.getFlags().has("knifeSpecialist"))
		{
			actor.getFlags().add("knifeSpecialist");
		}

		if (actor.getCurrentProperties().IsSpecializedInDaggers)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}

	function onRemoved()
	{
		this.getContainer().getActor().getFlags().remove("knifeSpecialist");
	}

});
