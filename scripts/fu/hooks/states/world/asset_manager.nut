::mods_hookNewObject("states/world/asset_manager", function(o) {
	o.m.LastDayMorningEventCalled <- 0;
	local update = o.update;
	o.update = function( _worldState )
	{
		if (::World.getTime().Hours == 1 && ::World.getTime().Hours != this.m.LastHourUpdated && ::World.getTime().Days > this.m.LastDayMorningEventCalled)
		{
			this.m.LastDayMorningEventCalled = ::World.getTime().Days;
			local roster = ::World.getPlayerRoster().getAll();
			foreach (bro in roster)
			{
				bro.getSkills().onNewMorning();
			}
			::World.Assets.getOrigin().onNewMorning();
		}

		if (::World.getTime().Days > this.m.LastDayPaid && ::World.getTime().Hours > 8 && this.m.IsConsumingAssets)
		{
			::World.Assets.getOrigin().onNewDay();
		}

		update(_worldState);
	}

	o.getLastDayMorningEventCalled <- function()
	{
		return this.m.LastDayMorningEventCalled;
	}

	o.setLastDayMorningEventCalled <- function( _day )
	{
		this.m.LastDayMorningEventCalled = _day;
	}
});
