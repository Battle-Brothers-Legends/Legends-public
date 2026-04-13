this.legend_enemy_skill_book_item <- ::inherit("scripts/items/misc/legend_skill_book", {
	m = {
		PerkGroups = ::Const.Perks.EnemyTrees.Tree,
		Cooldown = 50,
		BookName = "Foes and their Weaknesses:"
	},
	function create()
	{
		this.legend_skill_book.create();
		this.m.ID = "misc.legend_enemy_skill_book";
		this.m.Name = "101: How to fight x";
		this.m.Description = "Compendium in fighting particular enemies and their relevant weak spots.  Will teach the relevant [color=%negative%]Enemy[/color] perk group to the character that uses it.";
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
