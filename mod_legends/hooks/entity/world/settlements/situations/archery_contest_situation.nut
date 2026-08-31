::mods_hookExactClass("entity/world/settlements/situations/archery_contest_situation", function(o)
{
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _draftList )
	{
		::Legends.S.extend(_draftList, ::Legends.Background.LegendMasterArcher, 3);
		onUpdateDraftList(_draftList);
	}
});
