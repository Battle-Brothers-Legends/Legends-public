::mods_hookExactClass("skills/traits/iron_jaw_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This character shakes off hits that would cripple a lesser character.";
		this.m.Excluded.push(::Legends.Traits.getID(::Legends.Trait.LegendSlack));
	}
});
