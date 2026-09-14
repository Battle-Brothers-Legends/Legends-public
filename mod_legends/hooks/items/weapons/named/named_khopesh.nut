::mods_hookExactClass("items/weapons/named/named_khopesh", function(o) {

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendDebilitate);
	}


});
