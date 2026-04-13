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
		ret.extend([
			{
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Apply Constrained on a hit to the body for a turn"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Constrained increases the fatigue and AP cost of moving"
			}
		]);

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=%positive%]" + ammo + "[/color] spiked balls left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]No spiked balls left[/color]"
			});
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	o.isUsable = function ()
	{
		local isUsable = !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0;
		if (this.getContainer().hasPerk(::Legends.Perk.LegendPointBlank))
			return isUsable;

		return isUsable && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}
	
	o.onTargetHit <- function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill != this)
			return;

		if (::Legends.S.skillEntityAliveCheck(this.getContainer().getActor(), _targetEntity))
			return;
			
		if (_bodyPart != ::Const.BodyPart.Body)
			return;

		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendConstrained);
	}

	o.onAfterUpdate = function ( _properties )
	{
		if (this.getContainer().hasPerk(::Legends.Perk.LegendPointBlank))
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
