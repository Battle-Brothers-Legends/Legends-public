this.perk_legend_spawn_skeleton_high <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendSpawnSkeletonHigh);
		this.m.Icon = "ui/perks/possess56.png";
		this.m.IconDisabled = "ui/perks/possess56_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUnlocked()
	{
		local stash = this.World.Assets.getStash()
		stash.add(this.new("scripts/items/spawns/skeleton_item"));
		stash.add(this.new("scripts/items/spawns/skeleton_item"));
		stash.add(this.new("scripts/items/spawns/skeleton_item"));
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_spawn_skeleton_high"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_spawn_skeleton_high_skill"));
			this.m.Container.add(this.new("scripts/skills/actives/legend_spawn_skeleton_high_archer_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_spawn_skeleton_high");
		this.m.Container.removeByID("actives.legend_spawn_skeleton_high_archer");
	}

});
