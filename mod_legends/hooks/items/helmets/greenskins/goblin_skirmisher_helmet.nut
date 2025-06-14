::mods_hookExactClass("items/helmets/greenskins/goblin_skirmisher_helmet", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		local variants = [1,2,3,4,5,10,11,12,13,14];
		this.m.Variant = variants[this.Math.rand(0, variants.len()-1)];
		if (this.m.Variant == 5) {
			local subV = [5,6,7,8,9];
			this.m.Variant = subV[this.Math.rand(0, subV.len()-1)];
		}
		this.updateVariant();
	}

	o.updateVariant = function () {
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "bust_goblin_04_helmet_" + variant;
		this.m.SpriteDamaged = "bust_goblin_04_helmet_" + variant + "_damaged";
		this.m.SpriteCorpse = "bust_goblin_04_helmet_" + variant + "_dead";
	}
});
