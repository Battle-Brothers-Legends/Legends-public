::mods_hookExactClass("skills/effects/distracted_effect", function(o) {
	
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.IsRemovedAfterBattle = true;
	}
});