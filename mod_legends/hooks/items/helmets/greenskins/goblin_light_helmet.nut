::mods_hookExactClass("items/helmets/greenskins/goblin_light_helmet", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Variant = this.Math.rand(4, 20);
		this.updateVariant();
	}

	o.updateVariant = function () {
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "bust_goblin_01_helmet_" + variant;
		this.m.SpriteDamaged = "bust_goblin_01_helmet_" + variant + "_damaged";
		this.m.SpriteCorpse = "bust_goblin_01_helmet_" + variant + "_dead";
	}

	o.onUpdateProperties <- function ( _properties ) {
		this.helmet.onUpdateProperties(_properties);
		_properties.IsAffectedByRain = false;
	}
});
