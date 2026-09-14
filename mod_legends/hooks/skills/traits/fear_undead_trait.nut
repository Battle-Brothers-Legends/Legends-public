::mods_hookExactClass("skills/traits/fear_undead_trait", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Some past event or particularly convincing story in this character\'s life has left them scared of what the walking dead are capable of, making this character less reliable when facing the undead on the battlefield.";
		this.m.Excluded.extend([
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendPragmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendTalented)
		]);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local ret = getTooltip();
		ret.extend([{
			id = 10,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "[color=%negative%]-5%[/color] Melee Skill when in battle with undead"
		},
		{
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=%negative%]-5%[/color] Ranged Skill when in battle with undead"
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
			_properties.Bravery -= 10;
			_properties.MeleeSkillMult *= 0.95;
			_properties.RangedSkillMult *= 0.95;
			// Make this a status effect so it will be visible for the battle
			this.m.Type = ::Const.SkillType.StatusEffect;
		} else {
			// Make this a trait so it will not be visible for the battle
			this.m.Type = ::Const.SkillType.Trait;
		}
	}
});
