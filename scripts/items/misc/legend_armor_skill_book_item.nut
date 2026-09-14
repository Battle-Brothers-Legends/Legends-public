this.legend_armor_skill_book_item <- ::inherit("scripts/items/misc/legend_skill_book", {
	m = {
		PerkGroups = ::Const.Perks.DefenseTrees.Tree,
		Cooldown = 50,
		BookName = "A Treatise on Armor:"
	},
	function create()
	{
		this.legend_skill_book.create();
		this.m.ID = "misc.legend_armor_skill_book";
		this.m.Name = "Wearing it well";
		this.m.Description = "A collection of notes of soldiers, craftsmen and armorers, that will explain everything about wearing armor.  Will teach the relevant [color=%negative%]Armor[/color] perk group to the character that uses it.";
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
