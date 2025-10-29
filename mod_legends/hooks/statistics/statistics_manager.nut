::mods_hookNewObject("statistics/statistics_manager", function(o)
{
	////////////////////////////////////////////////////////////////////////////////
	// Functionally redundant old save method - replaced by MSU flag serialization
	// Removing will break saves, so wait until something else forces clean saves.
	////////////////////////////////////////////////////////////////////////////////
	local base_onSerialize = function(_out)
	{
		this.m.Flags.onSerialize(_out);
		_out.writeU8(this.m.News.len());

		foreach(n in this.m.News)
		{
			_out.writeString(n.Type);
			_out.writeF32(n.Time);
			n.onSerialize(_out);
		}

		_out.writeU32(this.m.Fallen.len());

		foreach(f in this.m.Fallen)
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
				foreach(trait in f.traits) _out.writeString(trait);

				_out.writeU8(f.stats.len());
				foreach(stat in f.stats) _out.writeU32(stat);

				_out.writeU8(f.talents.len());
				foreach(talent in f.talents) _out.writeU8(talent);
			}
			else
			{
				_out.writeU8(-99);
				_out.writeU8(4);
				for(local i = 0; i < 4; i++) _out.writeString("");
				_out.writeU8(8);
				for(local i = 0; i < 8; i++) _out.writeU32(-99);
				_out.writeU8(8);
				for(local i = 0; i < 8; i++) _out.writeU8(-99);
			}

			_out.writeBool(f.Expendable);
		}
	};

	local base_onDeserialize = function(_in)
	{
		this.m.Flags.onDeserialize(_in);
		local numNews = _in.readU8();
		this.m.News.resize(numNews);

		for(local i = 0; i < numNews; i++)
		{
			local news = this.new("scripts/tools/tag_collection");
			news.Type <- _in.readString();
			news.Time <- _in.readF32();
			news.onDeserialize(_in);
			this.m.News[i] = news;
		}

		local numFallen = _in.readU32();
		this.m.Fallen.resize(numFallen);

		for(local i = 0; i < numFallen; i++)
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
			for(local j = 0; j < numtraits; j++) f.traits.push(_in.readString());

			f.stats <- [];
			local numstats = _in.readU8();
			for(local j = 0; j < numstats; j++) f.stats.push(_in.readU32());

			f.talents <- [];
			local numtalents = _in.readU8();
			for(local j = 0; j < numtalents; j++) f.talents.push(_in.readU8());

			f.Expendable <- _in.readBool();
			this.m.Fallen[i] = f;
		}
	};

	// New flag based serialization for extended fallen data (safe to add to for ongoing saves)
	o.onSerialize = function(_out)
	{
		// Create extended Fallen data for flag serialization
		local extendedFallenData = this.m.Fallen.map(function(_fallen)
		{
			return {
				Level = "level" in _fallen ? _fallen.level : 0,
				Traits = "traits" in _fallen ? _fallen.traits : [],
				Perks = "perks" in _fallen ? _fallen.perks : [],
				Injures = "perminjuries" in _fallen ? _fallen.perminjuries : [],
				Stats = "stats" in _fallen ? _fallen.stats : [],
				Talents = "talents" in _fallen ? _fallen.talents : []
			};
		});

		::Legends.Mod.Serialization.flagSerialize("BetterObituary", extendedFallenData, this.getFlags());

		// Then perform normal serialization
		base_onSerialize.call(this, _out);
	};

	o.onDeserialize = function(_in)
	{
		// Perform normal deserialization first
		base_onDeserialize.call(this, _in);

		// Then restore extended mod data
		local data = ::Legends.Mod.Serialization.flagDeserialize("BetterObituary", [], null, this.getFlags());
		if (data.len() == 0) return;

		foreach(index, entry in data)
		{
			if (index >= this.m.Fallen.len()) break;

			this.m.Fallen[index].level <- "Level" in entry ? entry.Level : 0;
			this.m.Fallen[index].traits <- "Traits" in entry ? entry.Traits : [];
			this.m.Fallen[index].perks <- "Perks" in entry ? entry.Perks : [];
			this.m.Fallen[index].perminjuries <- "Injures" in entry ? entry.Injures : [];
			this.m.Fallen[index].stats <- "Stats" in entry ? entry.Stats : [];
			this.m.Fallen[index].talents <- "Talents" in entry ? entry.Talents : [];
		}
	};
});
