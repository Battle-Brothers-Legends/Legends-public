::FU.Class.StringSetting <- class extends ::FU.Class.AbstractSetting
{
	static Type = "String";

	constructor( _id, _value, _name = null, _description = null )
	{
		::FU.requireOneFromTypes(["string", "integer", "float"], _value);
		base.constructor(_id, _value, _name, _description);
	}

	function set( _newValue, _updateJS = true, _updatePersistence = true, _updateBeforeChangeCallback = true, _force = false, _updateAfterChangeCallback = true)
	{
		::FU.requireString(_newValue);
		return base.set(_newValue, _updateJS, _updatePersistence, _updateBeforeChangeCallback, _force, _updateAfterChangeCallback);
	}
}
