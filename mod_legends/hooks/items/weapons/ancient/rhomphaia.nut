::mods_hookExactClass("items/weapons/ancient/rhomphaia", function (o) {
	o.addSkill <- function (_skill) {
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Slash)) {
			::Legends.Actives.grant(this, ::Legends.Active.LegendBreach, function (_skill) {
				_skill.m.IsGreatBreachSlash = true;
				_skill.m.Icon = "skills/legend_rhomphaia_breach.png";
				_skill.m.IconDisabled = "skills/legend_rhomphaia_breach_bw.png";
				_skill.m.Overlay = "legend_rhomphaia_breach";
			}.bindenv(this));
			return;
		}

		this.weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendIntoTheFray);
	}
});
