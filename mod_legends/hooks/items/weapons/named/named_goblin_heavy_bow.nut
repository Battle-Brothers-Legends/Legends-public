::mods_hookExactClass("items/weapons/named/named_goblin_heavy_bow", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Shortbow;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_piercing_shot_skill"));
		this.addSkill(this.new("scripts/skills/actives/legend_cascade_skill"));
	}
});
