::mods_hookNewObject("statistics/statistics_manager", function(o) {

	o.onSerialize = function ( _out )
	{
		this.m.Flags.onSerialize(_out);
		_out.writeU8(this.m.News.len());

		foreach( n in this.m.News )
		{
			_out.writeString(n.Type);
			_out.writeF32(n.Time);
			n.onSerialize(_out);
		}

		_out.writeU32(this.m.Fallen.len());

		foreach( f in this.m.Fallen )
		{
			_out.writeString(f.Name);
			_out.writeU32(f.Time);
			_out.writeU32(f.TimeWithCompany);
			_out.writeU32(f.Kills);
			_out.writeU32(f.Battles);
			_out.writeString(f.KilledBy);

			if (f.len() > 6)
			{
				_out.writeU8(f.level);
				_out.writeU8(f.traits.len());

				foreach( trait in f.traits )
				{
					_out.writeString(trait);
				}

				_out.writeU8(f.stats.len());

				foreach( stat in f.stats )
				{
					_out.writeU32(stat);
				}

				_out.writeU8(f.talents.len());

				foreach( talent in f.talents )
				{
					_out.writeU8(talent);
				}
			}
			else
			{
				_out.writeU8(-99);
				_out.writeU8(4);

				for( local i = 0; i < 4; i = ++i )
				{
					_out.writeString("");
				}

				_out.writeU8(8);

				for( local i = 0; i < 8; i = ++i )
				{
					_out.writeU32(-99);
				}

				_out.writeU8(8);

				for( local i = 0; i < 8; i = ++i)
				{
					_out.writeU8(-99);
				}
			}

			_out.writeBool(f.Expendable);
			//_out.writeBool(false);
		}
	}

	o.onDeserialize = function ( _in )
	{
		this.m.Flags.onDeserialize(_in);
		local numNews = _in.readU8();
		this.m.News.resize(numNews);

		for( local i = 0; i < numNews; i = ++i )
		{
			local news = this.new("scripts/tools/tag_collection");
			news.Type <- _in.readString();
			news.Time <- _in.readF32();
			news.onDeserialize(_in);
			this.m.News[i] = news;
		}

		local numFallen = _in.readU32();
		this.m.Fallen.resize(numFallen);

		for( local i = 0; i < numFallen; i = ++i )
		{
			local f = {};
			f.Name <- _in.readString();
			f.Time <- _in.readU32();
			f.TimeWithCompany <- _in.readU32();
			f.Kills <- _in.readU32();
			f.Battles <- _in.readU32();
			f.KilledBy <- _in.readString();

			f.level <- _in.readU8();
			f.traits <- [];
			local numtraits = _in.readU8();

			for( local i = 0; i != numtraits; i++ )
			{
				f.traits.push(_in.readString());
			}

			f.stats <- [];
			local numstats = _in.readU8();

			for( local i = 0; i != numstats; i++ )
			{
				f.stats.push(_in.readU32());
			}

			f.talents <- [];
			local numtalents = _in.readU8();

			for( local i = 0; i != numtalents; i++ )
			{
				f.talents.push(_in.readU8());
			}

			f.Expendable <- _in.readBool();
			//_in.readBool();
			this.m.Fallen[i] = f;
		}
	}
});
