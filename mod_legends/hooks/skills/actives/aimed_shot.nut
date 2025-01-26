::mods_hookExactClass("skills/actives/aimed_shot", function(o)
{
	o.m.AdditionalAccuracy = 10;
	o.m.AdditionalHitChance = -2;

	o.getTooltip = function ()
	{
		local tooltip = this.getRangedTooltip(this.getDefaultTooltip());

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] arrows left"
			});
		}
		else
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Needs a non-empty quiver of arrows equipped[/color]"
			});
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		// change it to use these values properly over vanilla code
		if (_skill == this) {
			_properties.RangedSkill -= 10;
			_properties.HitChanceAdditionalWithEachTile -= -2;
		}
		onAnySkillUsed(_skill, _targetEntity, _properties);
	}
});
