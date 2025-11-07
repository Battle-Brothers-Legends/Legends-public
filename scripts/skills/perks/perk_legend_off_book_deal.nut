this.perk_legend_off_book_deal <- this.inherit("scripts/skills/skill", {
	m = {
        BarterModifier = -0.01,
        SituationDuration = 3
    },
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendOffBookDeal);
	}

    function countAllOffBookDealer()
    {
		local roster = this.World.getPlayerRoster().getAll();
        local numberOfOffBookDealer = 0;
		foreach (bro in roster)
		{
			if(bro.getSkills().hasPerk(::Legends.Perk.LegendOffBookDeal))
				++numberOfOffBookDealer;
		}
        return numberOfOffBookDealer;
    }

    function getModifier()
    {
        return this.m.BarterModifier;
    }

    function onEnterSettlement ( _settlement )
	{
        _settlement.updateSituations();   // cleans up all expired situations
        if(_settlement.getSituations().len() == 0)
        {
            local offBookSituation = this.new("scripts/entity/world/settlements/situations/legends_off_book_deal_situation");
            offBookSituation.setStacks(this.countAllOffBookDealer());
            _settlement.addSituation(offBookSituation, this.m.SituationDuration);
        }
	}
});

