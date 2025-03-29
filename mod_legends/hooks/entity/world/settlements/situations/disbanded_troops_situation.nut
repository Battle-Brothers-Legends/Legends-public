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
			_draftList.push("deserter_background");
		}

		for (local i = 0; i < 9; ++i)
		{
			_draftList.push("militia_background");
		}
		
		for (local i = 0; i < 8; ++i)
		{
			_draftList.push("retired_soldier_background");
		}

		for (local i = 0; i < 5; ++i)
		{
			_draftList.push("squire_background");
		}
		
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("hedge_knight_background");
		_draftList.push("hedge_knight_background");
		_draftList.push("hedge_knight_background");
		_draftList.push("legend_noble_2h");
		_draftList.push("legend_noble_2h");
		_draftList.push("legend_noble_ranged");
		_draftList.push("legend_noble_ranged");
		_draftList.push("legend_noble_shield");
		_draftList.push("legend_noble_shield");
		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");

		if (::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled") {
			_draftList.push("legend_shieldmaiden_background");
			_draftList.push("legend_shieldmaiden_background");
			_draftList.push("legend_shieldmaiden_background");
		}

		if  ( this.World.Assets.getOrigin().getID() == "scenario.militia") {
			for (local i = 0; i < 6; ++i)
			{
				_draftList.push("legend_man_at_arms_background");
			}
		}
	}
});
