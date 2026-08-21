this.camp_completed_event <- this.inherit("scripts/events/event", {
	m = {},
	function create() {
		this.m.ID = "event.camp_completed";
		this.m.Title = "Camp Report";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]Afer a well deserved rest, the company Sergeant hands you a report from the camp's activities.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [],
			function start(_event) {
				if (::World.getPlayerRoster().getAll().len() == 1) {
					this.Text = "[img]gfx/ui/events/event_39.png[/img]Afer a well deserved rest, here's the report of your camping activities.";
				}
				::Music.setTrackList(::Const.Music.VictoryTracks, ::Const.Music.CrossFadeTime);
				this.Banner = "ui/banners/" + ::World.Assets.getBanner() + "s.png";
				this.Options = [{
					Text = "Time to get moving",
					function getResult(_event) {
						::Music.setTrackList(::Const.Music.WorldmapTracks, ::Const.Music.CrossFadeTime, true);
						return 0;
					}
				}, {
					Text = "Back to camp",
					function getResult(_event) {
						::Music.setTrackList(::Const.Music.WorldmapTracks, ::Const.Music.CrossFadeTime, true);
						::Time.scheduleEvent(::TimeUnit.Real, 500, function(_t) {
							::World.State.showCampScreen();
						}, null);
						return 0;
					}
				}];
				this.List = ::World.Camp.getResults();
				this.List.sort(@(_a, _b) (_a.id > _b.id ? -1 : (_a.id < _b.id ? 1 : 0)));
			}
		});
	}

	function onUpdateScore() {}
	function onPrepareVariables(_vars) {}
	function onClear() {}
});
