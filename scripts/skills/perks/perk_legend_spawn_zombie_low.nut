this.perk_legend_spawn_zombie_low <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_spawn_zombie_low";
		this.m.Name = this.Const.Strings.PerkName.LegendSpawnZombieLow;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpawnZombieLow;
		this.m.Icon = "ui/perks/possess56.png";
		this.m.IconDisabled = "ui/perks/possess56_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_spawn_zombie_low_skill"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_spawn_zombie_low_skill"));
			local stash = this.World.Assets.getStash()
			stash.add(this.new("scripts/items/spawns/zombie_item"));
			stash.add(this.new("scripts/items/spawns/zombie_item"));
			stash.add(this.new("scripts/items/spawns/zombie_item"));
			this.World.Assets.addMedicine(30);
		}
	}
	
	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_spawn_zombie_low_skill");
	}

});
