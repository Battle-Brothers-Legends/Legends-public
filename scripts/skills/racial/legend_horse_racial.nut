this.legend_horse_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.legend_horse";
		this.m.Name = "Horse Movement";
		this.m.Description = "A horse moves much better on flat terrain, but worse on rough terrain";
		this.m.Icon = "ui/perks/perk_23.png";
		this.m.Type = ::Const.SkillType.Racial | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = ::Const.HorseMovementAPCost;
		actor.m.FatigueCosts = clone ::Const.HorseMovementFatigueCost;
	}

});

