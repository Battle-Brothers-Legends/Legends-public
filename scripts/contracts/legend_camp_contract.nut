this.legend_camp_contract <- ::inherit("scripts/contracts/contract", {
	m = {
		EmployerFaction = null
	},

	function create() {
		this.contract.create();
	}

	function start() {
		this.m.IsStarted = true;

		this.onImportIntro();

		if (this.hasState("Offer")) {
			this.setState("Offer");
		}
	}

	function getBanner() {
		if (this.m.EmployerFaction != null)
			return ::Legends.CampContracts.EmployerBanner[this.m.EmployerFaction];
		return "ui/banners/factions/banner_legend_s";
	}

	function isValid() {
		if (!this.m.IsValid)
			return false;

		if (::World.FactionManager.getFaction(this.getFaction()).getType() != ::Const.FactionType.FreeCompany)
			return false;

		return this.onIsValid();
	}

	function isVisible() {
		return true;
	}

	function onImportIntro() {
		this.importCampIntro();
	}

	function onClear() {

	}

	function buildText(_text) {
		local brothers = ::World.getPlayerRoster().getAll();
		local brother1 = ::Math.rand(0, brothers.len() - 1);
		local brother2 = ::Math.rand(0, brothers.len() - 1);

		if (brothers.len() >= 2) {
			while (brother1 == brother2) {
				brother2 = ::Math.rand(0, brothers.len() - 1);
			}
		}

		local villages = ::World.EntityManager.getSettlements();
		local randomTown;

		do {
			randomTown = villages[::Math.rand(0, villages.len() - 1)].getNameOnly();
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
				::World.Assets.getName()
			],
			[
				"randomname",
				::Const.Strings.CharacterNames[::Math.rand(0, ::Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomnoble",
				::Const.Strings.KnightNames[::Math.rand(0, ::Const.Strings.KnightNames.len() - 1)]
			],
			[
				"randombrother",
				brothers.len() < 2 ? "unknown" : brothers[brother1].getName()
			],
			[
				"randombrother2",
				brothers.len() < 2 ? "unknown" : brothers[brother2].getName()
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
				"reward_item_count",
				this.m.Payment.Items.len()
			],
			[
				"employer",
				this.m.EmployerID != 0 ? this.Tactical.getEntityByID(this.m.EmployerID).getName() : ""
			],
			[
				"faction",
				::World.FactionManager.getFaction(this.m.Faction).getName()
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
			::Const.LegendMod.extendVarsWithPronouns(vars, this.getEmployer(), "employer");
		}
		::Const.LegendMod.extendVarsWithPronouns(vars, brothers[brother1], "randombrother");
		::Const.LegendMod.extendVarsWithPronouns(vars, brothers[brother2], "randombrother2");
		return this.buildTextFromTemplate(_text, vars);
	}

	function importCampIntro() {
		if (this.m.EmployerFaction == ::Legends.CampContracts.EmployerFaction.Barbarians) {
			this.m.Screens.extend(::Legends.CampContracts.IntroBarbarians);
		} else if (this.m.EmployerFaction == ::Legends.CampContracts.EmployerFaction.Bandits) {
			this.m.Screens.extend(::Legends.CampContracts.IntroBandits);
		} else if (this.m.EmployerFaction == ::Legends.CampContracts.EmployerFaction.Necromancers) {
			this.m.Screens.extend(::Legends.CampContracts.IntroNecromancers);
		} else if (this.m.EmployerFaction == ::Legends.CampContracts.EmployerFaction.Legion) {
			this.m.Screens.extend(::Legends.CampContracts.IntroLegion);
		}
	}

	function getHome() {
		local playerPosition = ::World.State.getPlayer().getTile();
		local settlements = ::World.EntityManager.getSettlements();
		settlements.sort(function (_lhs, _rhs) {
			local dLhs = _lhs.getDistanceTo(playerPosition);
			local dRhs = _rhs.getDistanceTo(playerPosition);
			return (dLhs < dRhs) ? -1 : ((dLhs > dRhs) ? 1 : 0);
		});
		return settlements[0];
	}

	function getOrigin() {
		return this.getHome();
	}

});
