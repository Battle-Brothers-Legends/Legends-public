this.script_container <- {
	m = {
		Total = 0,
		Array = []
	},

	function extend(_array)
	{
		foreach (i in _array) this.push(i);
	}

	function push(_i)
	{
		if (typeof(_i) == "string") _i = [1, _i];

		this.m.Total += _i[0];
		this.m.Array.push(_i);
	}

	function roll()
	{
		local i = this.Math.rand(1, this.m.Total);
		local weight = 0;
		foreach (pair in this.m.Array)
		{
			::logInfo("Pair " + pair + "pair[0]: " + pair[0] + "Pair[1]: " + pair[1]);
			weight += pair[0];
			if (weight >= i) return pair[1];
		}
		return null;
	}

	function rollChance(_chance)
	{
		return _chance < this.Math.rand(1, 100) ? this.roll() : null;
	}

	function get(_idx)
	{
		return this.m.Array[_idx];
	}

	function len()
	{
		return this.m.Array.len();
	}

	function onSerialize( _out )
	{
		_out.writeU32(this.m.Total);
		_out.writeU32(this.len());
		foreach (pair in this.m.Array)
		{
			_out.writeU16(pair[0]);
			_out.writeString(pair[1]);
		}
	}

	function onDeserialize( _in )
	{
		this.m.Total = _in.readU32();
		for (local i = 0; i < _in.readU32(); ++i) 
		{
			this.m.Array.push([_in.readU16(), _in.readString()]);
		}
	}
}
