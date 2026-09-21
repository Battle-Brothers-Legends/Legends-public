this.gatherer_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		Results = [],
		Items = [],
		Points = 0,
		Craft = 0,
		CurrentTarget = null,
		PreviousTarget = null,
		TargetStartTime = 0,
		LootGenerator = null,
		ActivityName = "Gathering"
	},

	function create() {
		this.camp_building.create();
		this.m.ID = ::Legends.Camp.CampBuildings.Gatherer;
		this.m.ModName = "Gathering";
		this.m.HasPopup = true;
		this.m.BaseCraft = 1.0;
		this.m.ModMod = 10.0;
		this.m.Slot = "gather";
		this.m.Name = "Supply Tent";
		this.m.Description = "Send mercenaries out to gather supplies - meat, herbs, plants, skins, wood and ore. Mining and Woodcutting require some knowledge.";
		this.m.BannerImage = "ui/buttons/banner_gather.png";
		local sounds = this.getCampSounds(6, "gatherer");
		this.m.Sounds = sounds;
		this.m.SoundsAtNight = sounds;
		this.m.CanEnter = false;
		this.m.IsWorkDangerous = true;
		//this.m.ModMod = 10.0; // gathering had 1.0, hunting 10.0
		//this.m.BaseCraft = 1.5; // gathering had 0.5, hunting 1.5
	}

	function getTitle() {
		return this.m.Name + (this.getUpgraded() ? " *Upgraded*" : " *Not Upgraded*");
	}

	function getDescription() {
		return "Hunt for supplies - meat, herbs, plants, skins, wood and ore. Scrounging for supplies carries a risk of exhaustion and injury.";
	}

	function getLevel() {
		return (this.getUpgraded() ? "tent" : "dude") + "_" + (this.getAssignedBros() > 0 ? "full" : "empty");
	}

	function getHuntingLevel() {
		local self = this;
		local numBros = ::World.getPlayerRoster().getAll().filter(@(_, _bro)(_bro.getCampAssignment() == self.m.ID && !self.isRecovering(_bro))).len();
		return ::World.Assets.m.ProfessionEffect.LegendHunting > 0 ? (::World.Assets.m.ProfessionEffect.LegendHunting * numBros) : (0.1 * numBros);
	}

	function getAllowedTargets() {
		local ret = [];
		local mode = ::Legends.GatheringLoot.CampGatheringMode;

		if (mode.Hunting) {
			ret.push(::Legends.Profession.LegendHunting);
		}
		if (mode.Mining && ::World.Assets.m.ProfessionEffect.LegendMining > 0) {
			ret.push(::Legends.Profession.LegendMining);
		}
		if (mode.Woodcutting && ::World.Assets.m.ProfessionEffect.LegendWoodcutting > 0) {
			ret.push(::Legends.Profession.LegendWoodcutting);
		}
		if (mode.Foraging || ret.len() == 0) {
			// default to foraging if everything is disabled
			ret.push(::Legends.Profession.LegendForaging);
		}
		return ret;
	}

	function onPopupButtonClicked(_data) {
		if (_data.len() == 2) {
			this[_data[1]](_data[0]);
			::Sound.play("sounds/move_pot_clay_01.wav", 2.0);
		}
	}

	function queryConfigureSettings() {
		return {
			Buttons = ["Foraging", "Hunting", "Mining", "Woodcutting"],
			States = ::Legends.GatheringLoot.CampGatheringMode
		};
	}

	function toggleMode( _id ) {
        ::Legends.GatheringLoot.CampGatheringMode[_id] = !::Legends.GatheringLoot.CampGatheringMode[_id];
    }

	function init() {
		this.m.Results = [];
		this.m.Items = [];
		this.m.Craft = this.getModifiers().Craft;
		this.m.Points = 0;
		this.m.CurrentTarget = null;
		this.m.PreviousTarget = null;
		this.m.LootGenerator = ::Legends.GatheringLoot.getGenerator(::World.Camp.getCampingTerrain());
	}

	function getResults() {
		local res = [];
		local id = 60;
		foreach (item in this.m.Items) {
			res.push({
				id = id,
				icon = "ui/items/" + item.getIcon(),
				text = "The gatherers brought " + ::Legends.S.colorizeAndPluralize(item.getName(), "positiveEvent") + "."
			});
			id = ++id;
		}

		foreach (result in this.m.Results) {
			res.push({
				id = id,
				icon = result.Icon,
				text = result.Text
			});
			id = ++id;
		}
		return res;
	}

	function getAssignedBros() {
		return this.getModifiers().Assigned;
	}

	function getUpdateText() {
		if (this.getAssignedBros() == 0) {
			return null;
		}

		local text = ["Gathered ... " + this.m.Items.len() + " items"];
		if (::Stash.getNumberOfEmptySlots() == 0) {
			return [text[0] + " (Inventory is full!)"];
		}

		if (this.getAssignedBros() != 0) {
			local hours = ::Math.ceil((::Time.getVirtualTimeF() - this.m.TargetStartTime) / (::World.getTime().SecondsPerDay / 24)) + 1;
			if (this.m.CurrentTarget != null) {
				text.push((::Const.Professions.ProfessionDefObjects[this.m.CurrentTarget.Profession].Name + " " + this.m.CurrentTarget.Name) + " ... " + hours + " " + ::Legends.S.pluralize(hours, "hour"));
			} else if (this.m.PreviousTarget != null) {
				text.push((::String.replace(::Const.Professions.ProfessionDefObjects[this.m.PreviousTarget.Profession].Name, "ing", "ed ") + this.m.PreviousTarget.Name + "!") + " ... " + hours + " " + ::Legends.S.pluralize(hours, "hour"));
			}			
		}

		return text;
	}

	function calcTargetDifficulty(_profession, _difficulty) {
		return _difficulty / (1 + ::World.Assets.m.ProfessionEffect[::Const.Professions.ProfessionDefObjects[_profession].Const]);
	}

	// To get a sense of scale for values for hunting/foraging, see https://docs.google.com/spreadsheets/d/1PaYY4woUIxKwOCHK_O6whWq60KYmDoAZaQqJp7AIeao/edit?usp=sharing
	function update() {
		if (this.getAssignedBros() == 0 || ::Stash.getNumberOfEmptySlots() == 0) {
			return this.getUpdateText();
		}

		this.m.Points += this.m.Craft;
		if (this.m.CurrentTarget == null) {
			local allowedTargets = this.getAllowedTargets();
			local targetFound = ::Math.rand(1, allowedTargets.len() + 1) <= allowedTargets.len();
			if (!targetFound && this.getUpgraded() && ::Math.rand(1, 100) <= 50) {
				targetFound = true;
			}
			if (targetFound) {
				this.m.CurrentTarget = this.m.LootGenerator.rollTarget(allowedTargets, this.getHuntingLevel());
				this.m.TargetStartTime = ::Time.getVirtualTimeF();
			} else {
				return this.getUpdateText();
			}
		}

		if (::Math.rand(1, 100) <= ::Math.ceil(100.0 * this.m.Points / calcTargetDifficulty(this.m.CurrentTarget.Profession, this.m.CurrentTarget.Difficulty))) {
			local mainLoot = ::new(this.m.CurrentTarget.Loot);
			if (mainLoot.isItemType(::Const.Items.ItemType.Food)) {
				mainLoot.randomizeAmount();
				mainLoot.randomizeBestBefore();
			}
			this.m.Items.push(mainLoot);
			::Stash.add(mainLoot);

			if (this.m.CurrentTarget.ExtraLoot != null && ::Stash.getNumberOfEmptySlots() > 1) {
				local extraLoot = ::new(this.m.CurrentTarget.ExtraLoot);
				this.m.Items.push(extraLoot);
				if(extraLoot.isItemType(::Const.Items.ItemType.Supply)) {
					extraLoot.consume();
				} else {
					::Stash.add(extraLoot);
				}
			}

			this.m.PreviousTarget = this.m.CurrentTarget;
			this.m.CurrentTarget = null;
			this.m.Points = 0; // Reset for next target
		}

		return this.getUpdateText();
	}

	function completed() {
		local campHours = this.m.Camp.getCampTimeHours();
		local self = this;
		local assignedBros = ::World.getPlayerRoster().getAll().filter(@(_, _bro)(_bro.getCampAssignment() == self.m.ID && !self.isRecovering(_bro, true)));
		foreach (bro in assignedBros) {
			this.addNegativeSideEffects(bro, campHours);
		}
	}

	function estimateGatheringTime(_difficulty, _craft) {
        if (_craft <= 0) {
			return null;
		}
    	local chancePerStep = _craft.tofloat() / _difficulty.tofloat();
        local expectedHours = 0.0;
        local cumulativeFailChance = 1.0;

        for (local i = 1; i <= ::Math.ceil(1.0 / chancePerStep); i++) {
            local successChance = ::Math.minf(1.0, i * chancePerStep); 
            expectedHours += i * cumulativeFailChance * successChance; 
            cumulativeFailChance *= (1.0 - successChance); 
            if (cumulativeFailChance <= 0.0) {
				break;
			}
        }

        return ::Math.max(1, ::Math.round(expectedHours));
    }

	function getInfo() {
		local mod = this.getModifiers();
		local ret = ["Gathering points per hour: " + (::Math.floor(mod.Craft * 100) / 100.0)];

		local huntLevel = this.getHuntingLevel();
		ret.push("Hunting Tier: " + (huntLevel != null ? (::Math.min(3, ::Math.floor(huntLevel / 7))) : 0));

		ret.push(::Legends.tooltip("Allowed gathering: <span style=\"color:" + ::Const.UI.Color.getHighlightLightBackgroundValue() + ";\">" + ::Const.LegendMod.Language.arrayToText(this.getAllowedTargets().map(@(_v) (::Const.Professions.ProfessionDefObjects[_v].Name))) + "</span>"));

		local biome = ::World.Camp.getCampingTerrain();
		ret.push("Current biome: <span style=\"color:" + ::Const.UI.Color.getHighlightLightBackgroundValue() + ";\">" + ::Const.World.TerrainLocation[biome] + "</span>") ;
		if (!(biome in ::Legends.GatheringLoot.Biomes)) {
            ret.push("No resources available in this location.");
            return ret;
        }

		local biomeRewards = ::Legends.GatheringLoot.Biomes[biome];
		foreach (prof in [::Legends.Profession.LegendForaging, ::Legends.Profession.LegendHunting, ::Legends.Profession.LegendMining, ::Legends.Profession.LegendWoodcutting]) {
            ret.push("<u>" + ::Const.Professions.ProfessionDefObjects[prof].Name + "</u>");
            
            foreach (targetData in biomeRewards[prof]) {
                local target = targetData[1];
                local hours = this.estimateGatheringTime(calcTargetDifficulty(prof, target.Difficulty), mod.Craft);
                local text = "- " + target.Name + (hours != null ? " (around " + hours + " " + ::Legends.S.pluralize(hours, "hour") + ")" : "");
                
                if (prof == ::Legends.Profession.LegendHunting && !::Legends.GatheringLoot.hasSufficientHuntingLevelForTier(huntLevel, target.Tier) && hours != null) {
                    ret.push("<s>" + text + "</s>");
                    ret.push("<span style=\"color:%negative%; display: inline-block; padding-left: 2rem;\">Requires Hunting Tier " + target.Tier + "</span>");
                } else {
                    ret.push(text);
                }
            }
        }
		
		return ret;
	}

	function serializeTarget(_out, _target) {
		if (_target != null) {
            _out.writeBool(true);
            _out.writeString(_target.Name);
            _out.writeI32(_target.Difficulty);
			_out.writeI32(_target.Profession);
            _out.writeString(_target.Loot);
            _out.writeBool(_target.ExtraLoot != null);
            if (_target.ExtraLoot != null) {
                _out.writeString(_target.ExtraLoot);
            }
        } else {
            _out.writeBool(false);
        }
	}

	function onSerialize(_out) {
		this.camp_building.onSerialize(_out);
		_out.writeF32(this.m.Points);
        _out.writeF32(this.m.TargetStartTime);
		this.serializeTarget(_out, this.m.CurrentTarget);
		this.serializeTarget(_out, this.m.PreviousTarget);
		if (this.m.LootGenerator != null) {
            _out.writeBool(true);
            _out.writeI8(this.m.LootGenerator.Biome);
        } else {
            _out.writeBool(false);
        }
	}

	function deserializeTarget(_in) {
		if (_in.readBool()) {
            local target = {
                Name = _in.readString(),
                Difficulty = _in.readI32(),
				Profession = _in.readI32(),
                Loot = _in.readString(),
                ExtraLoot = null
            };
            if (_in.readBool()) {
                target.ExtraLoot = _in.readString();
            }
			return target;
        } else {
			return null;
		}
	}

	function onDeserialize(_in) {
		this.init();
		this.camp_building.onDeserialize(_in);
        this.m.Points = _in.readF32();
        this.m.TargetStartTime = _in.readF32();
        this.m.CurrentTarget = this.deserializeTarget(_in);
		this.m.PreviousTarget = this.deserializeTarget(_in);
        if (_in.readBool()) {
            this.m.LootGenerator = ::Legends.GatheringLoot.getGenerator(_in.readI8());
        }
	}
});
