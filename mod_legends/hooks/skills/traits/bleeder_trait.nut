::mods_hookExactClass("skills/traits/bleeder_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Survivor),
			::Legends.Traits.getID(::Legends.Trait.Bleeder)
		];
	}
});
