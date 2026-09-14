::mods_hookExactClass("ai/tactical/behaviors/ai_hex", function (o) {

	o.findBestTarget = function (_entity, _targets) {
		local bestScore = 0.0;
		local bestTarget;
		local dotDamage = 0;
		local effects = _entity.getSkills().getAllSkillsOfType(this.Const.SkillType.DamageOverTime);

		foreach (dot in effects) {
			dotDamage = dotDamage + dot.getDamage();
		}

		foreach (opponent in _targets) {
			local target = opponent.Actor;
			local opponentTile = opponent.Actor.getTile();

			if (!this.m.Skill.isUsableOn(opponentTile)) {
				continue;
			}

			local score = 10.0;

			if (target.getSkills().hasEffect(::Legends.Effect.HexSlave)) {
				continue;
			}

			score = score * (target.getHitpointsPct() * (100.0 / target.getHitpoints()));
			score = score * (1.0 + target.getLevel() * this.Const.AI.Behavior.HexCharacterLevelMult);

			if (target.getHitpoints() <= dotDamage) {
				score = score * this.Const.AI.Behavior.HexDOTCanKillMult;
			}

			if (target.isPlayerControlled()) {
				if (target.getLevel() <= 2 && this.getStrategy().getAveragePlayerLevel() >= 6 && target.getArmorMax(this.Const.BodyPart.Body) + target.getArmorMax(this.Const.BodyPart.Head) <= this.getStrategy().getAveragePlayerArmor() * 0.4) {
					score = score * this.Const.AI.Behavior.LikelyPlayerBaitMult;
				}
			}

			if (this.getAgent().getForcedOpponent() != null && this.getAgent().getForcedOpponent().getID() == target.getID())
			{
				score = score * 100.0;
			}

			if (target.getSkills().hasActive(::Legends.Active.Indomitable)) {
				score = score * this.Const.AI.Behavior.HexAgainstIndomitable;
			}

			if (this.isKindOf(target, "player")	|| this.isKindOf(target, "firstborn") || this.isKindOf(target, "envoy")) {
				score = score * this.Const.AI.Behavior.HexPreferPlayerMult;
			}

			if ((target.getSkills().hasEffect(::Legends.Effect.Charmed) || target.getSkills().hasEffect(::Legends.Effect.LegendIntenselyCharmed)) && !this.isKindOf(target, "player")) {
				score = score * this.Const.AI.Behavior.HexNotAGoodTargetMult;
			}

			score = score * target.getCurrentProperties().TargetAttractionMult;

			if (score > bestScore) {
				bestScore = score;
				bestTarget = target;
			}
		}

		return {
			Target = bestTarget,
			Score = bestScore * 0.1
		};
	}
});
