this.legend_specialist_abstract <- this.inherit("scripts/skills/skill", {
	m = {
		SkillTypeBonus = "" // "ranged", "melee", "both"
		ApplicableItemTypes = [],
		ApplicableWeaponTypes = [],
		SpecialistWeaponIds = [],
		SpecialistItemTypes = [],
		SpecialistWeaponTypes = [],
		ExcludedItemTypes = [],
		ExcludedWeaponTypes = [],
		ValidEntities = [],
		BonusDamage = null,
		BonusRanged = null,
		BonusMelee = null
	},
	function create()
	{
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function specialistWeaponTooltip(_item, _isRanged) // just declared
	{
		return []; // expects a list of tooltips
	}

	// check if you have bonus ie butcher counts for cleavers but not whips so you add cleaver to ApplicableWeaponTypes but add whip in ExcludedWeaponTypes
	function hasBonus(_item)
	{
		if (hasSpecialistWeapon(_item))
			return true;
		local included = false;
		foreach (type in this.m.ApplicableItemTypes)
		{
			if (_item.isItemType(type))
			{
				included = true;
				break;
			}
		}
		if (!included && this.m.ApplicableItemTypes.len() > 0)
			return false;

		included = false;
		foreach (type in this.m.ApplicableWeaponTypes)
		{
			if (_item.isWeaponType(type))
			{
				included = true;
				break;
			}
		}
		if (!included && this.m.ApplicableWeaponTypes.len() > 0)
			return false;
		foreach (type in this.m.ExcludedItemTypes)
		{
			if (_item.isItemType(type))
			{
				return false;
			}
		}
		foreach (type in this.m.ExcludedWeaponTypes)
		{
			if (_item.isWeaponType(type))
			{
				return false;
			}
		}
		return true;
	}

	// check for specialist weapon as that'll return max bonus
	function hasSpecialistWeapon(_item)
	{
		foreach (id in this.m.SpecialistWeaponIds)
		{
			if (_item.getID() == id)
			{
				return true;
			}
		}

		foreach (type in this.m.SpecialistItemTypes)
		{
			if (_item.isItemType(type))
			{
				return true;
			}
		}

		foreach (type in this.m.SpecialistWeaponTypes)
		{
			if (_item.isWeaponType(type))
			{
				return true;
			}
		}
		return false;
	}

	// calculates the bonuses based on 3 options - level, week or camp training
	function calculateSpecialistBonus( _stat, _item)
	{
		local actor = this.getContainer().getActor();
		if (this.hasSpecialistWeapon(_item) || !actor.isPlayerControlled())
		{
			return _stat;
		}

		if (::Legends.Mod.ModSettings.getSetting("SpecialistSkillsSetting").getValue() == "Week in company")
		{
			local daysCompany = this.Math.floor(actor.getDaysWithCompany() / 7);
			return this.Math.floor(0.01 * this.Math.min(5 * daysCompany + 25, 100) * _stat);
		}
		else if (::Legends.Mod.ModSettings.getSetting("SpecialistSkillsSetting").getValue() == "Level")
		{
			return this.Math.floor(0.01 * this.Math.min(5 * actor.getLevel() + 25, 100) * _stat);
		}
		else if (::Legends.Mod.ModSettings.getSetting("SpecialistSkillsSetting").getValue() == "Training")
		{
			local training = ::Legends.Traits.get(actor, ::Legends.Trait.LegendIntensiveTraining);
			if (training == null)
			{
				return 0;
			}

			return this.Math.floor(0.01 * this.Math.min(5 * training.getStatsIncreased() + 25, 100) * _stat);
		}
		else
		{
			return 0;
		}
	}

	// valid target to double bonuses vs certain entities
	function validTarget( _targetID)
	{
		foreach (entity in this.m.ValidEntities)
		{
			if (_targetID == entity)
			{
				return true;
			}
		}
		return false;
	}

	// actual bonuses applied here, if you have additional bonuses on the skill ie cultist do it like this
	// function onAnySkillUsed( _skill, _targetEntity, _properties )
	// {
	// 	this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties )
	// 	your custom stuff here
	// }

	function onAnySkillUsedSpecialistChecks(_skill)
	{
		if (_skill == null)
			return false;

		local item = _skill.getItem();

		if (item == null)
			return false;

		if (!item.isItemType(this.Const.Items.ItemType.Weapon))
			return false;

		if (!this.hasBonus(item))
			return false;

		return true;
	}

	function onUpdate( _properties )
	{
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!this.onAnySkillUsedSpecialistChecks(_skill))
			return;

		local validTarget = _targetEntity != null && this.validTarget(_targetEntity.getType());
		local hitBonus = 0;
		local item = _skill.getItem();
		if (this.m.BonusMelee != null && !_skill.isRanged())
		{
			hitBonus = this.calculateSpecialistBonus(this.m.BonusMelee, item) * (validTarget ? 2 : 1);
			_properties.MeleeSkill += hitBonus;
			_skill.m.HitChanceBonus += hitBonus;
		}
		else if (this.m.BonusRanged != null && _skill.isRanged())
		{
			hitBonus = this.calculateSpecialistBonus(this.m.BonusRanged, item) * (validTarget ? 2 : 1);
			_properties.RangedSkill += hitBonus;
			// _skill.m.HitChanceBonus += hitBonus;
			_skill.m.AdditionalAccuracy += hitBonus;
		}

		if (::Legends.S.isCharacterWeaponSpecialized(_properties, item) && this.m.BonusDamage != null)
		{
			_properties.DamageTotalMult *= 1.0 + 0.01 * this.calculateSpecialistBonus(this.m.BonusDamage, item) * (validTarget ? 2 : 1);
		}
		_skill.m.AdditionalTooltip = this.specialistWeaponTooltip(item, _skill.isRanged()); // extends any custom bonuses (not hitchance or damage related) in default skill tooltip
	}
});
