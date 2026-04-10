::mods_hookExactClass("skills/actives/rupture", function(o)
{
	o.m.IsMeleeRupture <- false;

	local create = o.create;
	o.create = function() {
		create();
		this.m.HitChanceBonus = 5;
	}

	o.setItem <- function (_item)
	{
		this.skill.setItem(_item);
		if (this.m.IsMeleeRupture)
		{
			this.m.Description = "A thrusting attack that can tear bleeding wounds if not stopped by armor.";
			this.m.MaxRange = 1;
			this.m.FatigueCost = 13;
			this.m.DirectDamageMult = 0.25;
			this.m.HitChanceBonus = 5;
			this.m.InjuriesOnBody = this.Const.Injury.CuttingAndPiercingBody;
			this.m.InjuriesOnHead = this.Const.Injury.CuttingAndPiercingHead;
		}
	}

	o.getTooltip = function () {
		local tooltip = this.getDefaultTooltip();
		if (!this.m.IsMeleeRupture)
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]2[/color] tiles"
		});
		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && !this.m.IsMeleeRupture) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}
		local dmg = this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms ? 10 : 5;
		tooltip.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts additional stacking [color=%damage%]" + dmg + "[/color] bleeding damage per turn, for 2 turns"
		});

		return tooltip;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function(_properties)
	{
		onAfterUpdate(_properties);
		if (this.m.IsMeleeRupture) {
			this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 4 : 5;
		}
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			_properties.MeleeSkill += 5;

			if (this.m.IsMeleeRupture)
				return;
			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1) {
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -10;
			}
		}
	}

	o.onUse = function ( _user, _targetTile ) {
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectImpale);
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());
		local damage = this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms ? 10 : 5;
		if (::Legends.S.isEntityNullOrDead(_user))
			return success;

		if (success)
			::Legends.S.applyBleed(target, _user, hp, this.m.BleedingSounds, this.m.SoundOnHit, damage);

		return success;
	}

});
