this.perk_legend_double_strike <- this.inherit("scripts/skills/skill", {
	m = {
		DualWieldBonusActive = false,
		DualWieldBonusAP = -1,
		DualWieldBonusDamageTotalMult = 0.1
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendDoubleStrike);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function isHidden() {
		return !this.m.DualWieldBonusActive;
	}

	function getTooltip() {
		local ret = this.skill.getTooltip();
		if (this.m.DualWieldBonusActive) {
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Next mainhand attack costs [color=%positive%]" + this.m.DualWieldBonusAP + "[/color] AP and deals [color=%positive%]" + (this.m.DualWieldBonusDamageTotalMult * 100) + "%[/color] more damage"
			});
		}
		return ret;
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		local actor = this.getContainer().getActor();

		if (!_targetEntity.isAlliedWith(actor)
			&& !actor.getSkills().hasEffect(::Legends.Effect.DoubleStrike))
		{
			::Legends.Effects.grant(actor, ::Legends.Effect.DoubleStrike);
		}

		if (::Legends.Weapons.isDualWieldingWeaponType(actor, ::Const.Items.WeaponType.Dagger)
			&& ::Legends.Weapons.isOffHandSkill(actor, _skill))
		{
			this.m.DualWieldBonusActive = true;
		}
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		local actor = this.getContainer().getActor();
		if (!this.m.DualWieldBonusActive || !::Legends.Weapons.isDualWieldingWeaponType(actor, ::Const.Items.WeaponType.Dagger)) {
			return;
		}
		if (::Legends.Weapons.isMainHandSkill(actor, _skill)) {
			_skill.m.ActionPointCost += this.m.DualWieldBonusAP;
			_properties.DamageTotalMult *= (1.0 + this.m.DualWieldBonusDamageTotalMult);
		}
	}

	function onAfterAnySkillExecuted(_skill, _targetTile, _targetEntity, _forFree) {
		local actor = this.getContainer().getActor();
		if (!this.m.DualWieldBonusActive || !::Legends.Weapons.isDualWieldingWeaponType(actor, ::Const.Items.WeaponType.Dagger)) {
			return;
		}
		if (::Legends.Weapons.isMainHandSkill(actor, _skill)) {
			this.m.DualWieldBonusActive = false;
		}
	}

	function onTurnStart() {
		this.m.DualWieldBonusActive = false;
	}

	function onCombatFinished() {
		this.m.DualWieldBonusActive = false;
	}
});
