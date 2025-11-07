this.perk_legend_net_casting <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendNetCasting);
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInNetCasting = true;
	}

	function getItemActionCost( _items )
	{
		local nets = 0;
		local notNets = 0;
		foreach (item in _items)
		{
			if (item != null)
			{
				if (item.getID().find("throwing_net") != null)
				{
					nets += 1;
				}
				else
				{
					notNets += 1;
				}
			}
		}

		// Equipping a net into a free offhand (whether from the bag or from the ground) is always free
		if (_items.len() == 3 && nets == 1 && notNets == 0)
			return 0;

		return null;

		// ____What _items may look like in each given scenario____ "(/)" is the scenario we want the free action to apply to
			// (/) Equip net from bag onto free offhand:  ["Reinforced Throwing Net", "null", "null"]
			// Equip net from bag onto offhand with shield: ["Reinforced Throwing Net", "Heater Shield", "null"]
			// Equip net from bag onto offhand with net: ["Reinforced Throwing Net", "Reinforced Throwing Net", "null"]
			// Equip shield from bag onto offhand with net: ["Heater Shield", "Reinforced Throwing Net", "null"]
			// (/) Equip net from ground onto free offhand: ["null", "null", "Reinforced Throwing Net"]
			// Equip net from ground onto offhand with net: ["Reinforced Throwing Net", "null", "Reinforced Throwing Net"]
			// Equip net from ground onto offhand with shield: ["Heater Shield", "null", "Reinforced Throwing Net"]
			// Equip shield from ground onto offhand with net: ["Reinforced Throwing Net", "null", "Heater Shield"]
			// Unequip net from offhand into bag: ["Reinforced Throwing Net", "null"]
			// Unequip net from offhand into bag slot with other net: ["Reinforced Throwing Net", "Reinforced Throwing Net"]
			// Drop net from bag to ground: ["Reinforced Throwing Net", "null"]
			// Drop shield from offhand to ground: ["Heater Shield"]
			// Drop net from offhand to ground: ["Reinforced Throwing Net"]
			// Pick up net from ground into bag: ["Reinforced Throwing Net", "null"]
			// Pick up shield from ground into bag: ["Heater Shield", "null"]
			// Switch shield from bag with net from ground: ["Heater Shield", "Reinforced Throwing Net"]
			// Switch net from bag with shield from ground: ["Reinforced Throwing Net", "Heater Shield"]
	}

	// // For debugging
	// function onPayForItemAction( _skill, _items )
	// {
	// 	local id = _skill == null ? "no skill" : _skill.m.ID;
	// 	::MSU.Log.printData(_items.map(function(i){if(i != null) {return i.getName()} else {return "null"}}));
	// }
});
