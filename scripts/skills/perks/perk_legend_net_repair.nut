this.perk_legend_net_repair <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendNetRepair);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local item = getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(this.Const.Items.ItemType.Net))
			_properties.MeleeDefense += 10;
	}

	function onNewDay()
	{
		if (getContainer().getSkillsByFunction(function( _skill ) { // check whether there is any untreated injury or not
			return _skill.isType(::Const.SkillType.Injury) && !_skill.isType(::Const.SkillType.PermanentInjury) && !_skill.isTreated();
		}).len() > 0)
			return;

		if (::World.Assets.getStash().removeByID("tool.legend_broken_throwing_net") != null) // trying to remove a broken from stash
			::World.Assets.getStash().add(::new("scripts/items/tools/throwing_net")); // successfully repaired it lol
	}

});
