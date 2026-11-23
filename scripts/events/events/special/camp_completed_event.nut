this.camp_completed_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.camp_completed";
		this.m.Title = "Camp Report";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]Afer a well deserved rest, the company Sergeant hands you a report from the previous nights activites.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [],
			function onSortByID( _a, _b )
			{
				if (_a.id > _b.id)
				{
					return -1;
				}
				else if (_a.id < _b.id)
				{
					return 1;
				}

				return 0;
			},
			function start( _event )
			{
				this.Music.setTrackList(this.Const.Music.VictoryTracks, this.Const.Music.CrossFadeTime);
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
				this.Options = [
					{
						Text = "Time to get moving",
						function getResult( _event )
						{
							this.Music.setTrackList(this.Const.Music.WorldmapTracks, this.Const.Music.CrossFadeTime, true);
							return 0;
						}
					},
					{
						Text = "Back to camp",
						function getResult( _event )
						{
							this.Music.setTrackList(this.Const.Music.WorldmapTracks, this.Const.Music.CrossFadeTime, true);
							this.Time.scheduleEvent(this.TimeUnit.Real, 500, function ( _t )
							{
								this.World.State.showCampScreen();
							}, null);							
							return 0;
						}

					}					
				];
				this.List = this.World.Camp.getResults();
				this.List.sort(this.onSortByID)
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});
