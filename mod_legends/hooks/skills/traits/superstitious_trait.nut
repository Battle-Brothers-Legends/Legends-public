::mods_hookExactClass("skills/traits/superstitious_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "It\'s cursed! This character is highly superstitious and therefore more vulnerable to skills that directly attack their Resolve.";
		this.m.Excluded.extend([
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack)
		]);
	}
});
