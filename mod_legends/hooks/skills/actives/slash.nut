::mods_hookExactClass("skills/actives/slash", function(o)
{
	o.m.IsGreatSlash <- false;
	o.m.IsStaffSlash <- false;

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
		else if (this.m.IsStaffSlash)
		{
			this.m.Description = "A swift slashing attack dealing average damage that can cover the distance of 2 tiles and can be used from behind the frontline, outside the range of most melee weapons.";
			this.m.FatigueCost = 13;
			this.m.MaxRange = 2;
			this.m.ActionPointCost = 5;
		}
	}

	o.getTooltip = function ()
	{
		return this.getDefaultTooltip();
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function( _properties )
	{
		if (this.m.IsStaffSlash)
		{
			this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 4 : 5;
		}

		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendSpecialistHerbalist) && this.m.Item != null && (this.m.Item.getID() == "weapon.sickle" || this.m.Item.getID() == "weapon.named_sickle"))
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

			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
			}
		}
	}

});
