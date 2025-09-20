::mods_hookExactClass("entity/tactical/player", function(o) {
	o.m.LevelUpsSpent <- 0;

	o.getMovementSpeedMult <- function()
	{
		return 1.0;
	}

	local setAttributeLevelUpValues = o.setAttributeLevelUpValues;
	o.setAttributeLevelUpValues = function( _v )
	{
		setAttributeLevelUpValues(_v);
		this.m.LevelUpsSpent++;
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function( _out )
	{
		this.getFlags().set("LevelUpsSpent", this.m.LevelUpsSpent);
		onSerialize(_out);
		this.getFlags().remove("LevelUpsSpent");
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function( _in )
	{
		onDeserialize(_in);
		this.m.LevelUpsSpent = this.getFlags().has("LevelUpsSpent") ? this.getFlags().get("LevelUpsSpent") : 0;
	}
});
