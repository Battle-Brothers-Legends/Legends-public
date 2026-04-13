::mods_hookExactClass("events/events/special/desertion_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Options = [{
					Text = "{I can hardly force any of them to remain with the company... | Bad news, indeed. | A momentary setback. | I can not let something like this happen again. | This will impact the bottom line.}",
					function getResult( _event )
					{
						if (this.World.Assets.getEconomicDifficulty() != this.Const.Difficulty.Hard && this.World.Assets.getEconomicDifficulty() != this.Const.Difficulty.Legendary)
							_event.m.Deserter.getItems().transferToStash(this.World.Assets.getStash());

						_event.m.Deserter.getSkills().onDeath(this.Const.FatalityType.None);
						::Legends.addFallen(_event.m.Deserter, "Deserted the company");
						this.World.getPlayerRoster().remove(_event.m.Deserter);
						_event.m.Deserter = null;
						_event.m.Other = null;
						return 0;
					}
				}]
			}
		}
	}
})
