// content is [<trait const>, <related talent>], talents make traits appear more often
::Legends.Training <- {
	CostTrainingBase = 100,
	CostTrainingScaled = 75,
	CostRerollBase = 20000,
	CostRerollScaled = 2500,
	Traits = [
		[::Legends.Trait.EagleEyes, ::Const.Attributes.RangedSkill],
		[::Legends.Trait.Tough, ::Const.Attributes.Hitpoints],
		[::Legends.Trait.Strong, ::Const.Attributes.Fatigue],
		[::Legends.Trait.Quick, ::Const.Attributes.Initiative],
		[::Legends.Trait.Fearless, ::Const.Attributes.Bravery],
		[::Legends.Trait.Determined, ::Const.Attributes.Bravery],
		[::Legends.Trait.Deathwish, ::Const.Attributes.Bravery],
		[::Legends.Trait.Brave, ::Const.Attributes.Bravery],
		[::Legends.Trait.Dexterous, ::Const.Attributes.MeleeSkill],
		[::Legends.Trait.SureFooting, ::Const.Attributes.MeleeDefense],
		[::Legends.Trait.IronLungs, ::Const.Attributes.Fatigue],
		[::Legends.Trait.Athletic, ::Const.Attributes.Initiative],
		[::Legends.Trait.IronJaw, ::Const.Attributes.MeleeDefense],
		[::Legends.Trait.Swift, ::Const.Attributes.RangedDefense],
		[::Legends.Trait.Teamplayer, ::Const.Attributes.MeleeDefense],
		[::Legends.Trait.LegendSteadyHands, ::Const.Attributes.RangedSkill],
		[::Legends.Trait.LegendMartial, ::Const.Attributes.MeleeSkill],
		[::Legends.Trait.Survivor, ::Const.Attributes.Hitpoints],
		[::Legends.Trait.LegendUnpredictable, ::Const.Attributes.Initiative]
	],

	// returns trait const
	addRandomTrainingTrait = function (_bro) {
		local trainingTrait = ::Legends.Traits.get(_bro, ::Legends.Trait.LegendIntensiveTraining);
		local rng = ::Legends.LCG.get(trainingTrait.m.TrainingSeed);

		local traits = _bro.getSkills().query(::Const.SkillType.Trait);
		local talents = _bro.getTalents();
		local traitLookup = [];
		foreach(entry in ::Legends.Training.Traits) {
			traitLookup.push(entry[0]);
			local stars = talents[entry[1]];
			for(local i = 0; i < stars; i++)
				traitLookup.push(entry[0]);
		}

		local newTraitConst = null;
		local newTrait;

		while (newTraitConst == null) {
			newTraitConst = traitLookup[::Math.abs(rng.nextState() % traitLookup.len())];
			if (::Legends.Traits.has(_bro, newTraitConst)) {
				newTraitConst = null;
				continue;
			}

			newTrait = this.new(::Legends.Traits.TraitDefObjects[newTraitConst].Script);

			local skipTrait = false;
			foreach(bTrait in traits) {
				if (newTrait.isExcluded(bTrait.getID())) {
					newTraitConst = null;
					break;
				}
			}
		}

		trainingTrait.m.TrainingSeed = rng.getState();

		_bro.getSkills().add(newTrait);

		if (newTrait.getContainer() != null)
			newTrait.addTitle();

		return newTraitConst;
	}
};
