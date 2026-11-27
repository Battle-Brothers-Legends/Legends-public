::mods_hookExactClass("ai/tactical/behaviors/ai_attack_default", function (o) {
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.LegendCatBite),
		::Legends.Actives.getID(::Legends.Active.LegendWhiteWolfBite),
		::Legends.Actives.getID(::Legends.Active.LegendRedbackSpiderBite),
		::Legends.Actives.getID(::Legends.Active.LegendDemonHoundBite),
		::Legends.Actives.getID(::Legends.Active.LegendHorseKick),
		::Legends.Actives.getID(::Legends.Active.LegendDonkeyKick),
		::Legends.Actives.getID(::Legends.Active.LegendBearBite),
		::Legends.Actives.getID(::Legends.Active.LegendFlagellate),
		::Legends.Actives.getID(::Legends.Active.Lunge),
		::Legends.Actives.getID(::Legends.Active.LegendIntoTheFray),
		::Legends.Actives.getID(::Legends.Active.LegendNightmareTouch),
		::Legends.Actives.getID(::Legends.Active.LegendBasiliskPeck),
		::Legends.Actives.getID(::Legends.Active.LegendBasiliskSentryInject),
		::Legends.Actives.getID(::Legends.Active.LegendBasiliskSentryFowleye),
		::Legends.Actives.getID(::Legends.Active.LegendSighthoundBite),
		::Legends.Actives.getID(::Legends.Active.LegendHeartseeker),
		::Legends.Actives.getID(::Legends.Active.LegendBucklerBash),
		::Legends.Actives.getID(::Legends.Active.LegendThrowKnife),
		// ::Legends.Actives.getID(::Legends.Active.LegendHaftstrike), // this bad boy makes the enemies attack with weak attacks for no reason
		::Legends.Actives.getID(::Legends.Active.LegendHew),
		::Legends.Actives.getID(::Legends.Active.LegendBreach),
		::Legends.Actives.getID(::Legends.Active.LegendFlowingSlash),
		::Legends.Actives.getID(::Legends.Active.LegendBackstab),
		::Legends.Actives.getID(::Legends.Active.LegendCull),
		::Legends.Actives.getID(::Legends.Active.Deathblow) // added temporarily until we figure out what to do, as of now katar wielding assassins never attack
	]);

	// A weapon can have attacks with different ranges now, like a Pike with Impale and Heartseekers
	// Basically it would pick one at random and then roll with it, so if it rolled a range 1 attack it would just afk like a goober
	o.selectSkill <- function (_potentialSkills) {
		local entity = this.getAgent().getActor();
		local level = entity.getTile().Level;
		local skills = [];

		foreach (id in _potentialSkills) {
			local skill = entity.getSkills().getSkillByID(id);

			if (skill == null || !skill.isUsable() || !skill.isAffordable()) {
				continue;
			}

			foreach (target in this.queryTargetsInMeleeRange(skill.getMinRange(), skill.getMaxRange() + (skill.isRanged() ? level : 0), skill.getMaxLevelDifference())) {
				if (skill.isUsableOn(target.getTile())) {
					skills.push(id);
					break;
				}
			}
		}

		return this.behavior.selectSkill(skills);
	}
});
