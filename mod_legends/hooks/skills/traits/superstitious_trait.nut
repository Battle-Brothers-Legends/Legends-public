::mods_hookExactClass("skills/traits/superstitious_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This character makes sure to always announce their intentions to his brothers-in-arms. In fact, they\'ll never shut the hell up. At least it reduces the chance of accidents happening.";
		this.m.Excluded.extend([
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack)
		]);
	}
});
