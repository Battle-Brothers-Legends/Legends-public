::FU.Class.RangeSetting <- class extends ::FU.Class.AbstractSetting
{
	Min = null;
	Max = null;
	Step = null;
	static Type = "Range";

	constructor( _id, _value, _min, _max, _step, _name = null, _description = null )
	{
		::FU.requireOneFromTypes(["integer", "float"], _min, _max, _step);
		base.constructor(_id, _value, _name, _description);

		this.Min = _min;
		this.Max = _max;
		this.Step = _step;
	}

	function getMin()
	{
		return this.Min;
	}

	function getMax()
	{
		return this.Max;
	}

	function getStep()
	{
		return this.Step;
	}

	function getUIData( _flags = [] )
	{
		local ret = base.getUIData(_flags);
		ret.min <- this.getMin();
		ret.max <- this.getMax();
		ret.step <- this.getStep();
		return ret;
	}

	function tostring()
	{
		return base.tostring() + " | Min: " + this.getMin() + " | Max: " + this.getMax() + " | Step: " + this.getStep();
	}
}
