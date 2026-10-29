::mods_hookExactClass("items/weapons/barbarians/rusty_warblade", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.IsAgainstShields = false;
		this.m.Value = 2400;
		this.m.Condition = 66.0;
		this.m.ConditionMax = 66.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 105;
		this.m.DirectDamageMult = 0.35;
		this.m.DirectDamageAdd = 0.1;
		this.m.ShieldDamage = 0;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/wildmen_08" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/wildmen_08" + v + ".png";
		this.m.ArmamentIcon = "icon_wildmen_08" + v;
	}

	o.onEquip = function () {
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHew, function (_skill) {
			_skill.m.Icon = "skills/active_182.png";
			_skill.m.IconDisabled = "skills/active_182_sw.png";
			_skill.m.Overlay = "active_182";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendHarvest);
		::Legends.Actives.grant(this, ::Legends.Active.LegendExsanguinate);
	}

});
