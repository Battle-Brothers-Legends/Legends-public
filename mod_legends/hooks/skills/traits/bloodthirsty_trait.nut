::mods_hookExactClass("skills/traits/bloodthirsty_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This character is prone to excessive violence and cruelty towards his enemies. An opponent isn\'t good enough dead, his head needs to be on a spike!";
		this.m.Excluded.push(::Legends.Traits.getID(::Legends.Trait.LegendFearNobles));
	}
});
