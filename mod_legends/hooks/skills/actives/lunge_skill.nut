::mods_hookExactClass("skills/actives/lunge_skill", function(o)
{
	o.m.isGreatLunge <- false;

	o.setItem <- function (_item)
	{
		this.skill.setItem(_item);
		if (this.m.isGreatLunge)
		{
			this.m.Name = "Great Lunge";
			this.m.Description = "A stronger lunge towards a target 2 tiles away, followed by a precise thrusting attack to catch them unprepared. The faster you are, the more damage you do.";
			this.m.ActionPointCost = 5;
			this.m.FatigueCost = 30;
		}
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		onAnySkillUsed(_skill, _targetEntity, _properties);
		if (_skill == this)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
			}
		}
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function (_properties) {
		onAfterUpdate(_properties);
		if (::Legends.Perks.has(this.getContainer(), ::Legends.Perk.LegendFreedomOfMovement)) {
			this.m.FatigueCostMult *= 0.5;
		}
	}
});
