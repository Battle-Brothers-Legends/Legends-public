::mods_hookExactClass("ai/tactical/behaviors/ai_attack_deathblow", function (o) {
	o.onEvaluate = function (_entity) {
		local score = this.ai_attack_default.onEvaluate(_entity) / ::Const.AI.Behavior.Score.Attack * ::Const.AI.Behavior.Score.Deathblow;

		if (score > 0) {
			this.getAgent().getBehavior(::Const.AI.Behavior.ID.AttackDefault).m.Score *= 0.25;
		} else if (this.behavior.selectSkill(this.getAgent().getBehavior(::Const.AI.Behavior.ID.AttackDefault).m.PossibleSkills) == null && this.selectSkill(this.m.PossibleSkills) != null) {
			return this.onlyDeathblowEvaluate(_entity);
		}

		return score;
	}

	o.onlyDeathblowEvaluate <- function (_entity) {
		this.m.TargetTile = null;
		this.m.Skill = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < ::Const.Movement.AutoEndTurnBelowAP || _entity.getMoraleState() == ::Const.MoraleState.Fleeing || !this.getAgent().hasVisibleOpponent()) {
			return ::Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null) {
			return ::Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local myTile = _entity.getTile();
		local targets = this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange() + (this.m.Skill.isRanged() ? myTile.Level : 0), this.m.Skill.getMaxLevelDifference());

		if (targets.len() == 0) {
			return ::Const.AI.Behavior.Score.Zero;
		}

		local bestTarget = this.m.Skill.isRanged() ? this.queryBestRangedTarget(_entity, this.m.Skill, targets) : this.queryBestMeleeTarget(_entity, this.m.Skill, targets);

		if (bestTarget.Target == null) {
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (this.getAgent().getIntentions().IsChangingWeapons) {
			score *= ::Const.AI.Behavior.AttackAfterSwitchWeaponMult;
		}

		this.m.TargetTile = bestTarget.Target.getTile();
		return ::Math.max(0, ::Const.AI.Behavior.Score.Attack * bestTarget.Score * score); // using regular attack score rather than deathblow since its our only attack
	}

	o.queryBestMeleeTarget = function (_entity, _skill, _targets) {
		local bestTargets = [];
		for (local i = _targets.len() - 1; i >= 0; i = --i) {
			local targetStatus = _targets[i].getSkills();
			local bonus = false;

			if (::Legends.S.isEntityMovementDisabled(_targets[i])) {
				bonus = true;
			}

			foreach (skill in _skill.m.ApplicableSkills) {
				if (targetStatus.hasEffect(skill)) {
					bonus = true;
				}
			}
			if (bonus) {
				bestTargets.push(_targets[i]);
			}
		}

		if (bestTargets.len() == 0) {
			bestTargets = _targets; // use full array if nothing is good
		}

		return this.behavior.queryBestMeleeTarget(_entity, _skill, bestTargets);
	}

	o.queryBestRangedTarget = function (_entity, _skill, _targets, _maxRange = 0) {
		local bestTargets = [];
		for (local i = _targets.len() - 1; i >= 0; i = --i) {
			local targetStatus = _targets[i].getSkills();
			local bonus = false;

			if (::Legends.S.isEntityMovementDisabled(_targets[i])) {
				bonus = true;
			}

			foreach (skill in _skill.m.ApplicableSkills) {
				if (targetStatus.hasEffect(skill)) {
					bonus = true;
				}
			}
			if (bonus) {
				bestTargets.push(_targets[i]);
			}
		}

		if (bestTargets.len() == 0) {
			bestTargets = _targets; // use full array if nothing is good
		}

		return this.behavior.queryBestRangedTarget(_entity, _skill, bestTargets, _maxRange);
	}
});
