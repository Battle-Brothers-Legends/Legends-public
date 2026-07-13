::mods_hookExactClass("items/misc/miracle_drug_item", function(o) {
	local onUse = o.onUse;
	o.onUse = function ( _actor, _item = null ) {
		local ret = onUse( _actor, _item = null );
		::Legends.Effects.remove(_actor, ::Legends.Effect.LegendHeadache);
		::Legends.Effects.remove(_actor, ::Legends.Effect.LegendIrritable);
		return ret;
	}
});
