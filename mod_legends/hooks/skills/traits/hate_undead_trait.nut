::mods_hookExactClass("skills/traits/hate_undead_trait", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Excluded.push(::Legends.Traits.getID(::Legends.Trait.LegendPeaceful));
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local ret = getTooltip();
		ret.extend([{
			id = 10,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Melee Skill when in battle with undead"
		},
		{
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Ranged Skill when in battle with undead"
		}]);

		return ret;
	}

	o.onUpdate = function ( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			// If not in battle, then this should be a trait and not a status effect
			this.m.Type = ::Const.SkillType.Trait;
			return;
		}

		local fightingUndead = false;
		local enemies = this.Tactical.Entities.getAllHostilesAsArray();

		foreach( enemy in enemies )
		{
			if (this.Const.EntityType.getDefaultFaction(enemy.getType()) == this.Const.FactionType.Zombies || this.Const.EntityType.getDefaultFaction(enemy.getType()) == this.Const.FactionType.Undead)
			{
				fightingUndead = true;
				break;
			}
		}

		if (fightingUndead)
		{
			_properties.Bravery += 10;
			_properties.MeleeSkillMult *= 1.05;
			_properties.RangedSkillMult *= 1.05;
			// Make this a status effect so it will be visible for the battle
			this.m.Type = ::Const.SkillType.StatusEffect;
		} else {
			// Make this a trait so it will not be visible for the battle
			this.m.Type = ::Const.SkillType.Trait;
		}
	}
});
