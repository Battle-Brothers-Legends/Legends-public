if (!("Professions" in ::Const)) {
	::Const.Professions <- {};
}

::Const.Professions.LookupMap <- {};

::Const.Professions.findById <- function (_professionID) {
	if (_professionID != null && _professionID in this.Const.Professions.LookupMap) {
		return this.Const.Professions.LookupMap[_professionID];
	}

	return null;
};
