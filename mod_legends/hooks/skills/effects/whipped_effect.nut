::mods_hookExactClass("skills/effects/whipped_effect", function(o) {

	o.m.TurnsLeft = 3;

	o.getTooltip = function ()
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
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+" + (12 + this.m.Level) + "[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+" + (14 + this.m.Level) + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%negative%]-" + (5 + this.m.Level) + "[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%positive%]+" + (9 + this.m.Level) + "[/color] Initiative"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+" + (5 + this.m.Level) + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+" + (5 + this.m.Level) + "[/color] Ranged Defense"
			}
		];
	}

	o.onAdded = function ()
	{
		this.m.TurnsLeft = 3;
		local actor = this.getContainer().getActor();
		actor.getSprite("status_sweat").setBrush("bust_slave_whipped");
		actor.setDirty(true);
	}

	o.onRefresh = function ()
	{
		this.m.TurnsLeft = 3;
	}

	o.onUpdate = function ( _properties )
	{
		_properties.MeleeSkill += 12 + this.m.Level;
		_properties.RangedSkill += 14 + this.m.Level;
		_properties.Bravery -= (5 + this.m.Level);
		_properties.MeleeDefense += 5 + this.m.Level;
		_properties.RangedDefense += 5 + this.m.Level;
		_properties.Initiative += 9 + this.m.Level;
		local actor = this.getContainer().getActor();
		actor.getSprite("status_sweat").setBrush(this.m.TurnsLeft > 1 ? "bust_slave_whipped" : "bust_slave_whipped_expiring");
		actor.setDirty(true);
	}
});
