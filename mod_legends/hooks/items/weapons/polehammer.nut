::mods_hookExactClass("items/weapons/polehammer", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 1600;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip()
		::Legends.Actives.grant(this, ::Legends.Active.Impale, function (_skill) {
			_skill.m.Icon = "skills/legend_halberd_impale.png";
			_skill.m.IconDisabled = "skills/legend_halberd_impale_bw.png";
			_skill.m.Overlay = "legend_halberd_impale";
			_skill.m.IsIgnoredAsAOO = true;
		}.bindenv(this));
	}
});
