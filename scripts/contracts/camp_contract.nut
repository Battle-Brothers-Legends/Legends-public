this.camp_contract <- ::inherit("scripts/contracts/contract", {
	m = {},

	function create() {
		this.contract.create();
		this.m.IsDone = false;
	}

	function start() {
		this.m.IsStarted = true;

		this.onImportIntro();

		if (this.hasState("Offer")) {
			this.setState("Offer");
		}
	}

	function isValid() {
		if (!this.m.IsValid)
			return false;

		if (this.World.FactionManager.getFaction(this.getFaction()).getType() != ::Const.FactionType.FreeCompany)
			return false;

		return this.onIsValid();
	}

	function onClear() {

	}

	function buildText(_text) {
		local brothers = this.World.getPlayerRoster().getAll();
		local brother1 = this.Math.rand(0, brothers.len() - 1);
		local brother2 = this.Math.rand(0, brothers.len() - 1);

		if (brothers.len() >= 2) {
			while (brother1 == brother2) {
				brother2 = this.Math.rand(0, brothers.len() - 1);
			}
		}

		local gender1 = brothers[brother1].getGender();
		local gender2 = brothers[brother2].getGender();

		if (brothers.len() < 2) {
			brother1 = "unknown";
			brother2 = "unknown";
		} else {
			brother1 = brothers[brother1].getName();
			brother2 = brothers[brother2].getName();
		}

		local villages = this.World.EntityManager.getSettlements();
		local randomTown;

		do {
			randomTown = villages[this.Math.rand(0, villages.len() - 1)].getNameOnly();
		} while (randomTown == null);

		local text;
		local vars = [
			[
				"SPEECH_ON",
				"\n\n[color=#bcad8c]\""
			],
			[
				"SPEECH_START",
				"[color=#bcad8c]\""
			],
			[
				"SPEECH_OFF",
				"\"[/color]\n\n"
			],
			[
				"companyname",
				this.World.Assets.getName()
			],
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomnoble",
				this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]
			],
			[
				"randombrother",
				brother1
			],
			[
				"randombrother2",
				brother2
			],
			[
				"randomtown",
				randomTown
			],
			[
				"reward_completion",
				this.m.Payment.getOnCompletion()
			],
			[
				"reward_advance",
				this.m.Payment.getInAdvance()
			],
			[
				"reward_count",
				this.m.Payment.getPerCount()
			],
			[
				"employer",
				this.m.EmployerID != 0 ? this.Tactical.getEntityByID(this.m.EmployerID).getName() : ""
			],
			[
				"faction",
				this.World.FactionManager.getFaction(this.m.Faction).getName()
			],
			[
				"maxcount",
				this.m.Payment.MaxCount
			]
		];

		this.onPrepareVariables(vars);
		vars.push([
			"reward",
			this.m.Payment.getOnCompletion() + this.m.Payment.getInAdvance()
		]);
		if (this.m.EmployerID != 0) {
			::Const.LegendMod.extendVarsWithPronouns(vars, this.getEmployer().getGender(), "employer");
		}
		::Const.LegendMod.extendVarsWithPronouns(vars, gender1, "randombrother");
		::Const.LegendMod.extendVarsWithPronouns(vars, gender2, "randombrother2");
		return this.buildTextFromTemplate(_text, vars);
	}
});
