::mods_hookExactClass("skills/actives/throw_axe", function(o)
{
	o.m.AdditionalAccuracy = 20;
	o.m.AdditionalHitChance = -10;

	local create = o.create;
	o.create = function () {
		create();
		this.m.MinRange = 1;
		this.m.Delay = 150;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingAndBluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingAndBluntHead;
	}

	o.getTooltip = function () {
		local tooltip = this.getRangedTooltip(this.getDefaultTooltip());

		local ammo = this.getAmmo();
		if (ammo > 0) {
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=%positive%]%_ammo%[/color] axes left",
				param = [["_ammo", ammo]]
			});
		}
		else {
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]No axes left[/color]"
			});
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions())) {
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
	}

	o.getAmmo = function () {
		local item = this.getItem();

		if (item == null) {
			return 0;
		}

		return item.getAmmo();
	}

	o.consumeAmmo = function () {
		local item = this.getItem();

		if (item != null) {
			item.consumeAmmo();
		}
	}

	o.isUsable = function () {
		local isUsable = !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0;
		if (this.getContainer().hasPerk(::Legends.Perk.LegendPointBlank)) {
			return isUsable;
		}

		return isUsable && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	o.onAfterUpdate = function ( _properties ) {
		this.m.FatigueCostMult = ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.AdditionalAccuracy = 20 + this.m.Item.getAdditionalAccuracy();
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}
});
