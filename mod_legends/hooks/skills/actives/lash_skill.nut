::mods_hookExactClass("skills/actives/lash_skill", function (o) {
	o.m.IsRanged <- false

	o.setItem <- function (_item) {
		if (this.m.IsRanged) {
			this.m.Description = "Flailing at an opponent over some distance. Somewhat unpredictable in damage, but able to strike over or around shield cover.";
			this.m.Icon = "skills/active_92.png";
			this.m.IconDisabled = "skills/active_92_sw.png";
			this.m.Overlay = "active_92";
			this.m.ActionPointCost = 5;
			this.m.MinRange = 1;
			this.m.MaxRange = 2;
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

		return ret;
	}

	o.onAfterUpdate = function ( _properties ) {
		if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) && this.m.IsRanged) {
			this.m.ActionPointCost -= 1;
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.IsShieldRelevant = false;
		}
		this.m.FatigueCostMult = _properties.IsSpecializedInFlails ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties ) {	
		if (_skill != this) {
			return;
		}
		_properties.HitChance[this.Const.BodyPart.Head] += 100.0;
		else if (this.m.isRanged && _targetEntity != null && !::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1) {
			this.m.HitChanceBonus += -15;
			_properties.MeleeSkill += -15;
		}
	}
});
