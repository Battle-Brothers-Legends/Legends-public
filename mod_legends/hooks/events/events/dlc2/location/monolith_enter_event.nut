::mods_hookExactClass("events/events/dlc2/location/monolith_enter_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "B", function (_screen) {
			_screen.Options[0].getResult <- function (_event) {
				if (::World.State.getLastLocation() != null) 
				{
					::World.State.getLastLocation().setAttackable(true);
					if (::World.Assets.getOrigin().getID() == "scenario.legend_risen_legion") 
					{
						::World.State.getLastLocation().setAttackable(false);
						::World.State.getLastLocation().setFaction(::World.FactionManager.getFactionOfType(::Const.FactionType.Undead).getID());
						// ::World.State.getLastLocation().setFaction(::World.FactionManager.getFactionOfType(::Const.FactionType.Bandits).getID()); // - we will rework this later when we have legion township art. - Luft 30/5/26
					} 

					else
					{
						::World.State.getLastLocation().setFaction(::World.FactionManager.getFactionOfType(::Const.FactionType.Undead).getID());
					}
				}
				::World.Events.showCombatDialog(true, true, true);
				return 0;
			}
		});
	}
});
