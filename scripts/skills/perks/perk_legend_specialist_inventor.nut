this.perk_legend_specialist_inventor <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistInventor);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IconMini = "perk_spec_firearm_mini.png";
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription ()
	{
		return this.getDefaultSpecialistSkillDescription("Melee Firearms and Attack Skill and Reload Action Point reduction while using Ranged Firearms or Crossbows.");
	}

	function specialistWeaponTooltip (_specialistWeapon = false)
	{
		local actor = this.getContainer().getActor();
		if (actor.calculateSpecialistBonus(12, _specialistWeapon) == 0)
			return this.getNoSpecialistWeaponTooltip();

		local item = actor.getMainhandItem();
		local tooltip = this.skill.getTooltip();
		
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, _specialistWeapon) + "[/color] Ranged Skill"
		})
		if (actor.getCurrentProperties().IsSpecializedInCrossbows)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Reduces Reload AP cost for Handgonnes and Crossbows by [color=" + this.Const.UI.Color.NegativeValue + "]1[/color]"
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
		local melee = false;
		switch (true) 
		{
			case item == null:
				return getNoSpecialistWeaponTooltip();
			case item.isWeaponType(this.Const.Items.WeaponType.Spear) && item.isWeaponType(this.Const.Items.WeaponType.Firearm):
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, false) + "[/color] Melee Skill"
				});
				if (actor.getCurrentProperties().IsSpecializedInSpears)
				{
					tooltip.push({
						id = 7,
						type = "text",
						icon = "ui/icons/damage_dealt.png",
						text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(6, specialistWeapon) + "-" + actor.calculateSpecialistBonus(16, specialistWeapon) + "[/color] Damage"
					});
				}
				return tooltip;
			}
			case !(item.isWeaponType(this.Const.Items.WeaponType.Firearm) || item.isWeaponType(this.Const.Items.WeaponType.Crossbow)):
				return getNoSpecialistWeaponTooltip();
			case item.isWeaponType(this.Const.Items.WeaponType.Firearm):
				specialistWeapon = true;
		}

		return specialistWeaponTooltip(specialistWeapon);
	}


	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		switch (true) 
		{
			case item == null:
				return;
			case item.isWeaponType(this.Const.Items.WeaponType.Spear) && item.isWeaponType(this.Const.Items.WeaponType.Firearm):
				return handleSpears( _properties );
			case !(item.isWeaponType(this.Const.Items.WeaponType.Firearm) || item.isWeaponType(this.Const.Items.WeaponType.Crossbow)):
				return;
			case item.isWeaponType(this.Const.Items.WeaponType.Firearm):
				specialistWeapon = true;
		}

		_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInCrossbows && !actor.getFlags().has("inventorSpecialist"))
		{
			actor.getFlags().add("inventorSpecialist");
		}
	}

	function handleSpears( _properties )
	{	
		local actor = this.getContainer().getActor();
		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, true);

		if (actor.getCurrentProperties().IsSpecializedInSpears)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, true);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, true);
		}
	}
});
