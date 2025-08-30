::mods_hookExactClass("items/weapons/named/named_pike", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1, 2, 3, 4, 5];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Impale, function (_skill) {
			_skill.m.Icon = "skills/active_54.png";
			_skill.m.IconDisabled = "skills/active_54_sw.png";
			_skill.m.Overlay = "active_54";
		}.bindenv(this));
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendHeartseeker, function (_skill) {
			_skill.m.IsPolearm = true;
		}.bindenv(this));
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Repel);
	}
});
