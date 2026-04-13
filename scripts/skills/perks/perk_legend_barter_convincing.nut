this.perk_legend_barter_convincing <- this.inherit("scripts/skills/skill", {
	m = {
		Amount = 0.01
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBarterConvincing);
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
