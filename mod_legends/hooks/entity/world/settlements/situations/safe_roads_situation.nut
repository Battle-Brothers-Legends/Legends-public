::mods_hookExactClass("entity/world/settlements/situations/safe_roads_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.1);
		
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("vagabond_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("messenger_background");
		_draftList.push("gambler_background");
		_draftList.push("tailor_background");
		_draftList.push("minstrel_background");
		_draftList.push("historian_background");
		_draftList.push("adventurous_noble_background");
		_draftList.push("adventurous_noble_background");
		_draftList.push("legend_donkey_background");

		if ( this.World.Assets.getOrigin().getID() == "scenario.legends_crusader") {
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
		}
		else if ( this.World.Assets.getOrigin().getID() == "scenario.militia") {
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
		}
	}
});
