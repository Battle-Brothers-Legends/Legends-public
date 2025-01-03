::mods_hookExactClass("items/helmets/named/named_helmet", function(o) {
	o.randomizeValues = function () {
		this.m.StaminaModifier = this.Math.min(-4, this.m.StaminaModifier + this.Math.rand(1, 4));
		this.m.Condition = this.Math.floor(this.m.Condition * this.Math.rand(120, 135) * 0.01) * 1.0; //was 110, 125 on 26/10/22 - Luft
		this.m.ConditionMax = this.m.Condition;
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in ) {
		onDeserialize(_in);
		if (this.isRuned())
			this.updateRuneSigil();
	}
});
