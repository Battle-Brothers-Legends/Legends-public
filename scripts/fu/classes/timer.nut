::FU.Class.Timer <- class
{
	ID = null;
	Start = null;
	PauseStart = null;
	PauseIncrement = null;

	constructor( _id )
	{
		this.ID = _id;
		this.Start = ::Time.getExactTime();
		this.PauseIncrement = 0;
	}

	function silentGet()
	{
		local pauseIncrement = this.PauseIncrement;
		if (this.PauseStart != null)
			pauseIncrement += ::Time.getExactTime() - this.PauseStart;

	    return (::Time.getExactTime() - this.Start - pauseIncrement) * 1000;
	}

	function get( _msg = "", _stop = false )
	{
		local time = this.silentGet()
		local text = format("Timer: %s %s at %f ms", this.ID, _stop ? "stopped" : "currently", time);
		if(_msg != "") text += " | Msg: " + _msg;
		::logInfo(text);
	    return time;
	}

	function pause()
	{
		if (this.PauseStart != null)
		{
			::FU.Mod.Debug.printWarning(format("Timer %s paused despite already being paused!", this.ID), "performance");
		}
		this.PauseStart = ::Time.getExactTime();
	}

	function unpause()
	{
		if (this.PauseStart == null)
		{
			::FU.Mod.Debug.printWarning(format("Timer %s resumed despite not being paused!", this.ID), "performance");
			return;
		}
		this.PauseIncrement += ::Time.getExactTime() - this.PauseStart;
		this.PauseStart = null;
	}

	function stop( _msg = "" )
	{
	    delete ::FU.Utils.Timers[this.ID];
	    return this.get(_msg, true);
	}

	function silentStop()
	{
		delete ::FU.Utils.Timers[this.ID];
		return this.silentGet();
	}
}
