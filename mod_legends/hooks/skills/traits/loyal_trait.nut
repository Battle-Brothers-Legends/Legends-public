::mods_hookExactClass("skills/traits/loyal_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "I\'m with you! This character is loyal to the end and much less likely to leave you even if you run out of crowns and provisions. This character cannot be charmed.";
		this.m.Excluded.push(::Legends.Traits.getID(::Legends.Trait.LegendSlack));
	}
});
