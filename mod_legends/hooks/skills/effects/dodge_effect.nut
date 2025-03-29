::mods_hookExactClass("skills/effects/dodge_effect", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		m.IsRemovedAfterBattle = false;
		m.IsSerialized = false;
	}
});