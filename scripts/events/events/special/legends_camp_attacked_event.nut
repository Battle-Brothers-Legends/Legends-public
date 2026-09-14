this.legends_camp_attacked_event <- this.inherit("scripts/events/event", {
	m = {},

	function create() {
		this.m.ID = "event.legends_camp_attacked";
		this.m.Title = "We are under attack!";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_39.png[/img]The camp is under attack! As weapons are drawn and orders shouted, the Sergeant hands you a report of the camp's final activities before rushing to the battle line.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [],
			function start(_event) {
				if (::World.getPlayerRoster().getAll().len() == 1) {
					this.Text = "[img]gfx/ui/events/event_39.png[/img]The camp is under attack! Here is the report of your camping activities before you grab your gear and fight.";
				}
				this.Banner = "ui/banners/" + ::World.Assets.getBanner() + "s.png";
				this.Options = [
					{
						Text = "To battle!",
						function getResult(_event) {
							local combat = ::World.Camp.m.PendingCombat;
							::World.Camp.m.PendingCombat = null;
							if (combat != null) {
								::Time.scheduleEvent(::TimeUnit.Real, 50, function(_t) {
									::World.State.showCombatDialog(combat.IsPlayerInitiated, combat.IsCombatantsVisible, combat.AllowFormationPicking, combat.Properties, combat.Pos);
								}, null);
								
							}
							return 0;
						}
					}
				];
				this.List = ::World.Camp.getResults();
				this.List.sort(@(_a, _b) (_a.id > _b.id ? -1 : (_a.id < _b.id ? 1 : 0)));
			}
		});
	}

	function onUpdateScore() {}
	function onPrepareVariables(_vars) {}
	function onClear() {}
});
