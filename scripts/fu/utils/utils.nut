::FU.Utils <- {
	DataType = {
		Integer = 0,
		Float = 1,
		Boolean = 2,
		String = 3,
		Array = 4,
		Table = 5,
		Class = 6,
		Instance = 7,
		Null = 8
	},
	Timers = {}
	States = {},

	function getDataType( _var )
	{
		switch (typeof _var)
		{
			case "integer":
				return this.DataType.Integer;
			case "float":
				return this.DataType.Float;
			case "bool":
				return this.DataType.Boolean;
			case "string":
				return this.DataType.String;
			case "array":
				return this.DataType.Array;
			case "table":
				return this.DataType.Table;
			case "class":
				return this.DataType.Class;
			case "instance":
				return this.DataType.Instance;
			case "null":
				return this.DataType.Null;
		}
	}

	function serialize( _object, _out )
	{
		::FU.requireOneFromTypes(["array", "table"], _object);

		local type = typeof _object;
		local isTable = type == "table";

		if (isTable) _out.writeU8(this.DataType.Table);
		else _out.writeU8(this.DataType.Array);

		_out.writeU32(_object.len());

		foreach (key, element in _object)
		{
			if (isTable) _out.writeString(key);
			local dataType = typeof element;

			switch (dataType)
			{
				case "integer":
					_out.writeU8(this.DataType.Integer);
					if (element < 0)
					{
						_out.writeBool(true);
						_out.writeI32(element);
					}
					else
					{
						_out.writeBool(false);
						_out.writeU32(element);
					}
					break;

				case "float":
					_out.writeU8(this.DataType.Float);
					_out.writeF32(element);
					break;

				case "bool":
					_out.writeU8(this.DataType.Boolean);
					_out.writeBool(element);
					break;

				case "string":
					_out.writeU8(this.DataType.String);
					_out.writeString(element);
					break;

				case "array":
					_out.writeU8(this.DataType.Array);
					this.serialize(element, _out);
					break;

				case "table":
					_out.writeU8(this.DataType.Table);
					this.serialize(element, _out);
					break;

				case "null":
					_out.writeU8(this.DataType.Null);
					break;

				default:
					throw ::FU.Exception.InvalidType(element);
			}
		}
	}

	function deserialize( _in )
	{
		local type = _in.readU8();
		local isTable = type == this.DataType.Table;
		local size = _in.readU32();

		local ret = isTable ? {} : array(size);

		for (local i = 0; i < size; i++)
		{
			local key = isTable ? _in.readString() : null;
			local dataType = _in.readU8();
			local val;

			switch (dataType)
			{
				case this.DataType.Integer:
					val = _in.readBool() ? _in.readI32() : _in.readU32();
					break;

				case this.DataType.Float:
					val = _in.readF32();
					break;

				case this.DataType.Boolean:
					val = _in.readBool();
					break;

				case this.DataType.String:
					val = _in.readString();
					break;

				case this.DataType.Array:
				case this.DataType.Table:
					val = this.deserialize(_in);
					break;

				case this.DataType.Null:
					val = null;
					break;
				default:
					throw ::FU.Exception.InvalidType(dataType);
			}

			if (isTable) ret[key] <- val;
			else ret[i] = val;
		}

		return ret;
	}

	function deserializeInto( _object, _in )
	{
		::FU.requireOneFromTypes(["table", "array"], _object);

		local deserializedObj = ::FU.Utils.deserialize(_in);

		if (typeof _object == "table") return ::FU.Table.merge(_object, deserializedObj);

		_object.resize(::Math.max(_object.len(), deserializedObj.len()));
		foreach (i, value in deserializedObj)
		{
			_object[i] = value;
		}
		return _object;
	}

	function operatorCompare( _compareResult, _operator )
	{
		switch (_compareResult)
		{
			case -1:
				if (["<", "<="].find(_operator) != null) return true;
				return false;

			case 0:
				if (["<=", "=", null, ">="].find(_operator) != null) return true;
				return false;

			case 1:
				if ([">", ">="].find(_operator) != null) return true;
				return false;
		}
		throw ::FU.InvalidValue(_compareResult);
	}

	function getActiveState()
	{
		foreach (name, state in this.States)
		{
			if (!state.isNull() && state.isVisible() && name != "root_state")
			{
				return state;
			}
		}
	}

	function hasState(_id)
	{
		return (_id in this.States && !this.States[_id].isNull());
	}

	function getState(_id)
	{
		if (!(_id in this.States))
		{
			::logError("_id must be a valid state name!");
			throw ::FU.Exception.KeyNotFound(_id);
		}
		return this.States[_id];
	}

	function Timer(_id)
	{
		if (_id in this.Timers) return this.Timers[_id];
	    this.Timers[_id] <- ::FU.Class.Timer(_id);
	    return this.Timers[_id];
	}

	// Deprecated - use ::FU.AI.addBehavior instead
	function addAIBehaviour(_id, _name, _order, _score = null)
	{
		return ::FU.AI.addBehavior(_id, _name, _order, _score);
	}
}
