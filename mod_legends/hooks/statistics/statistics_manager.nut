::mods_hookNewObject("statistics/statistics_manager", function (o) {

	o.popNews = function (_type) {
		foreach (i, n in this.m.News) {
			if (n.Type == _type) {
				this.m.News.remove(i);
				return n;
			}
		}
	}

	o.addNews = function (_type, _news) {
		_news.Type <- _type;
		_news.Time <- this.Time.getVirtualTimeF();

		if (this.m.News.len() >= 10) {
			this.m.News.remove(0);
		}

		this.m.News.push(_news);
	}

	local onSerialize = o.onSerialize;
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

		onSerialize(_out);
	};

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function(_in)
	{
		onDeserialize(_in);

		// Then restore extended mod data
		local data = ::Legends.Mod.Serialization.flagDeserialize("BetterObituary", [], null, this.getFlags());
		if (data.len() == 0)
			return;

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
