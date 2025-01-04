::mods_hookExactClass("entity/world/settlements/situations/seasonal_fair_situation", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Rumors.push("Big fairs like the one over in %settlement% atract the worst kinds of people, minstrels and troubadours.");
	}

	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.1);
		
		onAdded( _settlement );
	}

	o.onUpdateDraftList = function ( _draftList )
	{
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("juggler_background");
		_draftList.push("juggler_background");
		_draftList.push("juggler_background");
		_draftList.push("minstrel_background");
		_draftList.push("minstrel_background");
		_draftList.push("minstrel_background");
		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");

		if ( this.World.Assets.getOrigin().getID() == "scenario.militia") {
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
		}
		else if ( this.World.Assets.getOrigin().getID() == "scenario.legends_troupe") {
			_draftList.push("legend_illusionist_background");
		}
	}
});
