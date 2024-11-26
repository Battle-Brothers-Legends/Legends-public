this.perk_legend_spawn_zombie_low <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendSpawnZombieLow);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUnlocked()
	{
		local stash = this.World.Assets.getStash()
		stash.add(this.new("scripts/items/spawns/legend_zombie_item"));
		stash.add(this.new("scripts/items/spawns/legend_zombie_item"));
		stash.add(this.new("scripts/items/spawns/legend_zombie_item"));
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_spawn_zombie_low_skill"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_spawn_zombie_low_skill"));
			//this.m.Container.add(this.new("scripts/skills/actives/legend_spawn_zombie_low_xbow_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_spawn_zombie_low_skill");
		//this.m.Container.removeByID("actives.legend_spawn_zombie_low_xbow_skill");
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints += 20;
	}

});
