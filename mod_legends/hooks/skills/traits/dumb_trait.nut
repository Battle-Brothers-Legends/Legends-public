::mods_hookExactClass("skills/traits/dumb_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Umm, what? This character isn\'t the brightest, and new concepts take a while to really stick with them.";
		this.m.Excluded.extend(
		[
			"trait.legend_unpredictable",
			"trait.legend_natural"
		]);
	}
});
