this.perk_legend_specialist_cultist <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistCultist);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IconMini = "perk_spec_cultist_mini.png";
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return this.getDefaultSpecialistSkillDescription("Flails and Whips");
	}

	function specialistWeaponTooltip (_specialistWeapon = false)
	{
		local actor = this.getContainer().getActor();
		if (actor.calculateSpecialistBonus(12, _specialistWeapon) == 0)
			return this.getNoSpecialistWeaponTooltip();

		local item = actor.getMainhandItem();
		local tooltip = this.skill.getTooltip();
		
		tooltip.extend([{
			id = 7,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, _specialistWeapon) + "[/color] Melee Skill"
		},
		{
			id = 8,
			type = "text",
			icon = "ui/tooltips/chance_to_hit_head.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(15, _specialistWeapon) + "[/color] Chance to hit Head"
		}]);
		if (actor.getCurrentProperties().IsSpecializedInFlails || actor.getCurrentProperties().IsSpecializedInCleavers)
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

	function hybridWeaponTooltip (_specialistWeapon)
	{
		local actor = this.getContainer().getActor();
		if (actor.calculateSpecialistBonus(8, false) == 0)
			return this.getNoSpecialistWeaponTooltip();

		local item = actor.getMainhandItem();
		local tooltip = this.skill.getTooltip();

		tooltip.extend([{
			id = 6,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(8, false) + "[/color] Melee Skill"
		},
		{
			id = 8,
			type = "text",
			icon = "ui/tooltips/chance_to_hit_head.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(10, false) + "%[/color] Chance to hit Head"
		}]);
		if (actor.getCurrentProperties().IsSpecializedInFlails)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(4, _specialistWeapon) + "-" + actor.calculateSpecialistBonus(12, _specialistWeapon) + "[/color] Damage"
			});
		}
		return tooltip;;
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
			case item.getID() == "weapon.orc_flail_2h" || item.getID() == "weapon.named_orc_flail_2h":
				return hybridWeaponTooltip(false);
			case !item.isItemType(this.Const.Items.ItemType.Cultist):
				return getNoSpecialistWeaponTooltip();
			case item.getID() == "weapon.legend_cat_o_nine_tails":
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
				return;
			case item.getID() == "weapon.orc_flail_2h" || item.getID() == "weapon.named_orc_flail_2h":
				return handleNoneCultist( _properties );
			case !item.isItemType(this.Const.Items.ItemType.Cultist):
				return;
			case item.getID() == "weapon.legend_cat_o_nine_tails":
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		_properties.HitChance[this.Const.BodyPart.Head] += actor.calculateSpecialistBonus(15, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInFlails)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}

	function handleNoneCultist( _properties )
	{
		local actor = this.getContainer().getActor();
		_properties.MeleeSkill += actor.calculateSpecialistBonus(8, false);
		_properties.HitChance[this.Const.BodyPart.Head] += actor.calculateSpecialistBonus(10, false);

		if (actor.getCurrentProperties().IsSpecializedInFlails)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(4, false);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(12, false);
		}


	}
});
