::mods_hookExactClass("items/weapons/short_sword", function(o) {
	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		local s = this.new("scripts/skills/actives/bash");
		s.m.IsSwordBash = true;
		this.addSkill(s);
		onEquip();
	}
});
