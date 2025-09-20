::FU.Class.ColorPickerSetting <- class extends ::FU.Class.AbstractSetting
{
	static Type = "ColorPicker";

	constructor( _id, _value, _name = null, _description = null )
	{
		_value = ::FU.String.replace(_value, " ", "", true);
		base.constructor(_id, _value, _name, _description);
	}

	function getValueAsTable()
	{
		local asArray = split(this.Value, ",");
		local asTable = {
			Red = asArray[0],
			Green = asArray[1],
			Blue = asArray[2],
			Alpha = asArray[3],
		};
		return asTable;
	}

	function getValueAsRGBA()
	{
		local asRGBA = "rgba(";
		local asArray = split(this.Value, ",");
		asRGBA += asArray[0] + ", ";
		asRGBA += asArray[1] + ", ";
		asRGBA += asArray[2] + ", ";
		asRGBA += asArray[3] + ");";
		return asRGBA;
	}

	function getValueAsHexString()
	{
		local asArray = split(this.Value, ",");
		local red = format("%x", asArray[0].tointeger());
		local green = format("%x", asArray[1].tointeger());
		local blue = format("%x", asArray[2].tointeger());
		local opacity = format("%x", (asArray[3].tofloat() * 255).tointeger());
		if (red.len() == 1) red = "0" + red;
		if (green.len() == 1) green = "0" + green;
		if (blue.len() == 1) blue = "0" + blue;
		if (opacity.len() == 1) opacity = "0" + opacity;
		return  red + green + blue + opacity;
	}

	function getUIData( _flags = [] )
	{
		local ret = base.getUIData(_flags);
		ret.data.values <- this.getValueAsTable();
		ret.data.valuesRGBA <- this.getValueAsRGBA();
		return ret;
	}

	function tostring()
	{
		local ret = base.tostring() + " | Values: \n";
		foreach (key, value in this.getValueAsTable())
		{
			ret += key + " : " + value + "\n";
		}
		return ret;
	}
}
