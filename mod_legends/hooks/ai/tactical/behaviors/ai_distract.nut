::mods_hookExactClass("ai/tactical/behaviors/ai_distract", function (o) {
	o.getBestTarget = function (_entity, _skill, _targets) {
		local myTile = _entity.getTile();
		local attackSkill = _entity.getSkills().getAttackOfOpportunity();
		local apRequiredForAttack = attackSkill != null ? attackSkill.getActionPointCost() : 4;
		local bestTarget;
		local bestScore = 0.0;

		foreach (target in _targets.filter(@(_, _target)(!target.isNonCombatant() && _skill.onVerifyTarget(_entity.getTile(), target.getTile()) && target.getMoraleState() != ::Const.MoraleState.Fleeing && (target.getFatigue() < target.getFatigueMax() - 5)))) {
			local c = target.getCurrentProperties();
			if (c.IsStunned || !c.IsAbleToUseWeaponSkills || ::Legends.Effects.has(target, ::Legends.Effect.Dazed) || ::Legends.Effects.has(target, ::Legends.Effect.Distracted)) {
				continue;
			}

			local zoc = target.getTile().getZoneOfControlCountOtherThan(target.getAlliedFactions());

			if (target.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null && target.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand).isItemType(::Const.Items.ItemType.RangedWeapon) && zoc > 0) {
				continue;
			}

			if (myTile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 1 && target.getTile().getZoneOfControlCountOtherThan(target.getAlliedFactions()) == 1 && _entity.getActionPoints() >= apRequiredForAttack && attackSkill != null && attackSkill.getHitchance(target) >= 20) {
				continue;
			}

			local score = target.getHitpoints() / target.getHitpointsMax() * (_skill.getHitchance(target) * 0.01);

			if (attackSkill != null) {
				local damage = attackSkill.getExpectedDamage(target);

				if ((target.getHitpoints() > damage.HitpointDamage + damage.DirectDamage) && damage.HitpointDamage >= ::Const.Combat.InjuryMinDamage) {
					local threshold = _entity.getCurrentProperties().ThresholdToInflictInjuryMult * ::Const.Combat.InjuryThresholdMult * c.ThresholdToReceiveInjuryMult;
					local dmg = damage.HitpointDamage / (target.getHitpointsMax() * 1.0);

					if (threshold * 0.25 <= dmg) {
						score *= ::Const.AI.Behavior.DistractPreferInjuryMult;
					}
				}
			}

			score *= (0.5 + c.getMeleeSkill() * 0.01 * 0.5) * (c.getRegularDamageAverage() * 0.01 * 0.5) * c.DamageReceivedTotalMult;
			score *= ::Math.maxf(0.5, 1.5 - c.TargetAttractionMult) * c.AggroMult;

			if (!target.isTurnDone()) {
				score *= ::Const.AI.Behavior.DistractYetToActMult;
			}

			if (target.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null && target.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand).isItemType(::Const.Items.ItemType.TwoHanded) && target.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand).isItemType(::Const.Items.ItemType.MeleeWeapon)) {
				score *= ::Const.AI.Behavior.DistractPriorityMult;
			}

			if (target.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null && target.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand).isAoE()) {
				score *= ::Const.AI.Behavior.DistractPriorityMult;
			}

			if (::Legends.Perks.hasAny(target, ::Legends.Perk.Dodge, ::Legends.Perk.Overwhelm) || ::Legends.Actives.has(target, ::Legends.Active.Lunge)) {
				score *= ::Const.AI.Behavior.DistractInitiativeMult;
			}

			if (::Legends.Perks.has(target, ::Legends.Perk.Berserk) || ::Legends.Effects.has(target, ::Legends.Effect.KillingFrenzy)) {
				score *= ::Const.AI.Behavior.DistractInitiativeMult;
			}

			if (::Legends.Effects.has(target, ::Legends.Effect.Shieldwall)) {
				score *= ::Const.AI.Behavior.DistractVSShieldwallMult;
			}

			if (::Legends.Actives.has(target, ::Legends.Active.Taunt)) {
				score *= ::Const.AI.Behavior.DistractVSTaunterMult;
			}

			if (apRequiredForAttack <= _entity.getActionPoints() && _entity.getXPValue() >= 300) {
				score *= ::Const.AI.Behavior.DistractAsEliteMult;
			}

			local targetTile = target.getTile();
			local highValueAlliesAdjacentToTarget = [0, 1, 2, 3, 4, 5];
			highValueAlliesAdjacentToTarget.filter(@(_, _direction) targetTile.hasNextTile(_direction)).map(@(_direction) targetTile.getNextTile(_direction)).filter(@(_, _tile)(_tile.IsOccupiedByActor && _tile.getEntity().isAlliedWith(_entity) && _tile.getEntity().getCurrentProperties().TargetAttractionMult > 1.0));
			foreach (_ in highValueAlliesAdjacentToTarget) {
				score *= ::Const.AI.Behavior.DistractPriorityMult;
			}

			if (target.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null && target.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand).isAoE() && zoc > 1) {
				score *= ::Math.pow(::Const.AI.Behavior.DistractSurroundedTargetMult, zoc - 1);
			}

			if (this.getStrategy().getStats().AlliesVSEnemiesRatio < 1.0) {
				score *= ::Math.maxf(0.5, this.getStrategy().getStats().AlliesVSEnemiesRatio);
			}

			if (score > bestScore) {
				bestTarget = target;
				bestScore = score;
			}

		}

		return {
			Target = bestTarget,
			Score = bestScore
		};
	}
});
