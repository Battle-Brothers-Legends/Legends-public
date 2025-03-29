this.legend_scroll_item <- ::inherit("scripts/items/misc/legend_ancient_scroll_item", {
	m = {},
	function create()
	{
		this.legend_ancient_scroll_item.create();
		m.ID = "misc.legend_scroll";
		m.Name = "Ability Scroll";
		m.Description = "A Scroll which can unlock new abilities on mercenaries";
		m.Selection = ::Math.rand(0, 4);
		m.Value = 1000;
	}

	function getValue()
	{
		if (m.Selection == null || m.Selection == 0)
			return 0;

		return this.item.getValue();
	}

	function getName()
	{
		switch(m.Selection)
		{
		case 1:
			return "Scroll of Natural Talent";

		case 2:
			return "Battle Scroll";

		case 3:
			return "Random Perk Scroll";

		case 4:
			return "Scroll of Technique";

		default:
			return "Scroll of .Nut\'in";
		}
	}

	function getDescription()
	{
		switch(m.Selection)
		{
		case 1:
			return "Use the scroll to grant a character a max-stat roll similar to gifted";

		case 2:
			return "Use the scroll on a character to increase experience gains by +50% for at least the next 3 battles. This will override any other current trained effects.";

		case 3:
			return "Use the scroll on a character to grant them 1 free perk from their own tree";

		case 4:
			return "Use the scroll to add a perk group to one character\'s tree";

		default:
			return "After a bit of labor the scroll seems to just be gibberish, nothing meaningful could be translated";
		}
	}

	function onSerialize( _out )
	{
		this.legend_ancient_scroll_item.onSerialize(_out);
		_out.writeU8(m.Selection);
	}

	function onDeserialize( _in )
	{
		this.legend_ancient_scroll_item.onDeserialize(_in);
		m.Selection = _in.readU8();
	}

});

