::mods_hookExactClass("items/weapons/barbarians/skull_hammer", function (o) {

	local create = o.create;
	o.create = function () {
		create();
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function () {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/wildmen_07" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/wildmen_07" + v + ".png";
		this.m.ArmamentIcon = "icon_wildmen_07" + v;
	}

	o.addSkill <- function (_skill) {
		this.weapon.addSkill(_skill);
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.SplitShield)) {
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
			_skill.m.IsHammer = true;
		}
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendObliterate);
	}
});
