::mods_hookExactClass("ai/tactical/behaviors/ai_attack_swallow_whole", function (o) {
	o.m.PossibleSkills.push(::Legends.Actives.getID(::Legends.Active.LegendSkinGhoulSwallowWhole));

	o.getBestTarget = function (_entity, _skill, _targets) {
		local bestTarget;
		local bestScore = 0.0;

		foreach (target in _targets.filter(@(_, _target) (_skill.onVerifyTarget(_entity.getTile(), target.getTile()) && target.getHitpoints() > 10))) {
			local c = target.getCurrentProperties();
			local score = 0.0 + c.getMeleeDefense() + c.getMeleeSkill() * 0.25 + target.getHitpoints() * 0.25;
			score += (target.getArmor(::Const.BodyPart.Body) * (c.HitChance[::Const.BodyPart.Body] / 100.0) + target.getArmor(::Const.BodyPart.Head) * (c.HitChance[::Const.BodyPart.Head] / 100.0)) * 0.1;
			score *= c.TargetAttractionMult * c.AggroMult;

			if (score > bestScore) {
				bestTarget = target;
				bestScore = score;
			}
		}

		return {
			Target = bestTarget,
			Score = bestScore * 0.01
		};
	}
});
