::FU.Class.CustomTooltip <- class extends ::FU.Class.Tooltip
{
	Function = null;

	constructor( _function, _data = null )
	{
		this.setFunction(_function);
		base.constructor(_data);
	}

	function setFunction( _function )
	{
		::FU.requireFunction(_function)
		this.Function = _function;
	}

	function getUIData( _data )
	{
		return this.Function(_data);
	}
}
