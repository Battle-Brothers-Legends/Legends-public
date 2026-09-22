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

::Legends.Roster.getHumans <- function (_returnFullRosterIfEmpty=false) {
	local result = [];
	local roster = ::World.getPlayerRoster().getAll();

	foreach (b in roster) {
		if (::Legends.S.humansOnly(b)) {
			result.push(b);
		}
	}

	if (_returnFullRosterIfEmpty && result.len() == 0) {
		return ::World.getPlayerRoster().getAll();
	}

	return result;
}