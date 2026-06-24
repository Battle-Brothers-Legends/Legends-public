::mods_hookExactClass("items/weapons/ancient/ancient_sword", function(o) {
	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Puncture, function(_skill) {
			_skill.m.IsHalfsword = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Hammer, function(_skill) {
			_skill.m.IsMordhau = true;
		}.bindenv(this));
	}

	local create = o.create;
	o.create = function() {
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Riposte))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendGut);
			return;
		}

		weapon.addSkill(_skill);
	}

});
