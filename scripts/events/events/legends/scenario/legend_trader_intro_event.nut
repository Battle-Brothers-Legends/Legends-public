this.legend_trader_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create() {
		this.m.ID = "event.legend_trader_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_24.png[/img]The open road calls you to profit. The only rule is acquisition",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "To arms!",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.logInfo("Unlocking fletching");
				this.World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Fletcher], true);
				//this.logInfo("Unlocking hunting");
				//this.World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Hunter], true);
				this.logInfo("Unlocking scouting");
				this.World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Scout], true);
			}
		});
	}

	function onUpdateScore() {}

	function onPrepare() {
		this.m.Title = "Legend Trader";
	}

	function onPrepareVariables(_vars) {
		_vars.push([
			"home",
			this.World.Flags.get("HomeVillage")
		]);
	}

	function onClear() {}

});
