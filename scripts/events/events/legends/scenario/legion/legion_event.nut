this.legion_event <- this.inherit("scripts/events/event", {
	m = {},
	function validateLegionEvent() {
		//see 'static_functions' ::Legends.S.humansOnly for more details.
		if (::World.Assets.getOrigin().getID() != "scenario.legend_risen_legion") {
			return false;
		}

		local hasSkeleton = false;
		foreach (bro in ::World.getPlayerRoster().getAll()) {
			if (bro.getFlags().has("PlayerSkeleton")) {
				hasSkeleton = true;
				break;
			}
		}

		if (!hasSkeleton) {
			return false;
		}

		return true;
	}
});
