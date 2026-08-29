::mods_hookExactClass("items/weapons/named/named_goblin_falchion", function(o) {
	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Slash)) {
			::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendBreach, function (_skill) {
				_skill.m.Icon = "skills/active_78.png";
				_skill.m.IconDisabled = "skills/active_78_sw.png";
				_skill.m.Overlay = "active_78";
			}.bindenv(this));
			return;
		}

		this.weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Gash);
	}

	local create = o.create;
	o.create = function() {
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
	}

});
