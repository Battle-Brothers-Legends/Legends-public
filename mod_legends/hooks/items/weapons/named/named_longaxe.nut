::mods_hookExactClass("items/weapons/named/named_longaxe", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		//this.addSkill(this.new("scripts/skills/actives/legend_harvest_tree_skill"));
	}
});
