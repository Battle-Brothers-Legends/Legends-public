::mods_hookExactClass("entity/world/settlements/situations/cultist_procession_situation", function(o)
{
	o.onUpdateDraftList <- function ( _draftList )
	{
		for (local i = 0; i < 16; ++i)
		{
			_draftList.push("cultist_background");
		}
		
		_draftList.push("flagellant_background");
		_draftList.push("butcher_background");

		if  ( this.World.Assets.getOrigin().getID() == "scenario.cultists") {
			_draftList.push("legend_husk_background");
			_draftList.push("legend_husk_background");
			_draftList.push("legend_lurker_background");
			_draftList.push("legend_lurker_background");
			_draftList.push("legend_lurker_background");
			_draftList.push("legend_lurker_background");
			_draftList.push("legend_magister_background");
		}
	}
});
