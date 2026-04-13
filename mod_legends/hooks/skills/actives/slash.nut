::mods_hookExactClass("skills/actives/slash", function(o)
{
	o.m.IsGreatSlash <- false;
	o.m.IsBreachSlash <- false;
	o.m.IsGreatBreachSlash <- false;

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HitChanceBonus = 10;
	}
	
	o.setItem <- function (_item)
	{
		this.skill.setItem(_item);
		if (this.m.IsGreatSlash)
		{
			this.m.Name = "Great Slash";
			this.m.Description = "A hefty swift slashing attack dealing average damage.";
			this.m.DirectDamageMult = 0.25;
			this.m.FatigueCost = 13;
		}
		else if (this.m.IsBreachSlash)
		{
			this.m.Name = "Breach";
			this.m.Description = "A swift slashing attack making good use of the light blade of the weapon to maneuver around longer weapons.";
		}
		else if (this.m.IsGreatBreachSlash)
		{
			this.m.Name = "Breach";
			this.m.Description = "A swift slashing attack making good use of the light blade of the weapon to maneuver around longer weapons.";
			this.m.DirectDamageMult = 0.25;
			this.m.FatigueCost = 13;
		}
	}

	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		if (this.m.IsBreachSlash || this.m.IsGreatBreachSlash)
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%positive%]15%[/color] extra damage done against enemies armed with polearms or melee weapons that can strike over a distance"
			});
		return ret;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function( _properties )
	{
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendSpecialistHerbalist) && this.m.Item != null && (this.m.Item.getID() == "weapon.sickle" || this.m.Item.getID() == "weapon.legend_named_sickle"))
		{
			this.m.ActionPointCost = _properties.IsSpecializedInSwords ? 3 : 4;
		}

		onAfterUpdate(_properties);
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += 10;

			if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()))
			{
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
				if ((this.m.IsBreachSlash || this.m.IsGreatBreachSlash) && _targetEntity != null && _targetEntity.isArmedWithPoleWeapon())
				{
					_properties.DamageTotalMult *= 1.15;
				}
			}
		}
	}

});
