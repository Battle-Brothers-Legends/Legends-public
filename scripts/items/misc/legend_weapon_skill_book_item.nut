this.legend_weapon_skill_book_item <- ::inherit("scripts/items/misc/legend_skill_book", {
	m = {
		PerkGroups = ::Const.Perks.WeaponTrees.Tree,
		Cooldown = 50,
		BookName = "Fencing Treatise:"
	},
	function create()
	{
		this.legend_skill_book.create();
		this.m.ID = "misc.legend_weapon_skill_book";
		this.m.Name = "De Re Military";
		this.m.Description = "A training manual written by a fencing master. Will teach the relevant [color=%negative%]Weapon[/color] perk group to the character that uses it.";
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

