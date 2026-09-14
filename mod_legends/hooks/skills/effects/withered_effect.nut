::mods_hookExactClass("skills/effects/withered_effect", function(o) {

	o.m.TurnsLeft = 3;

	o.getDescription = function ()
	{
		return "By means of rotten magic, this character has withered to have the physique of an old man. Will slowly wear off over [color=%negative%]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

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
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=%negative%]-" + this.m.TurnsLeft * 10 + "%[/color] Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-" + this.m.TurnsLeft * 10 + "%[/color] Initiative"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]-" + this.m.TurnsLeft * 10 + "%[/color] Max Fatigue"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]-" + this.m.TurnsLeft * 5 + "[/color] Fatigue Recovery per turn"
			}
		];
	}

	o.onUpdate = function ( _properties )
	{
		local actor = this.getContainer().getActor();
		_properties.DamageTotalMult *= 1.0 - this.m.TurnsLeft * 0.10;
		_properties.InitiativeMult *= 1.0 - this.m.TurnsLeft * 0.10;
		_properties.StaminaMult *= 1.0 - this.m.TurnsLeft * 0.10;
		_properties.FatigueRecoveryRate -= this.m.TurnsLeft * 5;

		if (actor.hasSprite("status_stunned") && !this.getContainer().hasEffect(::Legends.Effect.Stunned))
		{
			actor.getSprite("status_stunned").setBrush("bust_withered");
			actor.getSprite("status_stunned").Visible = true;
			actor.setDirty(true);
		}
	}
});
