::mods_hookExactClass("skills/actives/throw_axe", function(o)
{
	o.m.AdditionalAccuracy = 20;
	o.m.AdditionalHitChance = -10;

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Delay = 750;
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
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] axes left"
			});
		}
		else
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]No axes left[/color]"
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

	o.onAfterUpdate = function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.AdditionalAccuracy = 20 + this.m.Item.getAdditionalAccuracy();
	}

	o.onAnySkillUsed = function ( _user, _targetTile )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}
});
