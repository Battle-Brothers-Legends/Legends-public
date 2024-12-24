::mods_hookExactClass("skills/actives/throw_balls", function(o)
{
	o.m.AdditionalAccuracy <- 20;
	o.m.AdditionalHitChance <- -10;

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Delay = 750;
	}

	o.getTooltip = function ()
	{
		local ret = this.getRangedTooltip(this.getDefaultTooltip());
		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] spiked balls left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]No spiked balls left[/color]"
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

		return ret;
	}

	o.isUsable = function ()
	{
		local isUsable = !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0;
		if (bro.getSkills().hasPerk(::Const.Perks.PerkDefs.LegendCloseCombatArcher))
			return isUsable;

		return isUsable && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	o.onAfterUpdate = function ( _properties )
	{
		if (bro.getSkills().hasPerk(::Const.Perks.PerkDefs.LegendCloseCombatArcher))
		{
			this.m.MinRange = 1;
			this.m.MaxRange = 3;
		}
		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		// this.m.AdditionalAccuracy = 20 + this.m.Item.getAdditionalAccuracy();
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}
});
