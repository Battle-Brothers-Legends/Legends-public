::mods_hookExactClass("events/events/dlc2/location/monolith_enter_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.Options[0].getResult <- function (_event) {
					if (this.World.State.getLastLocation() != null) {
						this.World.State.getLastLocation().setAttackable(true);
						if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
							this.World.State.getLastLocation().setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						else
							this.World.State.getLastLocation().setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID());
					}
					this.World.Events.showCombatDialog(true, true, true);
					return 0;
				}
			}
		}
	}
});
