::mods_hookExactClass("skills/actives/throw_balls", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Delay = 750;
		this.m.HitChanceBonus = 20;
	}

	o.getTooltip = function () {
		local ret = this.getDefaultTooltip();
		local ammo = this.getAmmo();
		ret.extend([{
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
		}]);

		if (ammo > 0) {
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=%positive%]%_ammo%[/color] spiked balls left",
				param = [["_ammo", ammo]]
			});
		}
		else {
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]No spiked balls left[/color]"
			});
		}

		if (::Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions())) {
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	o.isUsable = function () {
		local isUsable = !::Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0;
		if (this.getContainer().hasPerk(::Legends.Perk.LegendPointBlank))
			return isUsable;

		return isUsable && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}
	
	o.onTargetHit <- function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor ) {
		if (_skill != this) {
			return;
		}

		if (::Legends.S.isEntityNullOrDead(this.getContainer().getActor(), _targetEntity)) {
			return;
		}
			
		if (_bodyPart != ::Const.BodyPart.Body) {
			return;
		}

		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendConstrained);
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties ) {
		onAfterUpdate(_properties);
		if (this.getContainer().hasPerk(::Legends.Perk.LegendPointBlank)) {
			this.m.MinRange = 1;
		}
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			_properties.RangedSkill += this.m.HitChanceBonus;
			_properties.HitChanceAdditionalWithEachTile -= 10;
		}
	}
});
