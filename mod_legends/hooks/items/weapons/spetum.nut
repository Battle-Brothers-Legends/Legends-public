::mods_hookExactClass("items/weapons/spetum", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/spetum_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/spetum_01" + v + ".png";
		this.m.ArmamentIcon = "icon_spetum_01" + v;
	}

	o.onEquip = function ()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Prong);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendHeartseeker, function (_skill) {
			_skill.m.IsTwoHanded = true;
		}.bindenv(this));
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendSkewer, function (_skill)
		{
			_skill.m.Icon = "skills/skewer_spetum.png";
			_skill.m.IconDisabled = "skills/skewer_spetum_bw.png";
			_skill.m.Overlay = "skewer_spetum";
			_skill.m.IsSpearSkewer = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Spearwall, function (_skill) {
			_skill.m.Icon = "skills/active_124.png";
			_skill.m.IconDisabled = "skills/active_124_sw.png";
			_skill.m.Overlay = "active_124";
			_skill.m.BaseAttackName = "Prong";
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
			_skill.m.ActionPointCost = 6;
		}.bindenv(this));
	}

});
