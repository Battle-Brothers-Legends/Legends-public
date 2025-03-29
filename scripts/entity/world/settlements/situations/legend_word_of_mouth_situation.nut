this.legend_word_of_mouth_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.legend_word_of_mouth";
		this.m.Name = "Word of Mouth";
		this.m.Description = "Locals witnessed your recent exploits and are singing your praises. Merchants are eager to give you a discount, and some starry-eyed locals are hoping to join your company.";
		this.m.Icon = "ui/traits/trait_seductive.png";
		this.m.Rumors = [
			"Say, aren\'t you one of the %companyname%? I heard about the things you lot did for %settlement% recently. Would be nice if you could do the same for our town too.",
			"A couple of young \'uns passed by on their way to %settlement% recently. Said they\'d heard the %companyname% had done some good work there, and wanted to join up."
		];
		this.m.IsStacking = false;
	}

	function getAddedString( _s )
	{
		return _s + " now has " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer has " + this.m.Name;
	}

	function onAdded( _settlement )
	{
		_settlement.resetRoster(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.BuyPriceMult *= 0.90;
		_modifiers.RecruitsMult *= 1.50;
	}

});

