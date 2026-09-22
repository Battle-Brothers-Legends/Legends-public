if (!("Roster" in ::Legends)) {
	::Legends.Roster <- {};
}

::Legends.Roster.getNonDonkeys <- function () {
	local result = [];
	local roster = ::World.getPlayerRoster().getAll();

	foreach (b in roster) {
		if (!b.getSkills().hasSkill(::Legends.Backgrounds.getID(::Legends.Background.LegendDonkey))) {
			result.push(b);
		}
	}

	return result;
}