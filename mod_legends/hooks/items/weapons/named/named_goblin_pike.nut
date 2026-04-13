::mods_hookExactClass("items/weapons/named/named_goblin_pike", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.IsAoE = true;
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendSkewer, function (_skill) {
			_skill.m.Icon = "skills/skewer_general.png";
			_skill.m.IconDisabled = "skills/skewer_general_bw.png";
			_skill.m.Overlay = "skewer_general";
		}.bindenv(this));	
	}

});
