::mods_hookExactClass("entity/world/settlements/situations/disbanded_troops_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.035);
		}
		onAdded( _settlement );
	}

	o.onUpdateDraftList = function ( _draftList )
	{
		for (local i = 0; i < 6; ++i)
		{
			_draftList.push(::Legends.Background.Deserter);
		}

		for (local i = 0; i < 9; ++i)
		{
			_draftList.push(::Legends.Background.Militia);
		}
		
		for (local i = 0; i < 8; ++i)
		{
			_draftList.push(::Legends.Background.RetiredSoldier);
		}

		for (local i = 0; i < 5; ++i)
		{
			_draftList.push(::Legends.Background.Squire);
		}
		
		_draftList.push(::Legends.Background.Sellsword);
		_draftList.push(::Legends.Background.Sellsword);
		_draftList.push(::Legends.Background.Sellsword);
		_draftList.push(::Legends.Background.HedgeKnight);
		_draftList.push(::Legends.Background.HedgeKnight);
		_draftList.push(::Legends.Background.HedgeKnight);
		_draftList.push(::Legends.Background.LegendNoble2h);
		_draftList.push(::Legends.Background.LegendNoble2h);
		_draftList.push(::Legends.Background.LegendNobleRanged);
		_draftList.push(::Legends.Background.LegendNobleRanged);
		_draftList.push(::Legends.Background.LegendNobleShield);
		_draftList.push(::Legends.Background.LegendNobleShield);
		_draftList.push(::Legends.Background.LegendMasterArcher);
		_draftList.push(::Legends.Background.LegendMasterArcher);
		_draftList.push(::Legends.Background.LegendMasterArcher);

		if (::Legends.Mod.ModSettings.getSetting("FemaleGenderPercent").getValue() > 0) {
			_draftList.push(::Legends.Background.LegendShieldmaiden);
			_draftList.push(::Legends.Background.LegendShieldmaiden);
			_draftList.push(::Legends.Background.LegendShieldmaiden);
		}

		if  ( this.World.Assets.getOrigin().getID() == "scenario.militia") {
			for (local i = 0; i < 6; ++i)
			{
				_draftList.push(::Legends.Background.LegendManAtArms);
			}
		}
	}
});
