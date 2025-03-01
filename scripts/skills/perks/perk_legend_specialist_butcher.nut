this.perk_legend_specialist_butcher <- this.inherit("scripts/skills/skill", {
	m = {
		SoundsA = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		],
		SoundsB = [
			"sounds/combat/chop_hit_01.wav",
			"sounds/combat/chop_hit_02.wav",
			"sounds/combat/chop_hit_03.wav"
		];
	}
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistButcher);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.IconMini = "perk_spec_butcher_mini.png";
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

function getDescription()
	{
		return this.getDefaultSpecialistSkillDescription("Cleavers (but not Whips)");
	}

	function specialistWeaponTooltip(_specialistWeapon = false)
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
			text = "Applies [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] Bleeding Damage to every attack" 
		});
		if (actor.getCurrentProperties().IsSpecializedInCleavers)
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
			case item.isWeaponType(this.Const.Items.WeaponType.Whip):
			case !item.isWeaponType(this.Const.Items.WeaponType.Cleaver):
				return getNoSpecialistWeaponTooltip();
			case item.getID() == "weapon.butchers_cleaver" || item.getID() == "weapon.legend_named_butchers_cleaver":
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
			case item.isWeaponType(this.Const.Items.WeaponType.Whip):
				return;
			case !item.isWeaponType(this.Const.Items.WeaponType.Cleaver):
				return;
			case item.getID() == "weapon.butchers_cleaver" || item.getID() == "weapon.legend_named_butchers_cleaver":
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInCleavers)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}

	function onTargetHit ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{

		if (!_targetEntity.isAlive() || _targetEntity.isDying())
		{
			return false;
		}
		
		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding)
		{
			return false;
		}

		if (_targetEntity.isNonCombatant())
		{
			return false;
		}

		local user = _skill.getContainer().getActor();
		local item = user.getMainhandItem();
		if (item == null || item.isWeaponType(this.Const.Items.WeaponType.Whip) || !item.isWeaponType(this.Const.Items.WeaponType.Cleaver))
			return;

		_targetEntity.getSkills().add(this.new("scripts/skills/effects/legend_grazed_effect"));

		if (!user.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " filleted " + this.Const.UI.getColorizedEntityName(_targetEntity) + " leaving them grazed");
		}
	
		return true;	
	}

});
