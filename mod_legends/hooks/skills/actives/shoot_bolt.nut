::mods_hookExactClass("skills/actives/shoot_bolt", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted+1;
		this.m.HitChanceBonus = 15;
	}

	o.getTooltip = function () {
		local tooltip = this.getDefaultTooltip();

		local ammo = this.getAmmo();

		if (ammo > 0) {
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=%positive%]%_ammo%[/color] bolts left",
				param = [["_ammo", ammo]]
			});
		}
		else {
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Needs a non-empty quiver of bolts equipped[/color]"
			});
		}

		if (this.getContainer().hasPerk(::Legends.Perk.LegendBallistics)) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "Up to [color=%positive%]+20%[/color] of any damage ignores armor depending on the distance to the target, with the highest bonus in melee and lowest at maximum range"
			});
		}

		if (!this.getItem().isLoaded()) {
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Must be reloaded before firing again[/color]"
			});
		}

		return tooltip;
	}

	o.onAfterUpdate = function ( _properties ) {
		this.m.FatigueCostMult = _properties.IsSpecializedInCrossbows ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.DirectDamageMult = _properties.IsSpecializedInCrossbows ? 0.7 : 0.5;
	}

	o.onUse = function( _user, _targetTile ) {
		local success = this.attackEntity(_user, _targetTile.getEntity());
		this.getItem().setLoaded(false);
		return success;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill != this && _skill.getID() != ::Legends.Actives.getID(::Legends.Active.LegendStrafingRun))
			return;

		if (::Legends.S.isEntityNullOrDead(_targetEntity))
			return;

		this.m.HitChanceBonus += this.m.Item.getAdditionalAccuracy();
		_properties.RangedSkill += this.m.HitChanceBonus;
		_properties.HitChanceAdditionalWithEachTile -= 3;
		if (_properties.IsSharpshooter) {
			_properties.DamageDirectMult += 0.05;
		}

		if (_skill == this && this.getContainer().hasPerk(::Legends.Perk.LegendBallistics)) {
			local distance = this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile());
			_properties.DamageDirectAdd += 0.25 - (distance * 0.05);
		}
	}
});
