this.legends_actor_interactions <- {
	m = {
		BattlesTogether = 0
	},

	function incrementKey( _key, _val = 1 )
	{
		this.m[_key] += _val;
	}

	function setKey( _key, _val )
	{
		this.m[_key] = _val;
	}

	function onDeserialize( _out )
	{
		_out.writeU16(this.m.BattlesTogether);
	}

	function onSerialize( _in )
	{
		this.m.BattlesTogether = _in.readU16();
	}
};