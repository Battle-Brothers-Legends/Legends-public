::FU.Table <- {
	function rand( _table )
	{
		local chosenIdx = ::Math.rand(0, _table.len() - 1);
		local i = 0;
		foreach (key, value in _table)
		{
			if (i == chosenIdx) return [key, value];
			i++;
		}
	}

	function randKey( _table )
	{
		local chosenIdx = ::Math.rand(0, _table.len() - 1);
		local i = 0;
		foreach (key, value in _table)
		{
			if (i == chosenIdx) return key;
			i++;
		}
	}

	function randValue( _table )
	{
		local chosenIdx = ::Math.rand(0, _table.len() - 1);
		local i = 0;
		foreach (value in _table)
		{
			if (i == chosenIdx) return value;
			i++;
		}
	}

	function merge( _table1, _table2, _overwrite = true, _recursively = false )
	{
		foreach (key, value in _table2)
		{
			if (key in _table1)
			{
				if (!_overwrite) throw ::FU.Exception.DuplicateKey(key);
				if (_recursively && typeof value == "table" && typeof _table1[key] == "table")
				{
					this.merge(_table1[key], value, _overwrite, true);
					continue;
				}
			}
			_table1[key] <- value;
		}
		return _table1;
	}

	function keys( _table )
	{
		local ret = array(_table.len());
		local i = 0;
		foreach (key, value in _table)
		{
			ret[i] = key;
			i++;
		}

		return ret;
	}

	function values( _table )
	{
		local ret = array(_table.len());
		local i = 0;
		foreach (value in _table)
		{
			ret[i] = value;
			i++;
		}

		return ret;
	}

	function apply( _table, _function )
	{
		// _function (_key, _value)
		// must return new value for _key

		foreach (key, value in _table)
		{
			_table[key] = _function(key, value);
		}
	}

	function filter( _table, _function )
	{
		// _function (_key, _value)
		// must return boolean

		local ret = {};
		foreach (key, value in _table)
		{
			if (_function(key, value)) ret[key] <- value;
		}

		return ret;
	}	

	function map( _table, _function )
	{
		// _function (_key, _value)
		// must a len 2 array with idx 0 being new key and idx 1 being its value
		
		local ret = {};
		foreach (key, value in _table)
		{
			local pair = _function(key, value);
			ret[pair[0]] <- pair[1];
		}

		return ret;
	}
}
