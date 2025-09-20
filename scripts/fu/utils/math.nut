::FU.Math <- {
	// returns log2 of _num, floored (as an int)
	function log2int( _num )
	{
		local count = 0;
		while (_num > 1) 
		{
			_num = _num >> 1;
			count++;
		}
		return count;
	}

	// Returns the normalized value of the normal distribution at _x
	function normalDistNorm( _x, _mean, _std )
	{
		return exp(-0.5 * pow((_x - _mean)/_std.tofloat(), 2));
	}

	// Returns the value of the normal distribution at _x
	function normalDist( _x, _mean, _std )
	{
		return exp(-0.5 * pow((_x - _mean)/(_std * 1.0), 2)) / (_std * sqrt(2 * 3.14));			
	}

	function randf( _min, _max )
	{
		::FU.requireFloat(_min, _max);
		return _min + (::Math.rand(0, 2147483647) / 2147483647.0) * (_max - _min);
	}
};
