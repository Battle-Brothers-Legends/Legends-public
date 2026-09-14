::mods_hookExactClass("ui/screens/world/modules/world_town_screen/town_temple_dialog_module", function(o) {

	local onTreatInjury = o.onTreatInjury;
	o.onTreatInjury = function ( _data )
	{
		local ret = onTreatInjury(_data);
		local entityID = _data[0];
		local entity = this.Tactical.getEntityByID(entityID);
		::Legends.Effects.grant(entity, ::Legends.Effect.LegendWellTended);
		return ret;
	}
});
