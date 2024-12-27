::mods_hookExactClass("items/weapons/named/named_longaxe", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3]
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		//this.addSkill(this.new("scripts/skills/actives/legend_harvest_tree_skill"));
	}
});
