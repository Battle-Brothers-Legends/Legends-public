::mods_hookExactClass("factions/noble_faction", function(o) 
{
	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		onDeserialize( _in );

		if (this.getAction("send_caravan_action") == null)
		{
			local card = this.new("scripts/factions/actions/send_caravan_action");
			card.setFaction(this);
			this.m.Deck.push(card);
		}
	}
});