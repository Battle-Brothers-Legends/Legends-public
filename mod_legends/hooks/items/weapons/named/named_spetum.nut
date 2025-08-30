::mods_hookExactClass("items/weapons/named/named_spetum", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2]
	}

	o.onEquip = function ()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Prong);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendHeartseeker, function (_skill) {
			_skill.m.IsTwoHanded = true;
		}.bindenv(this));
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendSkewer, function (_skill)
		{
			_skill.m.Icon = "skills/skewer_spetum.png";
			_skill.m.IconDisabled = "skills/skewer_spetum_sw.png";
			_skill.m.Overlay = "skewer_spetum";
		}.bindenv(this));
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Spearwall, function (_skill) {
			_skill.m.Icon = "skills/active_124.png";
			_skill.m.IconDisabled = "skills/active_124_sw.png";
			_skill.m.Overlay = "active_124";
			_skill.m.BaseAttackName = "Prong";
			_skill.setFatigueCost(spearwall.getFatigueCostRaw() + 5);
			_skill.m.ActionPointCost = 6;
		}.bindenv(this));
	}
});
