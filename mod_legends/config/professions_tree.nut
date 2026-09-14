if (!("Professions" in ::Const)) {
	::Const.Professions <- {};
}

::Const.Professions.DefaultProfessionTree <- [
	[
		::Legends.Profession.LegendCooking,
		::Legends.Profession.LegendCrafting,
		::Legends.Profession.LegendFletching,
		::Legends.Profession.LegendGathering,
		::Legends.Profession.LegendHealing,
		::Legends.Profession.LegendRepairing,
		::Legends.Profession.LegendScrapping,
		::Legends.Profession.LegendScouting,
		::Legends.Profession.LegendTraining
	],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Const.Professions.BuildCustomProfessionTree <- function (_custom) {
	local pT = {
		Tree = [],
		Map = {}
	};
	pT.addProfession <- function (_profession, _row = 0) {
		local profession = clone ::Const.Professions.ProfessionDefObjects[_profession];

		if (profession.ID in this.Map) {
			return;
		}

		profession.Row <- _row;
		profession.Unlocks <- _row;
		
		for (local i = this.Tree.len(); i < _row + 1; i = ++i) {
			this.Tree.push([]);
		}
		this.Tree[_row].push(profession);
		this.Map[profession.ID] <- profession;
	}

	pT.addTree <- function (_tree) {
		foreach (i, row in _tree) {
			foreach (p in row) {
				this.addProfession(p, i);
			}
		}
	}

	pT.addTree(_custom);

	return pT;
};

::Const.Professions.ProfessionsTreeTemplate <- ::Const.Professions.BuildCustomProfessionTree(::Const.Professions.DefaultProfessionTree)
