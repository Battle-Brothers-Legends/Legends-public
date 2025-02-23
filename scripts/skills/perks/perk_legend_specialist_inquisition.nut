this.perk_legend_specialist_inquisition <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_inquisition";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistInquisition;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistInquisition;
		this.m.Icon = "ui/perks/perk_spec_xbow.png";
		// this.m.IconMini = "perk_spec_xbow_mini.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription ()
	{
		return this.getDefaultSpecialistSkillDescription("Crossbows");
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
			icon = "ui/icons/ranged_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, _specialistWeapon) + "[/color] Ranged Skill"
		});
		if (actor.getCurrentProperties().IsSpecializedInCrossbows)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(6, _specialistWeapon) + "-" + actor.calculateSpecialistBonus(16, _specialistWeapon) + "[/color] Damage"
			});
		}
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Doubles these bonuses against Alps and Hexe"
		});
		return tooltip;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local off = actor.getOffhandItem(); 
		local specialistWeapon = false;
		switch (true)
		{
			case item == null && off == null:
				return getNoSpecialistWeaponTooltip();
			case item != null && item.getID() == "weapon.legend_wooden_stake":
			{
				tooltip.extend([
				{
					id = 6,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, false) + "[/color] Melee Skill"
				},
				{
					id = 7,
					type = "text",
					icon = "ui/icons/damage_dealt.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(10, specialistWeapon) + "[/color] Damage"
				}]);
				return tooltip;
			}
			case off != null && off.getID() != "weapon.legend_hand_crossbow":
			case item != null && !item.isWeaponType(this.Const.Items.WeaponType.Crossbow):
				return getNoSpecialistWeaponTooltip();
			case off != null && off.getID() == "weapon.legend_hand_crossbow":
			case item != null && item.getID() == "weapon.goblin_crossbow":
				specialistWeapon = true;
		}

		return specialistWeaponTooltip(specialistWeapon);
	}

	function validTarget( _targetID)
	{
		if (_targetID == this.Const.EntityType.Hexe || _targetID == this.Const.EntityType.Alp)
			return true;
		return false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || _skill == null)
			return;

		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local off = actor.getOffhandItem();
		local specialistWeapon = false;

		if (item == null && off == null)
			return;

		if (_skill.getID() == "actives.shoot_bolt" || _skill.getID() == "actives.shoot_stake" || _skill.getID() == "actives.legend_piercing_bolt")
		{
			if ((off != null && off.getID() == "weapon.legend_hand_crossbow") || (item != null && item.getID() == "weapon.goblin_crossbow"))
				specialistWeapon = true;
			if (this.validTarget(_targetEntity.getType()))
			{
				_properties.RangedSkill += actor.calculateSpecialistBonus(24, specialistWeapon);

				if (actor.getCurrentProperties().IsSpecializedInCrossbows)
				{
					_properties.DamageRegularMin += actor.calculateSpecialistBonus(12, specialistWeapon);
					_properties.DamageRegularMax += actor.calculateSpecialistBonus(32, specialistWeapon);
				}
			}
			else
			{
				_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

				if (actor.getCurrentProperties().IsSpecializedInCrossbows)
				{
					_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
					_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
				}
			}
		}
		if (item != null && item.getID() == "weapon.legend_wooden_stake" && (_skill.getID() == "actives.puncture" || _skill.getID() == "actives.legend_wooden_stake_stab"))
		{
			if (this.validTarget(_targetEntity.getType()))
			{
				_properties.MeleeSkill += actor.calculateSpecialistBonus(24, true);
				_properties.DamageRegularMin += actor.calculateSpecialistBonus(20, true);
				_properties.DamageRegularMax += actor.calculateSpecialistBonus(20, true);
			}
			else
			{
				_properties.MeleeSkill += actor.calculateSpecialistBonus(12, true);
				_properties.DamageRegularMin += actor.calculateSpecialistBonus(10, true);
				_properties.DamageRegularMax += actor.calculateSpecialistBonus(10, true);
			}
		}
	}
});
