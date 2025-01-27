::mods_hookExactClass("items/weapons/lute", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Categories = "Musical Instrument, Mace, Two-Handed";
		this.m.IsDoubleGrippable = false;
		this.m.Value = 50;
		this.m.Condition = 30.0;
		this.m.ConditionMax = 30.0;
		this.m.RegularDamageMax = 20;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		::Legends.Actives.grant(this, ::Legends.Active.Bash, function (_skill) {
			_skill.m.IsLuteBash = true;
		}.bindenv(this));
		onEquip();
	}
});
