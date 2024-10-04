this.perk_legend_legend_horse_movement <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_horse_movment";
		this.m.Name = this.Const.Strings.PerkName.LegendHorseMovement;
		this.m.Description = this.Const.Strings.PerkDescription.LegendHorseMovement;
		this.m.Icon = "ui/perks/perk_23.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.Const.HorseMovementAPCost;
		actor.m.FatigueCosts = clone this.Const.HorseMovementFatigueCost;
	}

});

