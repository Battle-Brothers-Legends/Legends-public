::mods_hookExactClass("items/weapons/named/named_warbow", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.TwoHanded;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_piercing_shot_skill"));
		this.addSkill(this.new("scripts/skills/actives/legend_cascade_skill"));
	}
});
