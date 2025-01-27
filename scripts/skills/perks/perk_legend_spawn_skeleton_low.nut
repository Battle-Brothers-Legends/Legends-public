this.perk_legend_spawn_skeleton_low <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpawnSkeletonLow);
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
		this.World.Assets.addMedicine(30);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendSpawnSkeletonLow))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendSpawnSkeletonLow);
			::Legends.Actives.grant(this, ::Legends.Active.LegendSpawnSkeletonLowArcher);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendSpawnSkeletonLow);
		::Legends.Actives.remove(this, ::Legends.Active.LegendSpawnSkeletonLowArcher);
	}

});
