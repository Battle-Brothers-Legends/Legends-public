this.camp_building <- {
	m = {
		Camp = null,
		ID = "",
		Slot = "",
		Name = "",
		Description = "",
		BannerImage = "",
		Level = 0,
		UIImage = null,
		UIImageNight = null,
		UIImageFull = null,
		UIImageNightFull = null,
		Tooltip = null,
		TooltipIcon = "",
		TerrainLabel = "",
		Sounds = [],
		SoundsAtNight = [],
		CanEnter = true,
		HasPopup = false,
		InCommanderTent = true,
		Camping = true,
		Escorting = false
		ModName = "",
		ModMod = 1.0,
		BaseCraft = 0.0,
		Conversion = 1.0,
		RequiresHealthyBros = false
	},

	function create() {}

	function destroy() {}

	function init() {}

	function completed() {}

	function Camping() {
		return this.m.Camping;
	}

	function Escorting() {
		return this.m.Escorting;
	}

	function getUpdateText() {
		return null;
	}

	function update() {
		return this.getUpdateText();
	}

	function updateTick(_hours) {}

	function hasPopup() {
		return this.m.HasPopup;
	}

	function canEnter() {
		return this.m.CanEnter;
	}

	function getID() {
		return this.m.ID;
	}

	function getName() {
		return this.m.Name;
	}

	function getSlot() {
		return this.m.Slot;
	}

	function getResults() {
		return [];
	}

	function isHidden() {
		return ::Legends.Settings.skipCamp() ? false : !::World.Flags.get(::Legends.Camp.Flag[this.m.ID]);
	}

	function getUpgraded() {
		return this.m.ID in ::Legends.Camp.Upgrades ? ::World.Retinue.hasFollower(::Legends.Camp.Upgrades[this.m.ID]) : false;
	}

	function getLevel() {
		return "empty";
	}

	function getCampSounds(_number, _slot, _volume = 1.0, _pitch = 1.0) {
		local sounds = [];
		for (local i = 1; i <= _number; i++) {
			sounds.push({
				File = format("ambience/camp/camp_" + _slot + "_%02d.wav", i),
				Volume = _volume,
				Pitch = _pitch
			});
		}
		return sounds;
	}

	function getUIImage(_terrain) {
		return "ui/settlements/" + (this.m.TerrainLabel != "" ? this.m.TerrainLabel : (_terrain < 10 ? "0" + _terrain : _terrain)) + "_" + this.getSlot() + "_" + this.getLevel() + "_"	+ (::World.getTime().IsDaytime ? "day" : "night");
	}

	function getTooltipID() {
		return this.m.ID;
	}

	function getTitle() {
		return this.m.Name;
	}

	function getTooltip() {
		local res = [
			{
				id = 1,
				type = "title",
				text = this.getTitle()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		local mod = this.getModifierTooltip();
		foreach (i in mod) {
			res.push(i);
		}
		if (this.canEnter()) {
			res.push({
				id = 61,
				type = "hint",
				icon = "ui/icons/mouse_left_button.png",
				text = "Open Tent Dialog"
			});
		}
		if (this.inCommanderTent()) {
			res.push({
				id = 62,
				type = "hint",
				icon = "ui/icons/mouse_right_button.png",
				text = "Open Tent Menu in Commander Dialog"
			});
		}
		return res;
	}

	function getModifierTooltip() {
		return [];
	}

	function getDescription() {
		return this.m.Description;
	}

	function getTooltipIcon() {
		return this.m.TooltipIcon;
	}

	function getNumberAssigned() {
		local self = this;
		return ::World.getPlayerRoster().getAll().filter(@(_, _bro) _bro.getCampAssignment() == self.m.ID && !_bro.isStabled()).len();
	}

	function getBanner(bro = null) {
		return this.m.BannerImage;
	}

	function getResourceImage() {
		return "";
	}

	function getResourceCount() {
		return 0;
	}

	function inCommanderTent() {
		return this.m.InCommanderTent && !this.isHidden();
	}

	function pushUIMenuStack() {
		::World.State.getMenuStack().push(function () {
			::World.State.getCampScreen().showMainDialog();
		}, function () {
			return !::World.State.getCampScreen().isAnimating();
		});
	}

	function assignBro(_bro) {
		_bro.setCampAssignment(this.m.ID);
	}

	function setCamp(_camp) {
		this.m.Camp = this.WeakTableRef(_camp);
	}

	function onClicked(_campScreen) {
		_campScreen.showCampBuildingDialog(this.m.ID);
		::World.State.getMenuStack().push(function () {
			::World.State.getCampScreen().showMainDialog();
			::World.State.getCampScreen().refresh();
		}, function () {
			return !::World.State.getCampScreen().isAnimating();
		});
	}

	function onBroLeave(_bro) {}

	function onBroEnter(_bro) {
		return !_bro.isStabled();
	}

	function onSerialize(_out) {}

	function onDeserialize(_in) {}

	function sortModifiers( _f1, _f2 ) {
		if (_f1[0] > _f2[0]) {
			return -1;
		} else if (_f1[0] < _f2[0]) {
			return 1;
		} else {
			return 0;
		}
	}

	function getModifiers() {
		local ret = {
			Consumption = 1.0 / this.m.Conversion,
			Craft = 0.0, // total Craft value of all characters assigned to the tent
			Assigned = 0, // number of characters assigned to the tent
			Modifiers = [] // each element is [Craft value contributed by the character (including bonuses), Name of character, Background of character]
		}
		local self = this;
		local assignedBros = ::World.getPlayerRoster().getAll().filter(@(_, _bro) (_bro.getCampAssignment() == self.m.ID && !self.isRecovering(_bro)));
		foreach (bro in assignedBros) {
			// Each character assigned will contribute the tent's BaseCraft plus any bonuses from their modifiers
			// If the character does not have the relevant skill, they will contribute only the BaseCraft value
			// If the character is skilled, they will contribute the BaseCraft value + the bonuses from their modifiers. The bonuses are further multiplied by the tent's ModMod value
			// A higher ModMod value means that skilled characters will have a more significant impact on the output
			++ret.Assigned;
			ret.Modifiers.push([this.m.BaseCraft + this.m.BaseCraft * bro.getBackground().getModifiers()[this.m.ModName] * this.m.ModMod, bro.getNameOnly(), bro.getBackground().getNameOnly()]);
		}

		ret.Modifiers.sort(this.sortModifiers);
		for (local i = 0; i < ret.Modifiers.len(); i++) {
			ret.Modifiers[i][0] = ret.Modifiers[i][0] * ::Math.pow(i + 1, -0.5) * (this.getUpgraded() ? 1.15 : 1); // each additional character grants diminishing returns
			ret.Craft += ret.Modifiers[i][0];
		}
		return ret;
	}

	function getInfo() {
		return null;
	}

	function getSortedRoster() {
		local roster = [];
		local self = this;
		local assignedBros = ::World.getPlayerRoster().getAll().filter(@(_, _bro) (self.onBroEnter(_bro)));
		foreach (b in assignedBros) {
			local bro = ::UIDataHelper.convertEntityToUIData(b, null);
			bro.bannerImage <- ::World.Camp.getBuildingByID(b.getCampAssignment()).getBanner(b);
			bro.IsSelected <- b.getCampAssignment() == this.m.ID;
			bro.Modifier <- this.m.ModName != "" ? b.getBackground().getModifiers()[this.m.ModName] : 0;
			roster.push(bro);
		}

		roster.sort(function(_a, _b) {
            if (_a.Modifier > _b.Modifier) return -1;
            if (_a.Modifier < _b.Modifier) return 1;
            return 0;
        });
		return roster;
	}

	function onPopupButtonClicked(_data) {}

	function queryConfigureSettings() {
		return {};
	}

	function isRecovering(_bro) {
		if(!this.m.RequiresHealthyBros) {
			return false;
		}
		local skills = _bro.getSkills();
		if (skills.hasSkillOfType(::Const.SkillType.TemporaryInjury)) {
			this.getBreak(_bro, "recovering from an injury");
			return true;
		} else if(skills.hasSkillOfType(::Const.SkillType.SemiInjury)) {
			this.getBreak(_bro, skills.getAllSkillsOfType(::Const.SkillType.SemiInjury)[0].getName().tolower());
			return true;
		}
		return false;
	}

	function getBreak( _bro, cause ) {
		this.m.Results.push({
			Icon = "ui/icons/days_wounded.png",
			Text = _bro.getName() + " was " + cause + " and has forgone" + this.m.ActivityName + "."
		});
	}

	function addNegativeSideEffects(_bro, _hours) {
		local r = ::Math.min(this.getUpgraded() ? 1 : 5, 4 * ::Math.pow(_hours, 0.5) - _bro.getLevel());

		if (::Math.rand(1, 100) < r) {
			_bro.addLightInjury();
			this.m.Results.push({
				Icon = "ui/icons/days_wounded.png",
				Text = _bro.getName() + " suffers light wounds while " + this.m.ActivityName.tolower() + "."
			});
		}

		if (::Math.rand(1, 100) < r) {
			local injury = _bro.addInjury(::Const.Injury.CampActivities);
			this.m.Results.push({
				Icon = injury.getIcon(),
				Text = _bro.getName() + " suffers " + injury.getNameOnly() + " while " + this.m.ActivityName.tolower() + "."
			});
		}

		if (::Math.rand(1, 100) < r) {
			local effect = ::Legends.Effects.grant(_bro, ::Legends.Effect.Exhausted);
			if (effect != null) {
				this.m.Results.push({
					Icon = effect.getIcon(),
					Text = "Hard work during " + this.m.ActivityName + " left " + _bro.getName() + " Exhausted."
				});
			}
		}
	}
}
