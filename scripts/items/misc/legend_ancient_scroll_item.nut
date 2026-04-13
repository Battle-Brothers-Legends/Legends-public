this.legend_ancient_scroll_item <- ::inherit("scripts/items/misc/legend_skill_book", {
	m = {
		PerkGroups = ::Const.Perks.MagicTrees.Tree,
		Cooldown = 100,
		HasToBeIdentified = true,
		BookName = "Ancient Scroll:"
	},
	function create()
	{
		this.legend_skill_book.create();
		this.m.ID = "misc.legend_ancient_scroll";
		this.m.Name = "Ancient Scroll";
		this.m.Description = "A torn-up scroll with knowledge unseen for centuries. It can be translated by a character with the interpretation perk in the crafting tent. Highly valuable to some historians, although it is useless to many. They can, however, be studied with effort and a high chance of headache. Every brother may use up to 1 scroll. Being bright increases this to 2 scrolls, and being dumb decreases this to 0 scrolls.";
		this.m.Icon = "trade/scroll.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsUsable = true;
		this.m.Value = 5000;
		this.m.PerkGroupSelection = this.m.PerkGroups[this.Math.rand(0, this.m.PerkGroups.len() - 1)].Name;
	}

	function isAbleToUseScroll( _actor )
	{
		local effect = ::Legends.Effects.get(_actor, ::Legends.Effect.LegendIrritable);
		local injury = ::Legends.Effects.get(_actor, ::Legends.Effect.LegendHeadache);
		if (injury != null)
			return "Failed to use this item as the user will be recovering from the last reading for another [color=%negative%]" + injury.m.HealingTimeMin + "-" + injury.m.HealingTimeMax +"[/color] days because of [color=%status%]" + injury.getName() + "[/color].";
		if (effect != null)
			return "Failed to use this item as the user will be recovering from the last reading for another [color=%negative%]" + effect.m.HealingTime + "[/color] days because of [color=%status%]" + effect.getName() + "[/color].";

		if (_actor.getSkills().hasTrait(::Legends.Trait.Dumb))
			return "Failed to use this item as the user has [color=%negative%]Dumb[/color] trait.";

		if (_actor.getSkills().hasSkill("injury.brain_damage"))
			return "Failed to use this item as the user has [color=%negative%]Brain Damage[/color] injury.";

		if (_actor.isStabled())
			return "Are you trying to make an animal read?";

		if (_actor.getFlags().getAsInt("LegendsScrollCount") < 1)
			return true;

		if (_actor.getSkills().hasTrait(::Legends.Trait.Bright) && _actor.getFlags().getAsInt("LegendsScrollCount") < 2)
			return true;

		return "This character cannot potentially learn anything from this.";
	}


	function addScrollCounter( _actor ) {
		_actor.getFlags().increment("LegendsScrollCount");
	}
});

