::mods_hookExactClass("skills/actives/quick_shot", function(o)
{
	o.m.AdditionalHitChance = -4;

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.MaxRange = 7;
	}

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
				text = "Has [color=%positive%]" + ammo + "[/color] arrows left"
			});
		}
		else
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Needs a non-empty quiver of arrows equipped[/color]"
			});
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		onAfterUpdate(_properties);
		local bonusRange = (_properties.IsSpecializedInBows ? 1 : 0) + (this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistSharpshooter) ? 1 : 0);
		this.m.MaxRange = this.m.Item.getRangeMax() + bonusRange - 1;
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		// change it to use these values properly over vanilla code
		if (_skill == this) {
			_properties.HitChanceAdditionalWithEachTile -= -4;
		}
		onAnySkillUsed(_skill, _targetEntity, _properties);
	}
});
