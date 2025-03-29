::mods_hookExactClass("ui/screens/world/world_screen", function(o) {
	o.m.DevConsoleIsVisible <- false;

	o.devConsoleVisible <- function ()
	{
		return this.m.DevConsoleIsVisible != null && this.m.DevConsoleIsVisible == true;
	}

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.DevConsoleIsVisible = false;
	}

	o.onDevConsoleCommand <- function ( _data )
	{
		this.LegendsMod.onDevConsole(_data[0], _data[1])
	}

	o.onDevConsoleIsVisible <- function ( _data )
	{
		this.m.DevConsoleIsVisible = _data[0];
	}

	o.showDevConsole <- function (_immediately = false)
	{
		if (this.m.JSHandle != null)
		{
			this.m.JSHandle.asyncCall("showDevConsole", _immediately);
		}
	}

	o.hideDevConsole <- function (_immediately = false)
	{
		if (this.m.JSHandle != null)
		{
			this.m.JSHandle.asyncCall("hideDevConsole", _immediately);
		}
	}
});
