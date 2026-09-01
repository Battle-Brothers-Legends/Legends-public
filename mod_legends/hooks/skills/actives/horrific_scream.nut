::mods_hookExactClass("skills/actives/horrific_scream", function(o)
{
	local create = o.create;
	o.create = function() {
		create();
		this.m.Description = "Blare out a piercing, unworldly sound that is more than likely to distress anyone unfortunate enough to hear it within 4 tiles. Uses ranged skill.";
	}
});
