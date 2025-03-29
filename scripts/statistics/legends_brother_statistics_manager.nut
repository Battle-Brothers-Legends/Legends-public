this.legends_brother_statistics_manager <- {
	m = {
		ActorInteractions = null,
		IDToRef = array(27, -1)
	},

	function create()
	{
		this.m.IDToRef <- array(27);
		this.m.ActorInteractions <- array(27); //suposedly this is how u do 2d arrays in squirrel, code from https://forums.electricimp.com/t/2d-array/2788
		foreach (subarr in this.m.ActorInteractions)
		{
			subarr = array(27);
		}
	}

	function addNewActorID( _actor )
	{
		for ( local i = 0; i < 27; i++ )
		{
			if (this.m.IDToRef[i] == -1)
			{
				this.m.IDToRef[i] = this.WeakTableRef(_actor);
				return i;
			}
		}
	}

	function removeActorID( _id )
	{
		this.m.IDToRef[_id] = -1;
	}

	function idExists( _id )
	{
		return !(this.m.IDToRef[_id] == -1);
	}

	function getRefFromID( _id )
	{
		if (_id == -1) return null;

		if (_id > this.m.IDToRef.len() - 1) return null;

		local val = this.m.IDToRef[_id];
		if (val == -1) {
			return null
		}
		return val;
	}

	//i.e. we can call `this.LegendsMod.getStatistics().incrementForAll("BattlesTogether")`
	//or to change specific ones this.LegendsMod.getStatistics().getInteractionBetween(id1,id2).incrementKey("BattlesTogether", 1)
	function incrementForAll( _key, _val = 1 )
	{
		for(local i = 0; i < 27; ++i)
		{
			for(local j = i + 1; j < 27; ++j)
			{
				this.m.ActorInteractions[i][j].incrementKey( _key, _val )
			}
		}
	}

	function addInteraction( _id )
	{
		//goes across and adds new tables -> i.e. addInteraction(3) adds [0][2], [1][2] -> [2][3], [2][4], ... [2][n], assuming the id exists
		for (local i = 0; i < _id - 1; ++i)
		{
			if (idExists(i))
			{
				this.m.ActorInteractions[_id - 1][i] = this.new("scripts/statistics/legends_actor_interaction");
			}

		}
		for (local i = _id; i < 27; ++i)
		{
			if (idExists(i))
			{
				this.m.ActorInteractions[i][_id - 1] = this.new("scripts/statistics/legends_actor_interaction");
			}
		}
	}

	function removeInteraction( _id )
	{
		for (local i = 0; i < 27; ++i) //clear's the column & row of ID
		{
			this.m.ActorInteractions[i][_id - 1] = null;
			this.m.ActorInteractions[_id - 1][i] = null;
		}
	}

	function getInteractionBetween( _id1, _id2 )
	{
		return ( _id1 < _id2 ? this.m.ActorInteractions[_id1][_id2] : this.m.ActorInteractions[_id2][_id1] )
	}

	function onDeserialize( _in )
	{
		//Sorta ugly but idk a better way of doing this stuff
		local i = _in.readU8();
		local j = _in.readU8();
		while( !(i==j==0) )
		{
			this.m.ActorInteractions[i][j] = this.new("scripts/statistics/legends_actor_interactions");
			this.m.ActorInteractions.onDeserialize(_in);
			i = _in.readU8();
			j = _in.readU8();
		}

		foreach(bro in this.World.getPlayerRoster().getAll())
		{
			this.m.IDToRef[bro.getCompanyID()] = this.WeakTableRef(bro);
		}
	}

	function onSerialize( _out )
	{

		//could add a flag to chop it it down cuz there'd be a ton of nulls but who cares lol it's just if statements and i'm lazy
		for (local i = 0; i < 27; ++i)
		{
			for (local j = i + 1; i < 27; ++j)
			{
				if (this.m.ActorInteractions[i][j] != null)
				{
					_out.writeU8(i);
					_out.writeU8(j);
					this.m.ActorInteractions[i][j].onSerialize(_out);
				}
			}
		}
		_out.writeU8(0);
		_out.writeU8(0);

	}
};