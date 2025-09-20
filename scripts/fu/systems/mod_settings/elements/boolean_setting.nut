::FU.Class.BooleanSetting <- class extends ::FU.Class.AbstractSetting
{
	static Type = "Boolean";

	constructor( _id, _value, _name = null, _description = null )
	{
		::FU.requireBool(_value);
		base.constructor(_id, _value, _name, _description);
	}

	function set( _newValue, _updateJS = true, _updatePersistence = true, _updateBeforeChangeCallback = true, _force = false, _updateAfterChangeCallback = true)
	{
		::FU.requireBool(_newValue);
		return base.set(_newValue, _updateJS, _updatePersistence, _updateBeforeChangeCallback, _force, _updateAfterChangeCallback);
	}

	function toggle()
	{
		this.set(!this.Value);
	}
}
