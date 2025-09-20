::FU.Class.DebugModAddon <- class extends ::FU.Class.SystemModAddon
{
	function enable()
	{
		::FU.System.Debug.setAllFlags(this.Mod.getID(), true);
	}

	function disable()
	{
		::FU.System.Debug.setAllFlags(this.Mod.getID(), false);
	}

	function setFlag( _flagID, _flagBool )
	{
		::FU.System.Debug.setFlag(this.Mod.getID(), _flagID, _flagBool);
	}

	function setFlags( _flagTable )
	{
		::FU.System.Debug.setFlags(this.Mod.getID(), _flagTable);
	}

	function isEnabled( _flagID = ::FU.System.Debug.DefaultFlag )
	{
		return ::FU.System.Debug.isEnabledForMod(this.Mod.getID(), _flagID);
	}

	function printLog( _text, _flagID = ::FU.System.Debug.DefaultFlag )
	{
		::FU.System.Debug.print(_text, this.Mod.getID(), ::FU.System.Debug.LogType.Info, _flagID);
	}

	function printWarning( _text, _flagID = ::FU.System.Debug.DefaultFlag )
	{
		::FU.System.Debug.print(_text, this.Mod.getID(), ::FU.System.Debug.LogType.Warning, _flagID);
	}

	function printError( _text, _flagID = ::FU.System.Debug.DefaultFlag )
	{
		::FU.System.Debug.print(_text, this.Mod.getID(), ::FU.System.Debug.LogType.Error, _flagID);
	}
}
