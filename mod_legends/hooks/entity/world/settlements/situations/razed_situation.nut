::mods_hookExactClass("entity/world/settlements/situations/razed_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.20);
		}
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		_draftList.push("beggar_background");
		_draftList.push("beggar_background");
		_draftList.push("beggar_background");
		_draftList.push("cripple_background");
		_draftList.push("cripple_background");
		_draftList.push("cripple_background");
		_draftList.push("graverobber_background");
		_draftList.push("raider_background");

		if (this.World.Assets.getOrigin().getID() == "scenario.legends_necro" || this.World.Assets.getOrigin().getID() == "scenario.legends_solo_necro") {
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
		}
		else if (this.World.Assets.getOrigin().getID() == "scenario.legends_berserker")
		{
			_draftList.push("legend_berserker_background");
		}
	}
});
