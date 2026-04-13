this.legend_profession_skill_book_item <- ::inherit("scripts/items/misc/legend_skill_book", {
	m = {
		PerkGroups = ::Const.Perks.ProfessionTrees.Tree,
		Cooldown = 50,
		BookName = "Guilds and Craftsmanship:"
	},
	function create()
	{
		this.legend_skill_book.create();
		this.m.ID = "misc.legend_profession_skill_book";
		this.m.Name = "Skills for Dummies";
		this.m.Description = "Profession training manual, written by an artisan.  Will teach the relevant [color=%negative%]Class[/color] perk group to the character that uses it.";
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

