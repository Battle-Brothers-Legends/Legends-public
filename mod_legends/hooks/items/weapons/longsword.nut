::mods_hookExactClass("items/weapons/longsword", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Name = "Greatsword";
		this.m.Description = "A long two-handed greatsword as good for crushing as for cutting, it has a good balance between the lighter longsword and heavier zweihander.";
		this.m.IconLarge = "weapons/melee/sword_two_hand_01.png";
		this.m.Icon = "weapons/melee/sword_two_hand_01_70x70.png";
		this.m.ArmamentIcon = "icon_sword_two_handed_01";
		this.m.Value = 2300;
		this.m.ConditionMax = 64.0;
		this.m.ChanceToHitHead = 10;
	}
});
