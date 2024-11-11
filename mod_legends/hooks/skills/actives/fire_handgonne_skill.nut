::mods_hookExactClass("skills/actives/fire_handgonne_skill", function(o)
{
	o.m.AdditionalAccuracy = 10;
	o.m.AdditionalHitChance = -10;
	
	o.getTooltip = function ()
	{
		local ret = this.getRangedTooltip(this.getDefaultTooltip());
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 6 targets"
		});

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] shots left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Needs a non-empty powder bag equipped[/color]"
			});
		}

		if (!this.getItem().isLoaded())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Must be reloaded before firing again[/color]"
			});
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}

		if (this.getContainer().hasSkill("perk.legend_piercing_shot"))
		{
			local s = this.getContainer().getSkillByID("perk.legend_piercing_shot");
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/positive.png",
				text = "Max Range [color=" + this.Const.UI.Color.PositiveValue + "]+" + s.m.BonusRange + "[/color] from " + s.getName()
			});
		}

		return ret;
	}
});
