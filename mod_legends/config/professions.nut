if (!("Professions" in ::Const)) {
	::Legends.Professions <- {};
}

::Legends.Professions.LookupMap <- {};

::Legends.Professions.findById <- function (_professionID) {
	if (_professionID != null && _professionID in ::Legends.Professions.LookupMap) {
		return ::Legends.Professions.LookupMap[_professionID];
	}

	return null;
};
