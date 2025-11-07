::Legends.Screens <- {};

/**
* Simple hook for screens, works with contracts, events and encounters
*/
::Legends.Screens.hook <- function (_event, _id, _fn) {
	foreach (s in _event.m.Screens) {
		if (s.ID == _id) {
			return _fn(s);
		}
	}
	::logError(::format("screen with ID=%s not found", _id));
}
