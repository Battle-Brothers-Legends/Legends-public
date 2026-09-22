this.legion_event <- this.inherit("scripts/events/event", {
	m = {},
	function validateLegionEvent() {
		//see 'static_functions' ::Legends.S.humansOnly for more details.
		if (::World.Assets.getOrigin().getID() != "scenario.legend_risen_legion") {
			return false;
		}
		
		return ::World.getPlayerRoster().getAll().filter(@(_, _bro) (::MSU.isKindOf(_bro, "legend_player_legion"))).len() > 0;
	}
});
