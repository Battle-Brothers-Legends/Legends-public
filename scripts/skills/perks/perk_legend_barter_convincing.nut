this.perk_legend_barter_convincing <- this.inherit("scripts/skills/skill", {
	m = {
		Amount = 0.01
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendBarterConvincing);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getModifier()
	{
		return this.m.Amount;
	}

	function onAdded()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}
		this.World.State.getPlayer().calculateBarterMult();
	}

	function onRemoved()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}
		this.World.State.getPlayer().calculateBarterMult();
	}

	function onNewDay()
	{
		local bonus = 10 + this.getContainer().getActor().getLevel();
		::World.Assets.addMoney(bonus);
	}

	function onUpdate( _properties )
	{
		_properties.DailyWageMult *= 1.1;
	}
});
