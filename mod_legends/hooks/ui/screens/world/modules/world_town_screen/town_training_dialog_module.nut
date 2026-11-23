::mods_hookExactClass("ui/screens/world/modules/world_town_screen/town_training_dialog_module", function(o) {
	o.showTraitPopup <- function (_text) {
		this.m.JSHandle.asyncCall("openPopupDialog", _text);
	}

	o.queryBroInformation <- function (_bro) {
		local background = _bro.getBackground();
		return {
			ID = _bro.getID(),
			Name = _bro.getName(),
			Level = _bro.getLevel(),
			ImagePath = _bro.getImagePath(),
			ImageOffsetX = _bro.getImageOffsetX(),
			ImageOffsetY = _bro.getImageOffsetY(),
			BackgroundImagePath = background.getIconColored(),
			BackgroundText = background.getDescription(),
			Training = [],
			Effects = []
		}
	}

	o.getPrice <- function (_trait, _points) {
		local points = ::Math.min(_trait.m.MaxSkillsCanBeAdded - _trait.getStatsIncreased(), _points);
		local trainedPoints = _trait.m.SettlementTrainedPoints;
		local price = 0;
		for (local i = trainedPoints + 1; i <= (trainedPoints + points); i++) {
			price += ::Legends.Training.CostTrainingBase + i * ::Legends.Training.CostTrainingScaled;
		}
		return price;
	}

	o.queryRosterInformation = function() {
		local brothers = this.World.getPlayerRoster().getAll();
		local roster = [];

		foreach (b in brothers) {
			if (b.getLevel() >= 12) {
				continue;
			}

			if (b.getLevel() >= 7
				&& this.World.Assets.getOrigin().getID() == "scenario.manhunters"
				&& b.getBackground().getID() == "background.slave")
			{
				continue;
			}

			if (b.getSkills().hasEffect(::Legends.Effect.Trained)) {
				continue;
			}

			local background = b.getBackground();
			local e = {
				ID = b.getID(),
				Name = b.getName(),
				Level = b.getLevel(),
				ImagePath = b.getImagePath(),
				ImageOffsetX = b.getImageOffsetX(),
				ImageOffsetY = b.getImageOffsetY(),
				BackgroundImagePath = background.getIconColored(),
				BackgroundText = background.getDescription(),
				Training = [],
				Effects = []
			};
			e.Training.push({
				id = 0,
				icon = "skills/status_effect_75.png",
				name = "Sparring Fight",
				tooltip = "world-town-screen.training-dialog-module.Train1",
				price = 80 + 50 * b.getLevel()
			});
			e.Training.push({
				id = 1,
				icon = "skills/status_effect_76.png",
				name = "Veteran\'s Lessons",
				tooltip = "world-town-screen.training-dialog-module.Train2",
				price = 100 + 60 * b.getLevel()
			});
			e.Training.push({
				id = 2,
				icon = "skills/status_effect_77.png",
				name = "Rigorous Schooling",
				tooltip = "world-town-screen.training-dialog-module.Train3",
				price = 90 + 55 * b.getLevel()
			});
			roster.push(e);
		}

		local result = {
			Title = "Training Hall",
			SubTitle = "Have your men train for combat and learn from veterans",
			Roster = roster,
			Assets = this.m.Parent.queryAssetsInformation()
		};

		foreach (bro in brothers) {
			local trait = ::Legends.Traits.grant(bro, ::Legends.Trait.LegendIntensiveTraining);
			local mercilessRegimenNameBlock = "Merciless Regimen";
			if(trait != null && trait.m.TraitGained != null && trait.m.TraitGained != -1){
				mercilessRegimenNameBlock = "<div style='display: block; line-height: 18px; margin-top: -8px;'>" +
												"<span style='font-size: 18px;'>Merciless Regimen</span><br>" +
												"<span style='color:" + this.Const.UI.Color.PositiveValue + "; font-size: 16px;'>Current: " + this.new(::Legends.Traits.TraitDefObjects[trait.m.TraitGained].Script).getName() + "</span>" +
											"</div>"
			}
			local roster = result.Roster;
			local broFound = false;
			foreach (element in roster) {
				if (element.ID == bro.getID()) {
					broFound = true;
					if (trait.canTrainInTown()) {
						element.Training.push({
							id = 100,
							icon = "skills/status_effect_75.png",
							name = "Thorough Training",
							tooltip = "world-town-screen.training-dialog-module.Train100",
							price = this.getPrice(trait, 1)
						});
						element.Training.push({
							id = 101,
							icon = "skills/status_effect_75.png",
							name = "Intense Training",
							tooltip = "world-town-screen.training-dialog-module.Train101",
							price = this.getPrice(trait, 3)
						});
					}
					if (trait.canRerollTrait()) {
						element.Training.push({
							id = 102,
							icon = "skills/status_effect_75.png",
							name = mercilessRegimenNameBlock,
							tooltip = "world-town-screen.training-dialog-module.Train102",
							price = ::Legends.Training.CostRerollBase + trait.m.TraitRerollCount * ::Legends.Training.CostRerollScaled
						});
					}
					break;
				}
			}

			if (broFound)
				continue;

			local background = bro.getBackground();
			local training = [];
			if (trait.canTrainInTown()) {
				training.push({
					id = 100,
					icon = "skills/status_effect_75.png",
					name = "Thorough Training",
					tooltip = "world-town-screen.training-dialog-module.Train100",
					price = this.getPrice(trait, 1)
				});
				training.push({
					id = 101,
					icon = "skills/status_effect_75.png",
					name = "Intense Training",
					tooltip = "world-town-screen.training-dialog-module.Train101",
					price = this.getPrice(trait, 3)
				});
			}
			if (trait.canRerollTrait()) {
				training.push({
					id = 102,
					icon = "skills/status_effect_75.png",
					name = mercilessRegimenNameBlock,
					tooltip = "world-town-screen.training-dialog-module.Train102",
					price = ::Legends.Training.CostRerollBase + trait.m.TraitRerollCount * ::Legends.Training.CostRerollScaled
				});
			}
			local info = this.queryBroInformation(bro);
			info.Training.extend(training);
			roster.push(info);
		}
		return result;
	}

	o.onTrainExt <- function(_data) {
		local trainingID = _data[1];
		local entity = this.Tactical.getEntityByID(_data[0]);
		local trait = ::Legends.Traits.get(entity, ::Legends.Trait.LegendIntensiveTraining);
		local price = 0;

		switch (trainingID) {
			case 100:
				price = this.getPrice(trait, 1);
				trait.addRandomSkills(entity, 1);
				trait.m.SettlementTrainingDelay += 2;
				trait.m.SettlementTrainedPoints += 1;
				if (trait.isMaxReached()) {
					entity.m.PerkPoints += 1;
					local traitConst = ::Legends.Training.addRandomTrainingTrait(entity);
					trait.finishedTraining(traitConst);
					::Time.scheduleEvent(::TimeUnit.Real, 200, this.showTraitPopup.bindenv(this),
						::format("Trait [color=%s]%s[/color] gained. [color=%s]1[/color] perk point granted.", ::Const.UI.Color.PositiveEventValue, ::Legends.Traits.get(entity, traitConst).getName(), ::Const.UI.Color.PositiveEventValue)
					);
				}
				break;
			case 101:
				local pointsTrained = ::Math.min(trait.m.MaxSkillsCanBeAdded - trait.getStatsIncreased(), 3);
				price = this.getPrice(trait, pointsTrained);
				trait.addRandomSkills(entity, pointsTrained);
				trait.m.SettlementTrainingDelay += 5;
				trait.m.SettlementTrainedPoints += pointsTrained;
				if (trait.isMaxReached()) {
					entity.m.PerkPoints += 1;
					local traitConst = ::Legends.Training.addRandomTrainingTrait(entity);
					trait.finishedTraining(traitConst);
					::Time.scheduleEvent(::TimeUnit.Real, 200, this.showTraitPopup.bindenv(this),
						::format("Trait [color=%s]%s[/color] gained. [color=%s]1[/color] perk point granted.", ::Const.UI.Color.PositiveEventValue, ::Legends.Traits.get(entity, traitConst).getName(), ::Const.UI.Color.PositiveEventValue)
					);
				}
				break;
			case 102:
				price = ::Legends.Training.CostRerollBase + trait.m.TraitRerollCount * ::Legends.Training.CostRerollScaled;
				trait.m.TraitRerollDelay += 5;
				trait.m.TraitRerollCount += 1;
				local traitConst = ::Legends.Training.addRandomTrainingTrait(entity);
				::Legends.Traits.remove(entity, trait.m.TraitGained);
				trait.finishedTraining(traitConst);
				::Time.scheduleEvent(::TimeUnit.Real, 200, this.showTraitPopup.bindenv(this),
					::format("Trained trait changed to [color=%s]%s[/color].", ::Const.UI.Color.PositiveEventValue, ::Legends.Traits.get(entity, traitConst).getName())
				);
				break;
		}
		this.World.Assets.addMoney(-price);

		local roster = this.queryRosterInformation();
		local info = null;
		foreach (entry in roster.Roster) {
			if (entry.ID == _data[0]) {
				info = {
					Entity = entry,
					Assets = this.m.Parent.queryAssetsInformation()
				};
				break;
			}
		}
		return info;
	}

	local onTrain = o.onTrain;
	o.onTrain = function(_data) {
		if (_data[1] == 100 || _data[1] == 101 || _data[1] == 102) // handle new cases
			return this.onTrainExt(_data);
		local result = onTrain(_data);
		local roster = this.queryRosterInformation();
		foreach (entry in roster.Roster) {
			if (entry.ID == _data[0])
				return {
					Entity = entry,
					Assets = this.m.Parent.queryAssetsInformation()
				};
		}
		return result;
	}
});
