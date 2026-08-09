this.training_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		Results = [],
		NumBros = 0,
		UnTrained = 0,
		BaseCraft = 0.15, // was 1.0, changed tp 0.4 6/11/21 - Luft - dropped to 0.15 by poss 7/3/2023
		TrainingDescriptors = {
			M = ["Short Guard ", "Upper Snake Guard ", "Bastard Cross ", "The Middle Iron Door ", "thrusts ", "trips ", "grapples ", "foot passing ", "striking ", "vambrace traps ", "a pommel bash ", "half sword ", "The Thumb Scissor ", "jabs ", "hand to hand combat "],
    		T = ["for hours, ", "all day, ", "for several hours, ", "until exhaustion, ", "as long as possible, "],
     		A = [" feels ready for a fight", " needs a real opponent", " is prepared for battle", " is keen to try it out", " is ready for a scrap"],
		}
	},
	function create()
	{
		this.camp_building.create();
		this.m.ID = ::Legends.Camp.CampBuildings.Training;
		this.m.ModName = "Training";
		this.m.Slot = "train";
		this.m.Name = "Training Grounds";
		this.m.Description = "Training";
		this.m.BannerImage = "ui/buttons/banner_train.png";
		this.m.CanEnter = false;
		local sounds = getCampSounds(3, "training");
		this.m.Sounds = sounds;
		this.m.SoundsAtNight = sounds;
	}

	function getTitle() {
		return this.m.Name + (this.getUpgraded() ? " *Upgraded*" : " *Not Upgraded*");
	}

	function getDescription() {
		//"Training grounds can be upgraded by purchasing an upgrade set in local markets. Upgraded grounds reduce the risk of accidents from a minimum of 5% to 1% and also give the chance of a permanent random skill increase.";
		return "Brothers will train here, gaining experience while camping. Every training session carries a risk of exhaustion and injury.";
	}

	function getModifierTooltip() {
		local mod = this.getModifiers();
		local ret = [
			{
				id = 6,
				type = "text",
				icon = "ui/buttons/asset_vision_up.png",
				text = "Total training modifier is [color=%positive%]" + mod.Craft * 100.0 + "%[/color]."
			}
		];

		local id = 7;
		foreach( bro in mod.Modifiers )	{
			ret.push({
				id = ++id,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]" + bro[0] * 100.0 + "%[/color] " + bro[1] + " (" + bro[2] + ")" + (bro[3] ? " [color=%negative%]Training fulfilled[/color]" : "")
			});
		}

		return ret;
	}

	function getUpgraded() {
		return ::Stash.hasItem(::Legends.Camp.Tent.Training);
	}

	function getLevel()	{
		return (this.getUpgraded() ? "tent" : "dude") + "_" + (this.getAssignedBros() > 0 ? "full" : "empty");
	}

	function init()	{
		this.m.Results = [];
		this.m.NumBros = this.getAssignedBros();
		local self = this;
		this.m.UnTrained = ::World.getPlayerRoster().getAll().filter(@(_, _bro) _bro.getCampAssignment() == self.m.ID).len();	
	}

	function getModifiers()	{
		local ret = {
			Craft = 0.0,
			Assigned = 0,
			Modifiers = []
		};
		local roster = ::World.getPlayerRoster().getAll();

		local self = this;
		local hasTrainer = roster.filter(@(_, _bro) _bro.getCampAssignment() == self.m.ID && _bro.getSkills().hasPerk(::Legends.Perk.LegendMasterTrainer)).len() > 0;

		local trainingBros = roster.filter(@(_, _bro) _bro.getCampAssignment() == self.m.ID);
		foreach( bro in trainingBros ) {
			ret.Assigned++;
			ret.Modifiers.push([
				this.m.BaseCraft * (1 + bro.getBackground().getModifiers().Training) + (bro.getSkills().hasPerk(::Legends.Perk.LegendBackToBasics) ? 0.1 : 0) + (hasTrainer ? 0.1 : 0),
				bro.getName(),
				bro.getBackground().getNameOnly(),
				bro.getSkills().hasTrait(::Legends.Trait.LegendIntensiveTraining) ? ::Legends.Traits.get(bro, ::Legends.Trait.LegendIntensiveTraining).isMaxReached() : false
			]);
		}

		ret.Modifiers.sort(this.sortModifiers);

		for( local i = 0; i < ret.Modifiers.len(); i++ ) {
			ret.Craft += ret.Modifiers[i][0] * ::Math.pow(i + 1, -0.5) * (this.getUpgraded() ? 1.15 : 1.0);
		}

		return ret;
	}

	function getRandomBroName( broName, bros ) {
		local names = [];

		foreach( b in bros ) {
			if (b[1] != broName) {
				names.push(b[1]);
			}
		}

		return names[::Math.rand(0, names.len() - 1)];
	}


	function getResults() {
		local res = [];
		local id = 120;

		foreach( b in this.m.Results ) {
			res.push({
				id = id++,
				icon = b.Icon,
				text = b.Text
			});
		}
		return res;
	}

	function getAssignedBros() {
		return this.getModifiers().Assigned;
	}


	function getInjury( bro ) {
		local skills = bro.getSkills();
		local injury = skills.hasSkillOfType(this.Const.SkillType.TemporaryInjury) || skills.hasSkillOfType(this.Const.SkillType.SemiInjury) ? bro.addInjury(this.Const.Injury.Permanent) : bro.addInjury(this.Const.Injury.CampTraining);
		this.m.Results.push({
			Icon = injury.getIcon(),
			Text = bro.getName() + " suffers " + injury.getNameOnly() + " while training."
		});
	}

	function getDescriptors( bro, extraTrainingDescriptors){
		local numberOfMTA = this.m.TrainingDescriptors.M.len() * this.m.TrainingDescriptors.T.len() * this.m.TrainingDescriptors.A.len();
		local numberOfExtraDescriptors = extraTrainingDescriptors.len() + numberOfMTA;
		local r = ::Math.rand(0, numberOfExtraDescriptors - 1);

		if (r < numberOfMTA) {
			return "After practicing " + this.m.TrainingDescriptors.M[(r / (this.m.TrainingDescriptors.A.len() * this.m.TrainingDescriptors.T.len())) % this.m.TrainingDescriptors.M.len()] + this.m.TrainingDescriptors.T[(r / this.m.TrainingDescriptors.A.len()) % this.m.TrainingDescriptors.T.len()] + bro.getName() + this.m.TrainingDescriptors.A[r % this.m.TrainingDescriptors.A.len()];
		}
		else {
			return bro.getName() + extraTrainingDescriptors[r - numberOfMTA];
		}
	}

	function getTrained( bro )
	{
		local inTraining = ::Legends.Traits.get(bro, ::Legends.Trait.LegendIntensiveTraining);
		local XPbonus = ::Math.floor(this.m.Camp.getCampTimeHours() * (this.getUpgraded() ? 10 : 5) * (inTraining == null ? 1 : (1 + inTraining.getBonusXP())));
		local originalXP = bro.m.XP;
		bro.addXP(XPbonus);
		bro.updateLevel();
		local extraTrainingDescriptors = [
			" learned a new move",
			" finally nails the fancy parry they have been been practicing",
			" invents an overly showy move",
			" finds a stance that feels more natural",
			" learns how to adjust the new armor so it fits better",
			" has perfected a new skill in practice",
			" had their ego bruised and wants an outlet for frustration",
			" left the training dummy as nothing more than a pile of splinters",
			" has practiced a skill so much it has become second nature",
			" feels more comfortable with their weapon",
			" sets a new personal best in training"
		];

		if (bro.getLevel() < 3)
		{
			extraTrainingDescriptors.push(" figures out what end of the weapon to hold");
			extraTrainingDescriptors.push(" remembers that you can move your legs as well as your arms");
		}

		this.m.Results.push({
			Icon = "ui/icons/xp_received.png",
			Text = this.getDescriptors(bro, extraTrainingDescriptors) + " and gains [color=%positive%]" + (bro.m.XP - originalXP) + "[/color] XP."
		});
		return true;
	}

	function getTrainedAfter11( bro ) {
		if (bro.getSkills().hasEffect(::Legends.Effect.Trained)) {
			return;
		}
		local effect = ::Legends.Effects.grant(bro, ::Legends.Effect.Trained, function(_effect) {
			_effect.m.Duration = 1;
			_effect.m.XPGainMult = 1.1;
			_effect.m.Icon = "skills/status_effect_75.png";
		}.bindenv(this));
		local extraTrainingDescriptors = [
			" learned how to get most of the next battle",
			" finds a stance that can improve his experience in the next battle",
			" is ready to learn more in the next battle"
		];

		this.m.Results.push({
			Icon = effect.getIcon(),
			Text = this.getDescriptors(bro, extraTrainingDescriptors) + " and gains a [color=%positive%]10%[/color] xp increase for the next battle."
		});
		return true;
	}

	function getFailed( _bro ) {
		this.m.Results.push({
			Icon = "ui/tooltips/negative.png", //Should get an icon for failed training
			Text = _bro.getName() + " didn't learn anything useful."
		});
	}

	function getBreak( _bro, cause ) {
		this.m.Results.push({
			Icon = "ui/icons/days_wounded.png", //Should get an icon for failed training
			Text = _bro.getName() + " was " + cause + " and didn't train."
		});
	}

	function getBonus( bro ) {
		if (!bro.getSkills().hasTrait(::Legends.Trait.LegendIntensiveTraining))	{
			return;
		}

		local inTraining = ::Legends.Traits.get(bro, ::Legends.Trait.LegendIntensiveTraining);

		if (inTraining.isMaxReached()) {
			return;
		}

		local text = "";
		local icon = "";
		local properties = bro.getBaseProperties();

		switch(::Math.rand(0, this.Const.Attributes.COUNT - 1))	{
		case 0:
			properties.Hitpoints += 1;
			icon = "ui/icons/health.png";
			text = "Hitpoint";
			inTraining.addHitpoint();
			break;

		case 1:
			properties.Bravery += 1;
			icon = "ui/icons/bravery.png";
			text = "Resolve";
			inTraining.addBrave();
			break;

		case 2:
			properties.Stamina += 1;
			icon = "ui/icons/fatigue.png";
			text = "Fatigue";
			inTraining.addStamina();
			break;

		case 3:
			properties.Initiative += 1;
			icon = "ui/icons/initiative.png";
			text = "Initiative";
			inTraining.addIni();
			break;

		case 4:
		case 5:
			if (properties.MeleeSkill > properties.RangedSkill)	{
				properties.MeleeSkill += 1;
				icon = "ui/icons/melee_skill.png";
				text = "Melee Skill";
				inTraining.addMatk();
			} else {
				properties.RangedSkill += 1;
				icon = "ui/icons/ranged_skill.png";
				text = "Ranged Skill";
				inTraining.addRatk();
			}

			break;

		case 6:
			properties.MeleeDefense += 1;
			icon = "ui/icons/melee_defense.png";
			text = "Melee Defense";
			inTraining.addMdef();
			break;

		case 7:
			properties.RangedDefense += 1;
			icon = "ui/icons/ranged_defense.png";
			text = "Ranged Defense";
			inTraining.addRdef();
			break;

		default:
			::logDebug("Intensive training attribute selection bug, please report it.")
		}

		bro.getSkills().update();

		if (inTraining.isMaxReached()) {
			bro.m.PerkPoints += 1;
			local traitConst = ::Legends.Training.addRandomTrainingTrait(bro);
			inTraining.finishedTraining(traitConst);
			this.m.Results.push({
				Icon = "ui/icons/level.png",
				Text = bro.getName() + " completed the training course and gains [color=%positive%]1[/color] " + text + ", Perk Point and " + ::Legends.Traits.get(bro, traitConst).getName()
			});
		} else {
			this.m.Results.push({
				Icon = icon,
				Text = bro.getName() + " had a breakthrough training session and gains [color=%positive%]1[/color] " + text
			});
		}
	}

	function getBanner(_bro = null) {
		return _bro != null && ::Legends.Traits.get(_bro, ::Legends.Trait.LegendIntensiveTraining).isMaxReached() ? "ui/buttons/banner_train_finished.png" : this.camp_building.getBanner();
	}

	function getUpdateText() {
		if (this.m.NumBros == 0) {
			return null;
		}

		return "Training ... " + (this.getUpgraded() ? this.m.NumBros : (this.m.UnTrained + " / " + this.m.NumBros) ) + " brothers";
	}

	function completed() {
		local campHours = this.m.Camp.getCampTimeHours();
		local injuryMin = this.getUpgraded() ? 1 : 5;
		local mod = this.getUpgraded() ? this.getModifiers() : null;

		foreach(bro in ::World.getPlayerRoster().getAll()) {
			if (bro.getCampAssignment() != this.m.ID) {
				continue;
			}

			local skills = bro.getSkills();
			if (skills.hasSkillOfType(::Const.SkillType.TemporaryInjury)) {
				this.getBreak(bro, "recovering from an injury");
				continue;
			} else if(skills.hasSkillOfType(::Const.SkillType.SemiInjury)) {
				this.getBreak(bro, skills.getAllSkillsOfType(::Const.SkillType.SemiInjury)[0].getName().tolower());
				continue;
			}

			if (::Math.rand(1, 100) < ::Math.min(95, 100 * ::Math.pow(campHours / 12.0, 0.6 + 0.1 * bro.getLevel()))) {
				if (bro.getLevel() < 12) {
					this.getTrained(bro);
				} else {
					this.getTrainedAfter11(bro);
				}
			} else {
				this.getFailed(bro);
			}

			if (this.getUpgraded())	{
				for(local camphrs = campHours; camphrs > 0;) {
					local r = this.Math.rand(1, 100);

					if (r <= camphrs + mod.Craft * camphrs)	{
						this.getBonus(bro);
						camphrs -= r;
					}
					else {
						break;
					}
				}
			}

			local r = ::Math.min(injuryMin, 4 * ::Math.pow(campHours, 0.5) - bro.getLevel());

			if (this.Math.rand(1, 100) < r)	{
				this.getInjury(bro);
			}

			if (this.Math.rand(1, 100) < r)	{
				local effect = ::Legends.Effects.grant(bro, ::Legends.Effect.Exhausted);
                if (effect != null) {
                    this.m.Results.push({
                        Icon = effect.getIcon(),
                        Text = bro.getName() + " pushed themselves too hard and became Exhausted."
                    });
                }
			}
		}
	}
});

