::mods_hookExactClass("skills/traits/superstitious_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "It\'s cursed! This character is highly superstitious and therefore more vulnerable to skills that directly attack their Resolve.";
		this.m.Excluded.extend([
			"trait.legend_double_tongued",
			"trait.legend_slack"
		]);
	}
});
