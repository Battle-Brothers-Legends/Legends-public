::mods_hookExactClass("skills/actives/flail_skill", function(o) {
	o.m.IsChain <- false;
	o.m.IsRanged <- false;

	o.setItem <- function (_item) {
		if (this.m.IsRanged) {
			this.m.Description = "Flailing at an opponent over some distance. Somewhat unpredictable in damage, but able to strike over or around shield cover.";
			this.m.Icon = "skills/active_65.png";
			this.m.IconDisabled = "skills/active_65_sw.png";
			this.m.Overlay = "active_65";
			this.m.ActionPointCost = 5;
			this.m.MinRange = 1;
			this.m.MaxRange = 2;
		}
		if (this.m.IsChain)
		{
			this.m.Name = "Chain Flail";
			this.m.MaxRange = 3;
			this.m.Icon = "skills/active_62.png";
			this.m.IconDisabled = "skills/active_62_sw.png";
			this.m.Overlay = "active_62";
			this.m.HitChanceBonus = -10;
		}
		this.skill.setItem(_item);
	}

	o.getTooltip = function() {
		local ret = this.getDefaultTooltip();
		if (this.m.IsRanged) {
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=%positive%]2[/color] tiles"
			});

			if (!::Legends.S.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties(), this.getItem())) {
				ret.push({
					id = 6,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
				});
			}
		}
		else if (this.m.IsChain) {
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=%positive%]3[/color] tiles"
			});
		}

		return ret;
	}

	o.onAfterUpdate = function ( _properties ) {
		if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) && this.m.IsRanged) {
			this.m.ActionPointCost -= 1;
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
		}
		this.m.FatigueCostMult = _properties.IsSpecializedInFlails ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties ) {	
		if (_skill != this) {
			return;
		}
		if (this.m.IsChain) {
			_properties.MeleeSkill -= 10;
		}
		else if (this.m.isRanged && _targetEntity != null && !::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1) {
			this.m.HitChanceBonus += -15;
			_properties.MeleeSkill += -15;
		}
	}

});
