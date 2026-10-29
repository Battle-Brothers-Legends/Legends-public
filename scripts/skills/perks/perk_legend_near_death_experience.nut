this.perk_legend_near_death_experience <- this.inherit("scripts/skills/skill", {
	m = {
		HpDamageReceived = 0,
		Injuries = [],
		InjuriesCountThisBattle = 0,
		Bonus = 0
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendNearDeathExperience);
		this.m.Description = "Your often and close experience with near death has left you robust and resilient.";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Only receive [color=%positive%]" + (100 - this.m.Bonus * 5) + "%[/color] of any damage to hitpoints from attacks"
		});
		return tooltip;
	}

	function isHidden() {
		return this.m.Bonus < 1;
	}

	function onBeforeDamageReceived(_attacker, _skill, _hitInfo, _properties) {
		this.m.Injuries.extend(this.getContainer().query(::Const.SkillType.Injury));
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance()) {
			return;
		}

		_properties.DamageReceivedRegularMult *= (1.0 - this.m.Bonus * 0.05);
	}

	function onDamageReceived(_attacker, _damageHitpoints, _damageArmor) {
		this.m.HpDamageReceived += _damageHitpoints;
	}

	function onAfterDamageReceived() {
		local num = this.getContainer().query(::Const.SkillType.Injury).len() - this.m.Injuries.len();
		if (num > 0) {
			this.m.InjuriesCountThisBattle += num;
		}
	}

	function onUpdate(_properties) {
		this.m.Bonus = ::Math.min(6, this.getContainer().query(::Const.SkillType.Injury).len());
		_properties.Bravery += ::Math.floor(this.m.Bonus * 3);
	}

	function onCombatStarted() {
		this.m.HpDamageReceived = 0;
		this.m.InjuriesCountThisBattle = 0;
	}

	function onCombatFinished() {
		if (::Tactical.isActive()) {
			local actor = this.getContainer().getActor();
			local xp = this.m.HpDamageReceived + (this.m.InjuriesCountThisBattle * 20);
			if (actor.getLevel() >= 12) {
				xp *= 0.1;
			}
			actor.addXP(xp);
			actor.updateLevel();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]-" + (this.m.Bonus * 5) + "%[/color] " + ::Legends.S.inlineIcon("damage_received");
	}
});
