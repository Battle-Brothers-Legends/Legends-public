::mods_hookExactClass("skills/traits/addict_trait", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
	}

	o.getTooltip = function ()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		local time = 0.0;

		if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
		{
			time = this.World.State.getCombatStartTime();
		}
		else
		{
			time = this.Time.getVirtualTimeF();
		}

		local isAffected = time - this.getContainer().getActor().getFlags().get("PotionLastUsed") >= 5.0 * this.World.getTime().SecondsPerDay;

		if (isAffected)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%negative%]-10%[/color] Resolve"
			});
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+10%[/color] Melee Skill"
			});
			ret.push({
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-10%[/color] Ranged Skill"
			});
			ret.push({
				id = 14,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-10%[/color] Melee Defense"
			});
			ret.push({
				id = 15,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-10%[/color] Ranged Defense"
			});
		}
		else
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Currently no effect because drugs were consumed within the last 5 days"
			});
		}

		return ret;
	}

	o.onUpdate = function ( _properties )
	{
		local time = 0.0;

		if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
		{
			time = this.World.State.getCombatStartTime();
		}
		else
		{
			time = this.Time.getVirtualTimeF();
		}

		local isAffected = time - this.getContainer().getActor().getFlags().get("PotionLastUsed") >= 7.0 * this.World.getTime().SecondsPerDay;

		if (isAffected)
		{
			_properties.BraveryMult *= 0.9;
			_properties.MeleeSkillMult *= 1.1;
			_properties.RangedSkillMult *= 0.9;
			_properties.MeleeDefenseMult *= 0.9;
			_properties.RangedDefenseMult *= 0.9;
		}
	}
});
