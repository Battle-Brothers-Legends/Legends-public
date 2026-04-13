::mods_hookExactClass("skills/actives/cleave", function(o)
{
	o.m.IsScytheCleave <- false;

	o.setItem <- function (_item) {
		if (this.m.IsScytheCleave) {
			this.m.Description = "A sweeping cleave that can be used from behind the frontline and can inflict bleeding wounds if there is no armor absorbing the blow and if the target is able to bleed at all.";
			this.m.KilledString = "Cleaved";
			this.m.Icon = "skills/active_61.png";
			this.m.IconDisabled = "skills/active_61_sw.png";
			this.m.Overlay = "active_61";
			this.m.FatigueCost = 15;
			this.m.MinRange = 1;
			this.m.MaxRange = 2;
		}
		this.skill.setItem(_item);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function() {
		if (!this.m.IsScytheCleave)
			return getTooltip();

		local ret = this.getDefaultTooltip();
		local dmg = this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5;
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]2" + "[/color] tiles"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts additional stacking [color=%damage%]" + dmg + "[/color] bleeding damage per turn, for 2 turns"
		});
		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms) {
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}
		return ret;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties ) {
		if (this.m.IsScytheCleave) {
			this.m.FatigueCostMult = _properties.IsSpecializedInPolearms ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
			this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 5 : 6;
		}
		else {
			onAfterUpdate(_properties);
		}
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties ) {
		if (_skill == this && this.m.IsScytheCleave) {
			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1) {
				this.m.HitChanceBonus += -15;
				_properties.MeleeSkill += -15;
			}
		}
	}

	o.onUse = function ( _user, _targetTile ) {
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (::Legends.S.isEntityNullOrDead(_user))
			return success;

		if (success)
			::Legends.S.applyBleed(target, _user, hp, this.m.SoundsA, this.m.SoundsB);

		return success;
	}
});
