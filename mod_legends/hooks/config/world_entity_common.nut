::Const.World.Common.addTroop = function( _party, _troop, _updateStrength = true, _minibossify = 0 )
{
	local troop = clone _troop.Type;
	troop.Party <- this.WeakTableRef(_party);
	troop.Faction <- _party.getFaction();
	troop.Name <- "";

	if (troop.Variant > 0)
	{
		_minibossify = _minibossify + this.World.Assets.m.ChampionChanceAdditional;
		local upperBound = ("DieRoll" in troop) ? troop.DieRoll : 100;
		if (!this.Const.DLC.Wildmen || this.Math.rand(1, upperBound) > troop.Variant + _minibossify + (this.World.getTime().Days > 90 ? 0 : -1))
		{
			troop.Variant = 0;
		}
		else
		{
			troop.Strength = this.Math.round(troop.Strength * 1.35);
			troop.Variant = this.Math.rand(1, 255);

			if ("NameList" in _troop.Type)
			{
				troop.Name = this.generateName(_troop.Type.NameList) + ((_troop.Type.TitleList != null) ? " " + _troop.Type.TitleList[this.Math.rand(0, _troop.Type.TitleList.len() - 1)] : "");
			}
		}
	}

	_party.getTroops().push(troop);

	if (_updateStrength)
	{
		_party.updateStrength();
	}

	return troop;
};

// TODO - this should be called at very end of loading order, like after all mods are already loaded, is it possible? - chopeks
function onCostCompare( _t1, _t2 )
{
	if (_t1.Cost < _t2.Cost)
		return -1;
	else if (_t1.Cost > _t2.Cost)
		return 1;
	return 0;
}

foreach(k, v in this.Const.World.Spawn)
{
	if (k == "Troops" || k == "Unit" || k == "TroopsMap")
	{
		continue;
	}

	if (typeof(v) != "table")
	{
		continue;
	}

	//this.logInfo("Calculating costs for " + k)
	foreach (i, _t in v.Troops)
	{
		local costMap = {}
		foreach (tt in _t.Types) {
			if (!(tt.Cost in costMap)) {
				costMap[tt.Cost] <- []
			}
			costMap[tt.Cost].append(tt)
		}

		_t.SortedTypes <- []

		foreach (k,v in costMap) {
			_t.SortedTypes.append({
				Cost = k,
				Types = v
			})
		}

		if (_t.SortedTypes.len() == 1)
		{
			continue;
		}

		_t.SortedTypes.sort(this.onCostCompare)

		//v.Troops[i].SortedTypes.sort(this.onCostCompare)

		local mean = 0;
		local variance = 0;
		local deviation = 0;

		foreach (o in v.Troops[i].SortedTypes)
		{
			mean += o.Cost;
		}
		mean = (mean * 1.0) / ( v.Troops[i].SortedTypes.len() * 1.0)

		foreach (o in v.Troops[i].SortedTypes)
		{
			local d = o.Cost - mean;
			variance += (d * d);
		}
		variance = (variance * 1.0) / ( v.Troops[i].SortedTypes.len() * 1.0)
		deviation = this.Math.pow(variance, 0.5)


		v.Troops[i].Mean <- mean;
		v.Troops[i].Variance <- variance;
		v.Troops[i].Deviation <- deviation;
		v.Troops[i].MinMean <- v.Troops[i].SortedTypes[0].Cost - deviation;
		v.Troops[i].MaxMean <-  v.Troops[i].Types[v.Troops[i].SortedTypes.len() - 1].Cost + deviation;
		//this.logInfo(" mean  " + mean + " variance " + variance + " deviation " + deviation + " min " + v.Troops[i].MinMean + " max " + v.Troops[i].MaxMean)
	}

}
