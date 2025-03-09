this.legend_specialist_abstract <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpecialistSkill = true,
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

	// this func needs item for the checks, it's inside the default tooltip of skill.nut
	function getSpecialistWeaponTooltip(_item, _isRanged)
	{
		if (!hasBonus(_item))
			return [];

		return specialistWeaponTooltip(_item, _isRanged);
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
		foreach (type in this.m.ApplicableItemTypes)
		{
			if (!item.isItemType(type))
			{
				return false;
			}
		}

		foreach (type in this.m.ApplicableWeaponTypes)
		{
			if (!item.isWeaponType(type))
			{
				return false;
			}
		}

		foreach (type in this.m.ExcludedItemTypes)
		{
			if (item.isItemType(type))
			{
				return false;
			}
		}

		foreach (type in this.m.ExcludedWeaponTypes)
		{
			if (item.isWeaponType(type))
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
			if (item.getID() == id)
			{
				return true;
			}
		}

		foreach (type in this.m.SpecialistItemTypes)
		{
			if (item.isItemType(type))
			{
				return true;
			}
		}

		foreach (type in this.m.SpecialistWeaponTypes)
		{
			if (item.isWeaponType(type))
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

		if (::Legends.Mod.ModSettings.getSetting("SpecialistSkillsSetting").getValue() == "Week in company (SSU Style)")
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

		if (item != null)
			return false;

		if (!item.isItemType(this.Const.Items.ItemType.Weapon))
			return false;

		if (!this.hasBonus(item))
			return false;

		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!onAnySkillUsedSpecialistChecks(_skill))
			return;

		local validTarget = __targetEntity != null && this.validTarget(_targetEntity.getType());
		local actor = this.getContainer().getActor();
		local hitBonus = 0;
		if (this.m.BonusMelee != null && !_skill.isRanged())
		{
			hitBonus = actor.calculateSpecialistBonus(this.m.BonusMelee, _item) * (validTarget ? 2 : 1);
			_properties.MeleeSkill += hitBonus;
			_skill.m.HitChanceBonus += hitBonus;
		}
		else if (this.m.BonusRanged != null && _skill.isRanged())
		{
			hitBonus = actor.calculateSpecialistBonus(this.m.BonusRanged, _item) * (validTarget ? 2 : 1);
			_properties.RangedSkill += hitBonus;
			_skill.m.HitChanceBonus += hitBonus;
		}

		if (::Legends.S.isCharacterWeaponSpecialized(_properties, item))
		{
			_properties.DamageTotalMult *= 1.0 + 0.01 * actor.calculateSpecialistBonus(this.m.BonusDamage, _item) * (validTarget ? 2 : 1);
		}
	}
});
