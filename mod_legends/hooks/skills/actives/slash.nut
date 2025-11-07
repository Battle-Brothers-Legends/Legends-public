::mods_hookExactClass("skills/actives/slash", function(o)
{
	o.m.IsGreatSlash <- false;

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
	}

	o.getTooltip = function()
	{
		return this.getDefaultTooltip();
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

			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
			}
		}
	}

});
