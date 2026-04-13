this.legend_cluster_spider_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.RacialLegendClusterSpider);
		this.m.Name = "Cluster";
		this.m.Description = "TODO";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		local currentPercent = this.getContainer().getActor().getHitpointsPct();
		local bonus = this.Math.floor(100 * (1.0 - currentPercent) / 2.0);
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += bonus;
		_properties.DamageTotalMult *= currentPercent;
		_properties.ThresholdToReceiveInjuryMult *= 0.0;
	}
});

