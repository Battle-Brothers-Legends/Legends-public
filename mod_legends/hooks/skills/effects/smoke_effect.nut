::mods_hookExactClass("skills/effects/smoke_effect", function(o) {
	
	o.getTooltip = function()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]50%[/color] Ranged Damage received decrease"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=%negative%]-10[/color] Vision"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Not affected by Zones of Control and will hide you"
			}
		];
	}
	o.onUpdate = function( _properties )
	{
		this.skill.onUpdate(_properties);
		local actor = this.getContainer().getActor();
		local tile = this.getContainer().getActor().getTile();
		//local target = _targetTile.getEntity();

		if (tile.Properties.Effect == null || tile.Properties.Effect.Type != "smoke")
		{
			this.removeSelf();
		}
		else
		{
			actor.getSkills().add(::new("scripts/skills/terrain/hidden_effect"));		
			_properties.RangedSkillMult *= 0.5;
			_properties.DamageReceivedRangedMult *= 0.5;
			_properties.Vision -= 10;
			
		}
		return true;
	}
});
