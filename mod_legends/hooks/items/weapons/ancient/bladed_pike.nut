::mods_hookExactClass("items/weapons/ancient/bladed_pike", function(o) {
	o.onEquip = function()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Impale, function (_skill) {
			_skill.m.Icon = "skills/active_54.png";
			_skill.m.IconDisabled = "skills/active_54_sw.png";
			_skill.m.Overlay = "active_54";
		}.bindenv(this));
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendHeartseeker);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Repel);
	}
});
