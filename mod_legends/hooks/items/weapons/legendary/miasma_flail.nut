::mods_hookExactClass("items/weapons/legendary/miasma_flail", function(o) {
	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.CenserStrike);
		::Legends.Actives.grant(this, ::Legends.Active.LegendRangedLash);
		::Legends.Actives.grant(this, ::Legends.Active.CenserCastigate);
	}
});
