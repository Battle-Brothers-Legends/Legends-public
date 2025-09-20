::FU.Class.KeybindSetting <- class extends ::FU.Class.StringSetting
{
	static Type = "Keybind";

	// Temporary to fix savegames
	// TODO Remove with 1.3.0
	function __setFromSerializationTable( _table )
	{
		_table.Value = ::String.replace(_table.Value, "tabulator", "tab");
		base.__setFromSerializationTable(_table);
	}
}
