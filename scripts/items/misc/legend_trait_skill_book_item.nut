this.legend_trait_skill_book_item <- ::inherit("scripts/items/misc/legend_skill_book", {
	m = {
		PerkGroups = ::Const.Perks.TraitsTrees.Tree,
		Cooldown = 50,
		BookName = "Astrology and Tarot Readings:"
	},
	function create()
	{
		this.legend_skill_book.create();
		this.m.ID = "misc.legend_trait_skill_book";
		this.m.Name = "Traits for the gullible";
		this.m.Description = format("A gathering of absolutely correct occult readings that give insight into developing new traits. Will teach the relevant [color=%s]Trait[/color] perk group to the character that uses it.", ::Const.UI.Color.NegativeValue);
		this.m.Icon = "misc/inventory_ledger_item.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsUsable = true;
		this.m.Value = 1500;
		this.m.PerkGroupSelection = this.m.PerkGroups[this.Math.rand(0, this.m.PerkGroups.len() - 1)].Name;
	}

	function addScrollCounter( _actor )
	{
		_actor.getFlags().set("LegendsSkillBookCount", 1);
	}
});
