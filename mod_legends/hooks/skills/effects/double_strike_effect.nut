::mods_hookExactClass("skills/effects/double_strike_effect", function (o) {
	o.m.DualWieldBonusActive <- false;
	o.m.DualWieldBonusAP <- -1;
	o.m.DualWieldBonusDamageMult <- 0.1;
	o.m.DoubleStrikeBonusDamageMult <- 0.25;
	o.m.DoubleStrikeFatigueCostMult <- 0.20;

	local create = o.create;
	o.create = function () {
		create();
		this.m.Icon = "skills/status_effect_doublestrike.png";
		this.m.IconMini = "mini_doublestrike_circle";
	}

	o.getDescription = function () {
		return "Having just landed a hit, this character is ready to perform a powerful follow-up strike! If the attack misses, the damage bonus is wasted.";
	}

	o.getTooltip <- function ()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "The next attack costs [color=%positive%]" + (this.m.DoubleStrikeFatigueCostMult * 100) + "%[/color] less Fatigue"
			},
			{
				id = 3,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "The next attack inflicts [color=%positive%]" + (this.m.DoubleStrikeBonusDamageMult * 100) + "%[/color] more damage"
			}

		];
		if (this.m.DualWieldBonusActive) {
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Next main hand attack inflicts [color=%positive%]" + (this.m.DualWieldBonusDamageMult * 100) + "%[/color] more damage"
			});
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "Next main hand attack costs [color=%positive%]" + (this.m.DualWieldBonusAP * -1) + "[/color] less AP"
			});
		}
		return ret;
	}

	o.onAdded = function () {}

	o.onAnySkillUsed = function (_skill, _targetEntity, _properties) {
		if (!_skill.isAttack()) {
			return;
		}

		if (_targetEntity == null || !_targetEntity.isAttackable()) {
			return;
		}

		if (!this.m.IsGarbage && this.m.TimeAdded + 0.1 < ::Time.getVirtualTimeF() && !_targetEntity.isAlliedWith(this.getContainer().getActor())) {
			local actor = this.getContainer().getActor();
			local totalDamageMult = 1 + this.m.DoubleStrikeBonusDamageMult;
			if (::Legends.Weapons.isDualWieldingWeaponType(actor, ::Const.Items.WeaponType.Dagger) && ::Legends.Weapons.isMainHandSkill(actor, _skill) && this.m.DualWieldBonusActive)	{
				totalDamageMult *= 1 + this.m.DualWieldBonusDamageMult;
			}
			_properties.DamageTotalMult *= totalDamageMult;
		}
	}

	o.onAfterUpdate <- function (_properties) {
		local actor = this.getContainer().getActor();

		if (!::Legends.Weapons.isDualWieldingWeaponType(actor, ::Const.Items.WeaponType.Dagger)) {
			this.m.DualWieldBonusActive = false;
		}

		foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active)) {
			if (skill.isAttack()) {
				if (this.m.DualWieldBonusActive && ::Legends.Weapons.isMainHandSkill(actor, skill)) {
					_properties.SkillCostAdjustments.push({
						ID = skill.getID(),
						APAdjust = this.m.DualWieldBonusAP,
						FatigueMultAdjust = 0.8
					});
				} else {
					_properties.SkillCostAdjustments.push({
						ID = skill.getID(),
						FatigueMultAdjust = 0.8
					});
				}
			}
		}
	}

	o.onTurnEnd <- function () {
		this.removeSelf();
	}

	o.onTargetHit <- function (_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		local actor = this.getContainer().getActor();
		if (::Legends.Weapons.isDualWieldingWeaponType(actor, ::Const.Items.WeaponType.Dagger) && ::Legends.Weapons.isOffHandSkill(actor, _skill)) {
			this.m.DualWieldBonusActive = true;
		}
		if (!::Legends.S.isEntityNullOrDead(actor)) {
			actor.setDirty(true);
		}
	}

	o.onTargetMissed <- function (_skill, _targetEntity) {
		this.removeSelf();
		local actor = _skill.getContainer().getActor();
		if (!::Legends.S.isEntityNullOrDead(actor)) {
			actor.setDirty(true);
		}
	}

	o.onCombatFinished <- function () {
		this.removeSelf();
	}
});
